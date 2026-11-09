/* This source file is a part of the GePhex Project.

 Copyright (C) 2004

 Michael Mandl <mandlm@gephex.org>
 
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
#include "ffmpegwriter.h"
#include <iostream>
#include <string>
#include <stdexcept>

extern "C"
{
#include "libavutil/imgutils.h"
}

namespace
{
  const int FRAMES_PER_SECOND = 25;
}

FFMpegWriter::FFMpegWriter(const std::string &filename, int xres, int yres, 
			   std::string encoding)
  : outfile(filename), encstr(encoding), x_res(xres), y_res(yres), bps(0),
    picture(0), packet(0), sws(0), frame_count(0), header_written(false),
    fmt(0), oc(0), enc(0), video_st(0)
{
  std::cout << "creating new ffmpeg writer " << filename << " " 
	    << xres << "x" << yres 
	    << ", encoding: " << encoding << std::endl;

  try
    {
      initEncoderMap();
      initEncoder();
      initStream();
    }
  catch (...)
    {
      cleanup();
      throw;
    }
}

FFMpegWriter::~FFMpegWriter()
{
  std::cout << "deleting ffmpeg writer " << std::endl;

  cleanup();
}

void FFMpegWriter::writeFrame(uint32_t *frame)
{
  if (av_frame_make_writable(picture) < 0)
    throw std::runtime_error("ffmpeg: could not write to frame");

  // convert the rgba32 input image to codec-format
  const uint8_t *src_data[4] = { (const uint8_t *) frame, 0, 0, 0 };
  const int src_linesize[4]  = { 4*x_res, 0, 0, 0 };

  sws_scale(sws, src_data, src_linesize, 0, y_res,
            picture->data, picture->linesize);

  picture->pts = frame_count++;

  encode(picture);
}


std::string FFMpegWriter::getFilename()
{
  return outfile;
}

int FFMpegWriter::getXres()
{
  return x_res;
}

int FFMpegWriter::getYres()
{
  return y_res;
}

std::string FFMpegWriter::getEncoding()
{
  return encstr;
}

void FFMpegWriter::initEncoderMap()
{
  encmap["DIVX High"]  = std::make_pair(800000, std::string("avi") );
  encmap["DIVX Low"]   = std::make_pair(200000, std::string("avi") );
  encmap["MPEG2 High"] = std::make_pair(800000, std::string("mpeg"));
  encmap["MPEG2 Low"]  = std::make_pair(200000, std::string("mpeg"));
  encmap["RM High"]    = std::make_pair(800000, std::string("rm"));
  encmap["RM Low"]     = std::make_pair(200000, std::string("rm"));
  encmap["MOV High"]   = std::make_pair(800000, std::string("mov"));
  encmap["MOV Low"]    = std::make_pair(200000, std::string("mov"));
}


void FFMpegWriter::initEncoder()
{
  encmap_t::const_iterator enc_it = encmap.find(encstr);

  if ( enc_it == encmap.end() )
    throw std::runtime_error( "unkown encoder format" );
  
  fmt = av_guess_format( enc_it->second.second.c_str(), NULL, NULL);
  bps = enc_it->second.first;

  // use mpeg if unable to guess
  if (fmt == NULL)
  {
    std::cout << "unable to guess file format, trying mpeg..." << std::endl;
    fmt = av_guess_format("mpeg", NULL, NULL);
    bps = 400000;
  }

  // mpeg not available
  if (fmt == NULL)
  {
    throw std::runtime_error("error initializing mpeg encoder!");
  }

  std::cout << "encoder initialized." << std::endl;
  std::cout << "format info (short name / bitrate): "
            << fmt->name << " / " << bps << std::endl;

  if (avformat_alloc_output_context2(&oc, fmt, NULL, outfile.c_str()) < 0)
  {
    throw std::runtime_error("ffmpeg: memory error allocating format context");
  }
}

void FFMpegWriter::initStream()
{
  const AVCodec *codec = avcodec_find_encoder(fmt->video_codec);
  if (!codec)
    throw std::runtime_error("ffmpeg: codec not found");

  video_st = avformat_new_stream(oc, NULL);
  enc = avcodec_alloc_context3(codec);
  if (!video_st || !enc)
    throw std::runtime_error("ffmpeg: could not allocate stream");

  /* put sample parameters */
  enc->bit_rate = bps;
  /* resolution must be a multiple of two */
  enc->width = x_res;
  enc->height = y_res;
  enc->time_base.num = 1;
  enc->time_base.den = FRAMES_PER_SECOND;
  enc->framerate.num = FRAMES_PER_SECOND;
  enc->framerate.den = 1;
  enc->pix_fmt = AV_PIX_FMT_YUV420P;
  enc->gop_size = 12; /* emit one intra frame every twelve frames at most */

  if (enc->codec_id == AV_CODEC_ID_MPEG2VIDEO)
    enc->max_b_frames = 2;

  if (enc->codec_id == AV_CODEC_ID_MPEG1VIDEO)
    enc->mb_decision = 2;

  // some formats want stream headers to be seperate
  if (oc->oformat->flags & AVFMT_GLOBALHEADER)
    enc->flags |= AV_CODEC_FLAG_GLOBAL_HEADER;

  if (avcodec_open2(enc, codec, NULL) < 0)
    throw std::runtime_error("ffmpeg: could not open codec");

  if (avcodec_parameters_from_context(video_st->codecpar, enc) < 0)
    throw std::runtime_error("ffmpeg: could not set stream parameters");

  video_st->time_base = enc->time_base;

  picture = av_frame_alloc();
  packet  = av_packet_alloc();
  if (!picture || !packet)
    throw std::runtime_error("ffmpeg: could not allocate frame");

  picture->format = enc->pix_fmt;
  picture->width  = enc->width;
  picture->height = enc->height;
  if (av_frame_get_buffer(picture, 0) < 0)
    throw std::runtime_error("ffmpeg: could not allocate picture");

  sws = sws_getContext(x_res, y_res, AV_PIX_FMT_RGB32,
                       x_res, y_res, enc->pix_fmt,
                       SWS_BILINEAR, NULL, NULL, NULL);
  if (!sws)
    throw std::runtime_error("ffmpeg: could not create colorspace converter");

  /* open the output file, if needed */
  if (!(fmt->flags & AVFMT_NOFILE)) 
  {
    if (avio_open(&oc->pb, outfile.c_str(), AVIO_FLAG_WRITE) < 0)
      throw std::runtime_error("Could not open outfile");
  }

  // write file header if needed
  if (avformat_write_header(oc, NULL) < 0)
    throw std::runtime_error("ffmpeg: could not write header");

  header_written = true;
}

