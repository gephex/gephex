/*
 * EffecTV - Realtime Digital Video Effector
 * Copyright (C) 2001-2003 FUKUCHI Kentaro
 *
 * PredatorTV - makes incoming objects invisible like the Predator.
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

static char *effectname = "PredatorTV";
static int state = 0;
static int framenumber = 0;
static RGB32 *bgimage;

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

effect *predatorRegister()
{
	effect *entry;
	
	sharedbuffer_reset();
	bgimage = (RGB32 *)sharedbuffer_alloc(video_area*PIXEL_SIZE);
	if(bgimage == NULL) {
		return NULL;
	}

	entry = (effect *)malloc(sizeof(effect));
	if(entry == NULL) {
		return NULL;
	}
	
	entry->name = effectname;
	entry->start = start;
	entry->stop = stop;
	entry->draw = draw;
	entry->event = 0;

	return entry;
}

static int start()
{
	image_set_threshold_y(MAGIC_THRESHOLD);
	framenumber = 0;
	state = 1;
	return 0;
}

static int stop()
{
	state = 0;
	return 0;
}

static int draw(RGB32 *src, RGB32 *dest)
{
	int x, y;
	unsigned char *diff;

	if(framenumber < 5) {
	    setBackground(src);
	    framenumber++;
	    }
	diff = image_bgsubtract_y(src);
	diff = image_diff_filter(diff);

	dest += video_width;
	diff += video_width;
	src = bgimage + video_width;
	for(y=1; y<video_height-1; y++) {
		for(x=0; x<video_width; x++) {
			if(*diff){
				*dest = src[4] & 0xfcfcfc;
			} else {
				*dest = *src;
			}
			diff++;
			src++;
			dest++;
		}
	}

	return 0;
}
