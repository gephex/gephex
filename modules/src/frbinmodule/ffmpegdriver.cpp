/* This source file is a part of the GePhex Project.

 Copyright (C) 2001-2008

 Georg Seidel <georg@gephex.org> 
 Martin Bayer <martin@gephex.org> 
 Phillip Promesberger <coma@gephex.org>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.*/

#include <cstring>
#include "ffmpegdriver.h"

#include <string>
#include <stdexcept>
#include <sstream>
#include <memory>
#include <algorithm>
#include <iostream>
#include <cassert>
#include <cmath>

extern "C"
{
#include "libavformat/avformat.h"
#include "libavcodec/avcodec.h"
#include "libavutil/avutil.h"
#include "libavutil/imgutils.h"
#include "libswscale/swscale.h"
}

#include "libscale.h"

//----------------------------------------------------------------------

static int estimate_duration(AVFormatContext* av_fc, int stream_index,
                             double fps,
                             double* duration,
                             double* start_time);

static AVCodecContext* open_stream(AVFormatContext* av_fc, int stream_index);

static int seek_to_second(AVFormatContext* st, int stream_index, double sec);

//----------------------------------------------------------------------

/**
 * Fetches the next decoded frame, feeding the decoder with packets of the
 * video stream as needed.
 *
 * \param tmp scratch frame. avcodec_receive_frame() clears its frame
 *        argument even if it fails, but frame must keep the last picture
 *        at the end of the stream.
 *
 * \returns 1 if a frame was stored in frame, 0 at the end of the stream
 *          and -1 on error.
 */
static int next_frame(AVFormatContext* fc, AVCodecContext* dec,
                      int video_stream_index, AVPacket* pkt, AVFrame* frame,
                      AVFrame* tmp)
{
  for (;;)
    {
      int ret = avcodec_receive_frame(dec, tmp);

      if (ret == 0)
        {
          av_frame_unref(frame);
          av_frame_move_ref(frame, tmp);
          return 1;
        }
      if (ret == AVERROR_EOF)
        return 0;
      if (ret != AVERROR(EAGAIN))
        {
          std::cerr << "Error while decoding frame\n";
          return -1;
        }

      // the decoder needs more input
      ret = av_read_frame(fc, pkt);
      if (ret < 0)
        {
          // enter draining mode to get the delayed frames
          avcodec_send_packet(dec, 0);
          continue;
        }

      if (pkt->stream_index == video_stream_index)
        {
          ret = avcodec_send_packet(dec, pkt);
          // A damaged packet must not stop the playback
          if (ret < 0 && ret != AVERROR(EAGAIN) && ret != AVERROR_EOF)
            std::cerr << "Error while sending packet to decoder\n";
        }

      av_packet_unref(pkt);
    }
}

/**
 * Decodes frames until the one that is displayed at wanted_timestamp.
 *
 * \param timestamp in: the timestamp of the frame that was decoded last
 *        (used if a frame has no timestamp), out: the timestamp of the frame
 *        that is stored in frame
 * \param first_timestamp out: the timestamp of the first decoded frame
 *
 * \returns 1 on success, -1 if no frame could be decoded
 */
static int decode_to_timestamp(AVFormatContext* fc, AVCodecContext* dec,
                               int video_stream_index,
                               double wanted_timestamp, double fps,
                               AVPacket* pkt, AVFrame* frame, AVFrame* tmp,
                               double* timestamp, double* first_timestamp)
{
  const double frame_duration = 1.0 / fps;

  AVStream* video_stream = fc->streams[video_stream_index];
  const double time_base = av_q2d(video_stream->time_base);

  double current_timestamp = *timestamp;
  bool got_frame = false;

  // Stops as soon as the wanted frame is reached. If the decoding started
  // behind the wanted position the first frame is the best we can get.
  while (!got_frame || current_timestamp < wanted_timestamp - 0.5*frame_duration)
    {
      int ret = next_frame(fc, dec, video_stream_index, pkt, frame, tmp);

      if (ret < 0)
        return -1;

      if (ret == 0)
        {
          // The estimated length can be slightly off, the last frame
          // that was decoded is the closest one then.
          if (got_frame)
            break;
          return -1;
        }

      if (frame->best_effort_timestamp == AV_NOPTS_VALUE)
        current_timestamp += frame_duration;
      else
        current_timestamp = ((double) frame->best_effort_timestamp)*time_base;

#if defined FFMPEGDRIVER_PRINT_DEBUG
      std::cout << "   decoded " << current_timestamp << " s\n";
#endif

      if (!got_frame)
        *first_timestamp = current_timestamp;

      got_frame = true;
    }

  *timestamp = current_timestamp;
  return 1;
}