void FFMpegWriter::encode(AVFrame *frame)
{
  if (avcodec_send_frame(enc, frame) < 0)
    throw std::runtime_error("ffmpeg: error while encoding video frame");

  for (;;)
  {
    int ret = avcodec_receive_packet(enc, packet);

    if (ret == AVERROR(EAGAIN) || ret == AVERROR_EOF)
      return;

    if (ret < 0)
      throw std::runtime_error("ffmpeg: error while encoding video frame");

    av_packet_rescale_ts(packet, enc->time_base, video_st->time_base);
    packet->stream_index = video_st->index;

    /* write the compressed frame in the media file */
    ret = av_interleaved_write_frame(oc, packet);
    av_packet_unref(packet);

    if (ret < 0)
      throw std::runtime_error("ffmpeg: error while writing video frame");
  }
}

void FFMpegWriter::cleanup()
{
  if (header_written)
  {
    try
    {
      encode(NULL); // get the delayed frames
    }
    catch (std::exception &e)
    {
      std::cerr << e.what() << std::endl;
    }

    av_write_trailer(oc);
    header_written = false;
  }

  if (sws)
  {
    sws_freeContext(sws);
    sws = 0;
  }

  av_frame_free(&picture);
  av_packet_free(&packet);
  avcodec_free_context(&enc);

  if (oc)
  {
    /* close the output file */
    if (!(fmt->flags & AVFMT_NOFILE))
      avio_closep(&oc->pb);

    /* free the streams and the context */
    avformat_free_context(oc);
    oc = 0;
  }
}
