/*
 * EffecTV - Realtime Digital Video Effector
 * Copyright (C) 2001-2003 FUKUCHI Kentaro
 *
 * HolographicTV - Holographic vision
 * Copyright (C) 2001-2002 FUKUCHI Kentaro
 *
 */

#include <stdlib.h>
#include <string.h>
#include "EffecTV.h"
#include "utils.h"

static int start(void);
static int stop(void);
static int draw(RGB32 *src, RGB32 *dest);
static int event(SDL_Event *);

#define MAGIC_THRESHOLD 40

static char *effectname = "HolographicTV";
static int state = 0;
static int framenumber = 0;
static RGB32 *bgimage;
static unsigned int noisepattern[256];

static int setBackground(RGB32 *src)
{
	int i;
	RGB32  *tmp;

	tmp = (RGB32 *)malloc(video_area * PIXEL_SIZE);
	if(tmp == NULL)
		return -1;

/*
 * grabs 4 frames and composites them to get a quality background image
 */
	switch(framenumber) {
	case 0:
//	    src = (RGB32 *)video_getaddress();
	    memcpy(bgimage, src, video_area * sizeof(RGB32));
	    break;
/* step 2: add frame-2 to buffer-1 */
	case 1:
	    for(i=0; i<video_area; i++) {
		bgimage[i] = (src[i]&bgimage[i])+(((src[i]^bgimage[i])&0xfefefe)>>1);
	    }
	    break;
/* step 3: grab frame-3 to buffer-2 */
	case 2:
//	src = (RGB32 *)video_getaddress();
	memcpy(tmp, src, video_area*sizeof(RGB32));
	break;
/* step 4: add frame-4 to buffer-2 */
	case 3:
	for(i=0; i<video_area; i++) {
		tmp[i] = (src[i]&tmp[i])+(((src[i]^tmp[i])&0xfefefe)>>1);
	}
	break;
	case 4:
/* step 5: add buffer-3 to buffer-1 */
	    for(i=0; i<video_area; i++) {
		bgimage[i] = ((bgimage[i]&tmp[i])
			      +(((bgimage[i]^tmp[i])&0xfefefe)>>1))&0xfefefe;
	    }
	image_bgset_y(bgimage);
	break;
	}
/* 	for(i=0; i<2; i++) { */
/* 		if(screen_lock() < 0) { */
/* 			break; */
/* 		} */
/* 		if(stretch) { */
/* 			if(i == 0) { */
/* 				memcpy(stretching_buffer, bgimage, video_area*PIXEL_SIZE); */
/* 			} */
/* 			image_stretch_to_screen(); */
/* 		} else { */
/* 			memcpy((RGB32 *)screen_getaddress(), bgimage, */
/* 					video_area*PIXEL_SIZE); */
/* 		} */
/* 		screen_unlock(); */
/* 		screen_update(); */
/* 		if(doublebuf == 0) */
/* 			break; */
/* 	} */
/* 	free(tmp); */

 	return 0; 
}

static void holoInit()
{
	int i;

	for(i=0; i<256; i++) {
		noisepattern[i] = (i * i * i / 40000)* i / 256;
	}
}

effect *holoRegister()
{
	effect *entry;
	
	sharedbuffer_reset();
	bgimage = (RGB32 *)sharedbuffer_alloc(video_area*PIXEL_SIZE);
	if(bgimage == NULL) {
		return NULL;
	}
	holoInit();

	entry = (effect *)malloc(sizeof(effect));
	if(entry == NULL) {
		return NULL;
	}
	
	entry->name = effectname;
	entry->start = start;
	entry->stop = stop;
	entry->draw = draw;

	return entry;
}

static int start()
{
	image_set_threshold_y(MAGIC_THRESHOLD);

	state = 1;
	framenumber = 0;
	return 0;
}

static int stop()
{
	state = 0;
	return 0;
}

static int draw(RGB32 *src, RGB32 *dest)
{
	static int phase=0;
	int x, y;
	unsigned char *diff;
	RGB32 *bg;
	RGB32 s, t;
	int r, g, b;

	if(framenumber < 5) {
	    setBackground(src);
	    framenumber++;
	}
	diff = image_diff_filter(image_bgsubtract_y(src));

	diff += video_width;
	dest += video_width;
	src += video_width;
	bg = bgimage + video_width;
	for(y=1; y<video_height-1; y++) {
		if(((y+phase) & 0x7f)<0x58) {
			for(x=0; x<video_width; x++) {
				if(*diff){
					s = *src;
					t = (s & 0xff) + ((s & 0xff00)>>7) + ((s & 0xff0000)>>16);
					t += noisepattern[inline_fastrand()>>24];
					r = ((s & 0xff0000)>>17) + t;
					g = ((s & 0xff00)>>8) + t;
					b = (s & 0xff) + t;
					r = (r>>1)-100;
					g = (g>>1)-100;
					b = b>>2;
					if(r<20) r=20;
					if(g<20) g=20;
					s = *bg;
					r += (s&0xff0000)>>17;
					g += (s&0xff00)>>9;
					b += ((s&0xff)>>1)+40;
					if(r>255) r = 255;
					if(g>255) g = 255;
					if(b>255) b = 255;
					*dest = r<<16|g<<8|b;
				} else {
					*dest = *bg;
				}
				diff++;
				src++;
				dest++;
				bg++;
			}
		} else {
			for(x=0; x<video_width; x++) {
				if(*diff){
					s = *src;
					t = (s & 0xff) + ((s & 0xff00)>>6) + ((s & 0xff0000)>>16);
					t += noisepattern[inline_fastrand()>>24];
					r = ((s & 0xff0000)>>16) + t;
					g = ((s & 0xff00)>>8) + t;
					b = (s & 0xff) + t;
					r = (r>>1)-100;
					g = (g>>1)-100;
					b = b>>2;
					if(r<0) r=0;
					if(g<0) g=0;
					s = *bg;
					r += ((s&0xff0000)>>17) + 10;
					g += ((s&0xff00)>>9) + 10;
					b += ((s&0xff)>>1) + 40;
					if(r>255) r = 255;
					if(g>255) g = 255;
					if(b>255) b = 255;
					*dest = r<<16|g<<8|b;
				} else {
					*dest = *bg;
				}
				diff++;
				src++;
				dest++;
				bg++;
			}
		}
	}
	phase-=37;

	return 0;
}