/**
 * Positions the demuxer at the very beginning of the file.
 */
static int rewind_file(AVFormatContext* fc, int video_stream_index)
{
  // Seeking by timestamp is unreliable for formats with timestamp
  // discontinuities (mpeg-ps/-ts), ffplay seeks by bytes in that case, too.
  if ((fc->iformat->flags & AVFMT_TS_DISCONT)
      && !(fc->iformat->flags & AVFMT_NO_BYTE_SEEK)
      && strcmp(fc->iformat->name, "ogg") != 0
      && av_seek_frame(fc, -1, 0, AVSEEK_FLAG_BYTE) >= 0)
    return 0;

  AVStream* stream = fc->streams[video_stream_index];
  int64_t start = (stream->start_time == AV_NOPTS_VALUE) ? 0
                                                         : stream->start_time;

  return av_seek_frame(fc, video_stream_index, start, AVSEEK_FLAG_BACKWARD);
}


namespace
{
  bool is_big_endian()
  {
    const int test = 0x01020304;
    const unsigned char* mask = reinterpret_cast<const unsigned char*>(&test);
    return mask[0] == 0x01;
  }

  void switch_byteorder(uint32_t& v)
  {
    uint32_t tmp;

    const unsigned char* src = reinterpret_cast<unsigned char*>(&v);
    unsigned char* dst = reinterpret_cast<unsigned char*>(&tmp);

    dst[0] = src[3];
    dst[1] = src[2];
    dst[2] = src[1];
    dst[3] = src[0];

    v = tmp;
  }
}

//----------------------------------------------------------------------

struct FFMpegDriverImpl
{
  FFMpegDriverImpl()
    : av_fc(0), m_dec(0), m_sws(0), file_name(""),
      m_width(0), m_height(0), m_num_frames(0),
      video_stream_index(-1), m_frame(0), m_tmp_frame(0), m_pkt(0), m_fps(25),
      m_scale_buf(0), m_scale_buf_size(0),
      m_start_time(0), m_current_timestamp(0), m_last_frame(-1)
  {
  }

  ~FFMpegDriverImpl()
  {
    close();
  }

