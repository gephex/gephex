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

#include "bwmodule.h"

typedef struct _MyInstance {

 int dummy; // replace this with your favourite vars

} MyInstance, *MyInstancePtr;

int init(logT log_function)
{
  return 1;
}

void shutDown(void)
{
}

MyInstance* construct()
{
  MyInstance* my = (MyInstancePtr) malloc(sizeof(MyInstance));

  return my;
}

void destruct(MyInstance* my)
{
  free(my);
}

void update(void* instance)
{
  InstancePtr inst = (InstancePtr) instance;
  //MyInstancePtr my = inst->my;
  

  int xsize, ysize; 
  uint_32 *src, *dst;
  int xysize, i;

  src = (int*)inst->in_1->framebuffer;
  xsize = inst->in_1->xsize;
  ysize = inst->in_1->ysize;


  {
    FrameBufferAttributes attr;
    attr.xsize = xsize;
    attr.ysize = ysize;

    framebuffer_changeAttributes(inst->out_r, &attr);
  }

  dst = inst->out_r->framebuffer;

  xysize = xsize * ysize;

	
  for(i=xysize; --i;)
    {
      int tmpbw;
      unsigned char* tmpc = (unsigned char*)src;
      tmpbw = (tmpc[0] + tmpc[1] + tmpc[2]) / 3;
      *dst = (tmpbw << 16) | (tmpbw << 8) | tmpbw;
      ++dst;
      ++src;
    }
}

