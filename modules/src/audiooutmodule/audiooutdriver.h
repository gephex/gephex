/* This source file is a part of the GePhex Project.

 Copyright (C) 2001-2004

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

#ifndef INCLUDED_AUDIO_OUT_DRIVER_H
#define INCLUDED_AUDIO_OUT_DRIVER_H

class AudioOutDriver
{
 public:
  typedef int device_id_t;

  enum sample_format { SF_16LE };

  virtual ~AudioOutDriver() {};
  /**
   *
   * Output is buffered. The size of the buffer is
   * num_periods*samples_per_period samples. This buffer determines the
   * latency of audio output.
   */
  virtual void open(device_id_t device,
                    int sample_rate,
                    sample_format format,
                    int channels,
                    int samples_per_period,
                    int num_periods) = 0;


  virtual void close() = 0;

  /**
   * Returns the number of samples written (not bytes!).
   * Return value always >= 0.
   */ 
  virtual int write(const unsigned char* data,
		    int num_samples) = 0;

  virtual bool is_open() const = 0;
};

#endif