  void open(const std::string& filename, VideoInfo& info)
  {
    std::cerr << "load_file_start:'" << filename << "'\n";

    // open input file without format or bufffer size
    // (let ffmpeg try autodetection)
    int err = avformat_open_input(&av_fc, filename.c_str(), 0, 0);

    if (err < 0)
      {
        std::cerr << "err = " << err << "\n";
        av_fc = 0;
        throw std::runtime_error("could not open file");
      }

    // Containers like avi store no presentation timestamps. Without them
    // the timestamps of reordered frames (B-frames) are wrong, and seeking
    // to a frame number would end up at the wrong frame.
    av_fc->flags |= AVFMT_FLAG_GENPTS;

    err = avformat_find_stream_info(av_fc, 0);
    if (err < 0)
      {
        close();
        throw std::runtime_error("Could not find codec parameters\n");
      }

    // look for the video stream
    int stream_index = av_find_best_stream(av_fc, AVMEDIA_TYPE_VIDEO,
                                           -1, -1, 0, 0);

    if (stream_index < 0)
      {
        close();
        throw std::runtime_error("Could not find any video streams in file");
      }

    // some debug info
    av_dump_format(av_fc, 0, filename.c_str(), 0);

    try
      {
        m_dec = open_stream(av_fc, stream_index);
        video_stream_index = stream_index;
      }
    catch (...)
      {
        close();
        throw;
      }

    if (m_dec->width == 0)
      {
        close();
        throw std::runtime_error("No width and height");
      }

    AVStream* video_stream = av_fc->streams[video_stream_index];

    AVRational frame_rate = av_guess_frame_rate(av_fc, video_stream, 0);
    m_fps = (frame_rate.num > 0 && frame_rate.den > 0) ? av_q2d(frame_rate)
                                                       : 25;

    double duration_s;
    int ret = estimate_duration(av_fc, video_stream_index, m_fps,
                                &duration_s, &m_start_time);
    if (ret < 0)
      {
        close();
        throw std::runtime_error("Could not estimate stream duration");
      }

    m_frame     = av_frame_alloc();
    m_tmp_frame = av_frame_alloc();
    m_pkt       = av_packet_alloc();
    if (m_frame == 0 || m_tmp_frame == 0 || m_pkt == 0)
      {
        close();
        throw std::runtime_error("Could not allocate frame");
      }

    // Frame 0 is the first frame that is displayed, which is not
    // necessarily at the start time of the stream (e.g. avi with b-frames).
    // This also leaves the first frame decoded in m_frame.
    const double stream_end = m_start_time + duration_s;
    m_current_timestamp = m_start_time;
    double first_timestamp = m_start_time;
    if (rewind_file(av_fc, video_stream_index) < 0
        || (avcodec_flush_buffers(m_dec),
            decode_to_timestamp(av_fc, m_dec, video_stream_index,
                                m_start_time, m_fps, m_pkt, m_frame,
                                m_tmp_frame, &m_current_timestamp,
                                &first_timestamp)) < 0)
      {
        close();
        throw std::runtime_error("Could not decode the first frame");
      }

    m_start_time = first_timestamp;
    m_current_timestamp = first_timestamp;
    m_last_frame = 0;
    duration_s = stream_end - m_start_time;

    int num_frames = static_cast<int>(floor(m_fps * duration_s + 0.5));
    if (num_frames < 1)
      num_frames = 1;

    info.width  = m_dec->width;
    info.height = m_dec->height;
    info.num_frames = num_frames;

    m_width  = info.width;
    m_height = info.height;
    m_num_frames = info.num_frames;

    std::cout << "(width x height) = (" << info.width
              << "x" << info.height <<")\n";
    std::cout << "#frames = " << info.num_frames << "\n";

    std::cout << "duration  : " << duration_s << " s\n";
    std::cout << "start_time: " << m_start_time << " s\n";
    std::cout << "fps       : " << m_fps << "\n";

    std::cout << "timebase  : "
              << av_q2d(video_stream->time_base) << "\n";

    file_name = filename;

    m_scale_buf = 0;
    m_scale_buf_size = 0;
  }

  void close()
  {
    if (m_scale_buf)
      {
        delete[] m_scale_buf;
        m_scale_buf = 0;
      }

    av_frame_free(&m_frame);
    av_frame_free(&m_tmp_frame);
    av_packet_free(&m_pkt);
    avcodec_free_context(&m_dec);
    video_stream_index = -1;

    if (m_sws != 0)
      {
        sws_freeContext(m_sws);
        m_sws = 0;
      }

    if ( av_fc != 0 )
      avformat_close_input(&av_fc);

    file_name           = "";
    m_width = m_height  = m_num_frames = 0;
    m_scale_buf_size    = 0;
    m_current_timestamp = 0;
    m_start_time        = 0;
    m_last_frame        = -1;
  }

  bool is_open() const
  {
    return av_fc != 0;
  }

  int num_frames() const
  {
    return m_num_frames;
  }

