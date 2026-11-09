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

#ifndef ffmpegwriter_h
#define ffmpegwriter_h

#include <iostream>
#include <map>
#include <string>

extern "C"
{
#include "libavformat/avformat.h"
#include "libavcodec/avcodec.h"
#include "libavutil/avutil.h"
#include "libswscale/swscale.h"
}

class FFMpegWriter
{
 public:
  FFMpegWriter(const std::string &filename, int xres, int yres, 
	       std::string encoding);
  ~FFMpegWriter();

  void writeFrame(uint32_t *frame);
  std::string getFilename();
  int getXres();
  int getYres();
  std::string getEncoding();

 private:

  void initEncoder();
  void initEncoderMap();
  void initStream();
  void cleanup();

  /// Sends frame to the encoder (0 flushes it) and writes all packets
  void encode(AVFrame *frame);

  std::string outfile;
  std::string encstr;
  int x_res, y_res;
  unsigned int bps;

  typedef std::map<std::string, std::pair<int, std::string> > encmap_t;
  encmap_t encmap;

  AVFrame *picture;
  AVPacket *packet;
  SwsContext *sws;
  int64_t frame_count;
  bool header_written;

  const AVOutputFormat *fmt;
  AVFormatContext *oc;
  AVCodecContext *enc;
  AVStream *video_st;
};

#endif