  void decode_frame(unsigned int frame_number,
                    uint_32* framebuffer,
                    int width, int height)
  {
    assert(av_fc != 0);

    // The frame is still in m_frame if it is requested again, which
    // happens all the time if the playback speed is low.
    if (static_cast<int>(frame_number) != m_last_frame)
      {
        // invalid until the decoding succeeded
        m_last_frame = -1;
        seek_and_decode(frame_number);
        m_last_frame = frame_number;
      }

    uint_8* dst_data[4] = { 0, 0, 0, 0 };
    int dst_linesize[4] = { 0, 0, 0, 0 };

    int cwidth  = m_frame->width;
    int cheight = m_frame->height;

    if (cwidth == width && cheight == height)
      {
        dst_data[0] = (uint_8*) framebuffer;
      }
    else
      {
        int size = cwidth*cheight*4;
        if (m_scale_buf == 0 || m_scale_buf_size < size)
          {
            if (m_scale_buf)
              delete[] m_scale_buf;

            m_scale_buf = new uint_8[size];
            m_scale_buf_size = size;
          }
        dst_data[0] = m_scale_buf;
      }

    dst_linesize[0] = cwidth*4;

    // AV_PIX_FMT_RGB32 is the native endian format that was formerly
    // called PIX_FMT_RGBA32
    m_sws = sws_getCachedContext(m_sws,
                                 cwidth, cheight,
                                 (AVPixelFormat) m_frame->format,
                                 cwidth, cheight, AV_PIX_FMT_RGB32,
                                 SWS_BILINEAR, 0, 0, 0);
    if (m_sws == 0)
      throw std::runtime_error("Could not create the colorspace converter");

    sws_scale(m_sws, m_frame->data, m_frame->linesize, 0, cheight,
              dst_data, dst_linesize);

    if (cwidth != width || cheight != height)
      {
        ls_scale32(framebuffer, width, height,
                   reinterpret_cast<const uint_32*>(dst_data[0]),
                   cwidth, cheight);
      }
    else
      {
        if (m_scale_buf)
          {
            delete[] m_scale_buf;
            m_scale_buf = 0;
            m_scale_buf_size = 0;
          }
      }

    // Correct byte order on big endian machines (using the
    // correct pixel format crashes in img_convert).
    if (is_big_endian())
      {
	std::for_each(framebuffer, framebuffer + width*height,
		      switch_byteorder);
      }
  }

private:
  void seek_and_decode(unsigned int frame_number)
  {
    const double frame_duration = 1.0 / m_fps;
    const double wanted_timestamp = m_start_time + frame_number*frame_duration;

    // m_current_timestamp is the timestamp of the frame in m_frame.
    // Decoding forward is always exact and for short distances it is
    // faster than seeking.
    const double max_forward = std::max(1.0, 3*frame_duration);
    bool sequential =
      m_last_frame >= 0
      && wanted_timestamp > m_current_timestamp + 0.5*frame_duration
      && wanted_timestamp < m_current_timestamp + max_forward;

    double first_timestamp;

    if (sequential)
      {
        int ret = decode_to_timestamp(av_fc, m_dec, video_stream_index,
                                      wanted_timestamp, m_fps, m_pkt, m_frame,
                                      m_tmp_frame, &m_current_timestamp,
                                      &first_timestamp);
        if (ret < 0)
          fail();
        return;
      }

    // Demuxers don't always seek to a keyframe before the wanted
    // timestamp (e.g. mpeg-ps seeks by dts). If decoding starts
    // behind the wanted frame the seek is repeated further back.
    double backoff = 0;
    for (;;)
      {
        double target = wanted_timestamp - backoff;
        bool at_start = target <= m_start_time + 0.5*frame_duration;

#if defined FFMPEGDRIVER_PRINT_DEBUG
        std::cout << "seeking to frame " << frame_number << ", time "
                  << wanted_timestamp << "s (target " << target << "s)\n";
#endif
        int ret = at_start ? rewind_file(av_fc, video_stream_index)
                           : seek_to_second(av_fc, video_stream_index, target);

        if (ret >= 0)
          {
            avcodec_flush_buffers(m_dec);
            m_current_timestamp = target;
            ret = decode_to_timestamp(av_fc, m_dec, video_stream_index,
                                      wanted_timestamp, m_fps, m_pkt, m_frame,
                                      m_tmp_frame, &m_current_timestamp,
                                      &first_timestamp);
          }

        if (ret >= 0
            && first_timestamp <= wanted_timestamp + 0.5*frame_duration)
          return;

        if (at_start)
          {
            if (ret >= 0)
              return; // the wanted frame does not exist, take the next one
            fail();
          }

        backoff = (backoff == 0) ? 0.5 : 2*backoff;
      }
  }

  void fail()
  {
    // Force a seek on the next call. This also gets the decoder out
    // of its draining mode.
    m_last_frame = -1;
    throw std::runtime_error("Could not decode");
  }

  AVFormatContext* av_fc;
  AVCodecContext* m_dec;
  SwsContext* m_sws;

  std::string file_name;
  int m_width;
  int m_height;
  int m_num_frames;

  int video_stream_index;

  AVFrame* m_frame;
  AVFrame* m_tmp_frame;
  AVPacket* m_pkt;

  double m_fps;

  uint_8* m_scale_buf;
  int m_scale_buf_size;

  double m_start_time;
  double m_current_timestamp;
  int m_last_frame;
};

FFMpegDriver::FFMpegDriver()
  : m_impl(new FFMpegDriverImpl())
{
}

FFMpegDriver::~FFMpegDriver()
{
}

std::list<std::string> FFMpegDriver::supported_extensions()
{
  std::list<std::string> el;
  el.push_back("avi");
  el.push_back("divx");
  el.push_back("mpg");
  el.push_back("mpeg");
  el.push_back("mov");
  el.push_back("wmv");
  el.push_back("rm");
  el.push_back("mp4");
  el.push_back("mkv");
  el.push_back("webm");
  el.push_back("*");

  return el;
}

void FFMpegDriver::load_file(const std::string& file_name, VideoInfo& info)
{
  if (m_impl->is_open())
    throw std::logic_error("Driver already open");

  m_impl->open(file_name, info);
}

void FFMpegDriver::close_file()
{
  m_impl->close();
}

bool FFMpegDriver::is_open() const
{
  return m_impl->is_open();
}

void FFMpegDriver::decode_frame(unsigned int frame_number,
                                uint_32* framebuffer,
                                int width, int height)
{
  if (!m_impl->is_open())
    throw std::logic_error("No file loaded");

  if (static_cast<int>(frame_number) >= m_impl->num_frames())
    throw std::range_error("frame_number out of range");

  m_impl->decode_frame(frame_number, framebuffer, width, height);
}

//----------------------------------------------------------------------

/* open a given stream.  */
static AVCodecContext* open_stream(AVFormatContext* av_fc, int stream_index)
{
  assert (stream_index >= 0
          && stream_index < static_cast<int>(av_fc->nb_streams));

  AVCodecParameters* par = av_fc->streams[stream_index]->codecpar;

  const AVCodec* codec = avcodec_find_decoder(par->codec_id);

  if (codec == 0)
    throw std::runtime_error("could not find decoder");

  AVCodecContext* dec = avcodec_alloc_context3(codec);

  if (dec == 0)
    throw std::runtime_error("could not allocate decoder");

  if (avcodec_parameters_to_context(dec, par) < 0)
    {
      avcodec_free_context(&dec);
      throw std::runtime_error("could not set decoder parameters");
    }

  dec->pkt_timebase = av_fc->streams[stream_index]->time_base;

  // Frame threading would add latency to every seek
  dec->thread_count = 0;
  dec->thread_type  = FF_THREAD_SLICE;

  if (avcodec_open2(dec, codec, 0) < 0)
    {
      avcodec_free_context(&dec);
      throw std::runtime_error("avcodec_open2 failed");
    }

  return dec;
}

//----------------------------------------------------------------------

static int estimate_duration(AVFormatContext* av_fc,
                             int stream_index,
                             double fps,
                             double* duration,
                             double* start_time)
{
  std::cout << "estimate_duration, stream_index = "
            << stream_index << ", fps = " << fps << "\n";

  double frame_duration = 1.0 / fps;
  AVStream* stream = av_fc->streams[stream_index];

  const double time_base = av_q2d(stream->time_base);

  int64_t start_pts = stream->start_time;
  if (start_pts == AV_NOPTS_VALUE)
    {
      start_pts = 0;
    }
  else if (start_pts < 0)
    {
      std::cerr << "Invalid negative stream->start_time, assuming 0\n";
      start_pts = 0;
    }

  const double start_s = (double) start_pts * time_base;

  double duration_0;
  if (stream->duration != AV_NOPTS_VALUE)
    duration_0 = (double) stream->duration * time_base;
  else if (av_fc->duration != AV_NOPTS_VALUE)
    duration_0 = (double) av_fc->duration / AV_TIME_BASE;
  else
    duration_0 = frame_duration;

  // assume at least 25 frames
  if (duration_0 <= 0)
    duration_0 = frame_duration*25;

  std::cout << "duration_0 = " << duration_0 << "\n";

  std::cout << "seeking until success...\n";

  int ret = seek_to_second(av_fc, stream_index, start_s + duration_0);

  int seek_count = 1;
  // decrease duration until seek succeeds
  while (ret < 0 && duration_0 >= frame_duration)
    {
      duration_0 -= frame_duration;
      ret = seek_to_second(av_fc, stream_index, start_s + duration_0);
      ++seek_count;
    }

  if (ret < 0)
    {
      std::cerr << "Could not find duration by seeking\n";
      return -1;
    }

  // read frames until EOF

  std::cout << "reading until eof...\n";

  AVPacket* pkt = av_packet_alloc();
  if (pkt == 0)
    return -1;

  int read_count = 0;
  bool read_once = false;
  int64_t last_pts = AV_NOPTS_VALUE;

  while (av_read_frame(av_fc, pkt) >= 0)
    {
      read_once = true;

      if (pkt->stream_index == stream_index)
        {
          // packets are in decoding order, so the last one
          // is not necessarily the last one that is displayed
          int64_t pts = (pkt->pts != AV_NOPTS_VALUE) ? pkt->pts : pkt->dts;

          if (pts != AV_NOPTS_VALUE
              && (last_pts == AV_NOPTS_VALUE || pts > last_pts))
            last_pts = pts;
        }

      av_packet_unref(pkt);

      ++read_count;
    }

  av_packet_free(&pkt);

  if (read_once)
    {
      std::cout << "#seeks = " << seek_count << ", #reads = " << read_count
                << "\n";

      if (last_pts != AV_NOPTS_VALUE)
        duration_0 = (double) (last_pts - start_pts) * time_base
                     + frame_duration;

      *duration   = duration_0;
      *start_time = start_s;
      return 1;
    }
  else
    {
      std::cerr << "Could not read a frame\n";
      return -1;
    }
}

//----------------------------------------------------------------------


static int64_t get_timestamp(double ts_sec, const AVRational& time_base)
{
  return static_cast<int64_t>(ts_sec/av_q2d(time_base) + 0.5);
}

static int seek_to_second(AVFormatContext* av_fc, int stream_index,
                          double sec)
{
  AVStream* video_stream = av_fc->streams[stream_index];

  int64_t ts = get_timestamp(sec, video_stream->time_base);

  return av_seek_frame(av_fc, stream_index, ts, AVSEEK_FLAG_BACKWARD);
}

//----------------------------------------------------------------------
