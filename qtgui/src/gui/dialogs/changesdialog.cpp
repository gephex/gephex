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

#include "changesdialog.h"

/* 
 *  Constructs a changesdialog which is a child of 'parent', with the 
 *  name 'name' and widget flags set to 'f' 
 *
 *  The dialog will by default be modeless, unless you set 'modal' to
 *  TRUE to construct a modal dialog.
 */
ChangesDialog::ChangesDialog( QWidget* parent,
			      bool modal,
			      Qt::WFlags fl )
    : QDialog( parent, fl )
{
  setModal(modal);
  setupUi(this);

  connect(ok_button, SIGNAL(clicked()), this, SLOT(accept()));

  changes_view->setReadOnly(true);
  changes_view->setHtml("<h3>0.4.4:</h3>\n"
"<p>\n"
"<ul><li>improved GUI (using Qt 4.x)\n"
"</ul>\n"
"<ul><li>improved Mac OS X support\n"
"</ul>\n"
"<ul><li>new midi modules\n"
"</ul>\n"
"<ul><li>frei0r 1.1 support\n"
"</ul>\n"
"<hr/>"
"\n"
"<h3>0.4.3:</h3>\n"
"<p>\n"
"<ul><li>support for Mac OS X (experimental)\n"
"</ul>\n"
"<ul><li>initial OSC support (experimental)\n"
"</ul>\n"
"<ul><li>support for alsamidisequencer\n"
"</ul>\n"
"<ul><li>ports of almost all effecTV effects\n"
"</ul>\n"
"<ul><li>some usability improvements\n"
"</ul>\n"
"<ul><li>some documentation improvements\n"
"</ul>\n"
"<ul><li>fixed bugs #78, #79, #80, #81, #82, #83, #84, #85, #86, #87, #88, "
"#89, #90, #92  #96, #97, #100, #102, #103, #112, #113, #114, #115, #116, "
"#125, 126\n"
"</ul>\n"
"<p>\n"
"\n"
"<hr/>"
"\n"
"<h3>0.4.2:</h3>\n"
"<p>\n"
"<ul><li>support for frei0r plugins\n"
"</ul>\n"
"<p>\n"
"<ul><li>new modules:\n"
"<ul><li>centermodule\n"
"<li>pongmodule\n"
"<li>timesourcemodule\n"
"<li>signalplotmodule\n"
"</ul></ul>\n"
"<p>\n"
"<ul><li>updated modules:\n"
"<ul><li>overlay module (new smooth overlay mode thanks to pierre)\n"
"<li>capture module (v4l2 support)\n"
"<li>ifs module (speedup and interface cleanup)\n"
"<li>image output (gl compile fix)\n"
"<li>signal generator (support for negative amplitudes)\n"
"</ul></ul>\n"
"<p>\n"
"<ul><li>graph_path, module_path, and frei0r_path now can be a list of "
         "directories each of which is scanned recursively</li></ul>\n"
"<ul><li>fixed bugs #67, #68, #69, #70, #71, #72, #74, #75, #77</li></ul>\n"
"<p>\n"
"\n"
"<hr/>"
"\n"
"<h3>0.4.1:</h3>\n"
"<p>\n"
"<ul><li>new ffmpeg based driver to load video files on linux and win32 (see also README.win32 and the documentation for updated build instructions on win32)\n"
"</ul>\n"
"<p>\n"
"<ul><li>new modules:\n"
"<ul><li>displacement module\n"
"<li>chroma key module\n"
"<li>noise module\n"
"<li>yuv4mpeg2 output module (experimental)\n"
"<li>yuv4mpeg2 input module  (experimental)\n"
"<li>ffmpeg output module    (experimental)\n"
"</ul></ul>\n"
"<p>\n"
"<ul><li>updated modules:\n"
"<ul><li>audioadd module   : translated property names to english\n"
"<li>audioenergy module: now automatically adapts to signal strength\n"
"<li>image calculon    : fixed bug #50 which could lead to a segfault in certain conditions\n"
"<li>image output      : unified xshm and ximage driver, added Xv support (uses hardware scaling if supported)\n"
"<li>rotozoom module   : added mirror-mode\n"
"<li>tunnel module     : fixed cylindrical mapping, removed some artifacts\n"
"</ul></ul>\n"
"<p>\n"
"<ul><li>added command line parameter support to engine and gui (now all parameters in gephex.conf can be overriden on the command line) \n"
"<li>replaced most inline assembler code with external nasm assembler files\n"
"</ul>\n"
"<p>\n"
"<ul><li>small doc updates\n"
"</ul>\n"
"<p>\n"
"<ul><li>changed config dir to ~/.gephex/0.4 and changed module and type install dir to <code class=var>$prefix</code>/lib/gephex-0.4/(modules|types)\n"
"</ul>\n"
"<p>\n"
"\n"
"<hr/>"
"\n"
"<h3>0.4:</h3>\n"
"<ul><li>added win32 build system files (.dsp, .dsw, .mak, .dep) to the source dist. From now on it is possible to build the windows binaries from the source dist (see README.win32).\n"
"</ul>\n"
"<ul><li>vloopback support in image output module (can be used to chain gephex with another application that supports v4l, like effecTV or camstream)\n"
"</ul>\n"
"<ul><li>support for capture devices via directshow, this should cover most webcams and tv cards (capturemodule)\n"
"</ul>\n"
"<ul><li>improved usability of the graph editor and control editor\n"
"<ul><li>the control editor now supports text labels to document the controls of an effect-graph\n"
"<li>when the mouse is over a control widget, the controlled input is highlighted in the graph editor\n"
"<li>improved (or rather fixed) the selection of connections between modules (graph editor)\n"
"</ul></ul>\n"
"<ul><li>new and improved plugins\n"
"<ul><li>greatly improved performance of gradnormmodule, added different edge operators\n"
"<li>new function parse module with 4 number inputs which can interpret arithmetic expressions (more flexible than the calculon module)\n"
"<li>alsa driver for midi input\n"
"<li>reactivated linux native joystick driver (now you don't need SDL to use the joystick on linux) \n"
"<li>rewrote and activated the direct show based video driver in the frbinmodule (image source)\n"
"<li>block size in pixelizermodule can now be chosen independently for x and y direction\n"
"<li>effecTV plugins upgraded from 0.3.8 to 0.3.9\n"
"</ul></ul>\n"
"<ul><li>updated documentation and man pages \n"
"</ul>\n"
"<ul><li>added copyright stuff to all source files \n"
"</ul>\n"
"<ul><li>included effecTV effects into the source tree \n"
"</ul>\n"
"<ul><li>added gephex symbolic link \n</ul>"
"<ul><li>improved build system: all extra libraries like openGL, avifile,"
"or alsa can now be turned on or off at configure time with "
"\"--with-LIB_NAME\" swithes. \n"
"</ul>\n"
"<ul><li>fixed some bugs\n"
"<ul><li>fixed bug with select (#24) which also fixed a bug with the linux joystick driver (#3) \n"
"<li>fixed saturation bug (#18) in the gradnormmodule \n"
"<li>fixed compilation issue with alsa 1.0 (bug #20) \n"
"<li>fixed bug (#25) in renderer which caused skipped updates in some situations \n"
"<li>fixed bug (#29) of the install-exec-hook in the data dir\n"
"<li>fixed \"jumps\" of the signal generator when frequency or signal type changes (bug #35)\n"
"<li>fixed bug (#36) which caused wrong values on inputs after disconnect\n"
"</ul></ul>\n"
"\n"
"<hr/>"
"\n"
"<h3>0.0.4:</h3>\n"
"\n"
"<ul><li>gui now spawns a new engine process if connect fails \n"
"</ul>\n"
"\n"
"<ul><li>changed names of menu-items in the gui \n"
"</ul>\n"
"\n"
"<ul><li>added icon and about dialog to the gui \n"
"</ul>\n"
"\n"
"<ul><li>changed graph format. Old graphs will not work. \n"
"</ul>\n"
"\n"
"<ul><li>changed image source: removed automatic seeking and changed from an [0,1] position input to [0, num_frames-1] position input\n"
"</ul>\n"
"\n"
"<ul><li>frboutmodule (unix only): ximage, xshm and gl output driver now use the DISPLAY environment variable if their display-property is set to \"default\"\n"
"</ul>\n"
"\n"
"<ul><li>removed debug messages \n"
"</ul>\n"
"\n"
"<ul><li>added the ifs (iterated function system) effects to the win32 version\n"
"</ul>\n"
"\n"
"<ul><li>merged config files engine.conf and gui.conf to gephex.conf \n"
"</ul>\n"
"\n"
"<ul><li>added wrapper script for better installation (example graphs are installed under linux now, too) \n"
"</ul>\n"
"\n"
"<ul><li>fixed several bugs (some listed below)\n"
"<ul><li>fixed radio button\n"
"<li>frboutmodule: crash if depth of the xserver is not 32 \n"
"<li>frboutmodule: crash when using xshm driver on remote xserver \n"
"<li>isingnoize: crash when input size is set to zero\n"
"<li>engine: memory leaks\n"
"<li>network: fixed endianess issue in the protocol \n"
"</ul></ul>\n"
"\n"
"<ul><li>changed from debug to release target for engine and gui on win32 (unix version already was non-debug per default)\n"
"</ul>\n"
"\n"
"<hr/>\n"
"\n"
"<h3>0.0.4beta2</h3>\n"
"\n"
"\n"
"<ul><li>removed nonfunctional and unneeded code\n"
"<ul><li>sequencer\n"
"<li>playlist\n"
"<li>tons of old and unneeded code\n"
"<li>folders for graphs\n"
"</ul></ul>\n"
"\n"
"\n"
"<ul><li>fixed several open bugs\n"
"<ul><li>fixed crash when deleting module that is connected to a patched input\n"
"<li>fixed bug that moved modules in the graph editor\n"
"<li>fixed engine crash when gui disconnects\n"
"<li>fixed bug in protocol when the data-receiver throws an exception\n"
"<li>enhanced robustness of protocol (re-sync)\n"
"<li>fixed \"lost value\" problem of spin-box widget \n"
"</ul></ul>\n"
"\n"
"<ul><li>gui and engine now run independent, when one app crashes the other one continues \n"
"</ul>\n"
"\n"
"<ul><li>gui can detach from engine and reconnect later\n"
"</ul>\n"
"\n"
"<ul><li>improved startup speed (loading the plugins took very long before)\n"
"</ul>\n"
"\n"
"<ul><li>new modules:\n"
"<ul><li>font module that can use any true type font (uses sdl_ttf)\n"
"<li>several more effecTV ports (sparkTV, quarkTV, ...)\n"
"<li>pixelizer effect        \n"
"</ul></ul>\n"
"\n"
"<ul><li>new gl output driver in frboutmodule (uses textures)\n"
"</ul>\n"
"\n"
"<ul><li>more bug fixes and small improvements in engine, gui and modules\n"
"</ul>\n"
"\n"
"<hr/>\n"
"\n"
"<h3>0.0.4alpha2</h3>\n"
"\n"
"<ul><li>audio type and some audio modules (beat detection works, but it's still pretty dumb) \n"
"</ul>\n"
"\n"
"<ul><li>graph editor shows icons of the modules now\n"
"</ul>\n"
"\n"
"<ul><li>merged several modules for better usability: (please see README if you want to convert old graphs)\n"
"<ul><li>all framebuffer outputs are merged into frboutmodule (the same module for linux and windows, this way the graphs are more portable) [note that some outputs like glout and sdlout are commented out for the moment due to their bad performance] \n"
"<li>bmpmodule, avifilemodule, libmpeg3loader, videomodule, directshowmodule are merged into frbinmodule (again only one module for all platforms) \n"
"<li>addmodule and submodule have been merged into arithmodule (which now can do a lot more than just addition and subtraction) \n"
"<li>imgmulmodule, imgaddmodule, imgsubmodule, invertmodule have been fixed and merged into imgarithmodule \n"
"</ul></ul>\n"
"\n"
"<ul><li>all framebuffer output drivers now support control over brightness, contrast, gamma \n"
"</ul>\n"
"\n"
"<ul><li>new aalib driver in frboutmodule\n"
"</ul>\n"
"\n"
"<ul><li>new modules:\n"
"<ul><li>gradnormmoule       : shows the edges of an image\n"
"<li>twolayermodule      : turns an image to black and white\n"
"<li>audio(in|out)module : in and output, supports alsa and OSS on posix platforms and wavein/out on win32\n"
"<li>audiobdmodule       : simple beat detection\n"
"</ul></ul>\n"
"\n"
"<ul><li>default graph is now edited and rendered graph at startup\n"
"</ul>\n"
"\n"
"<ul><li>removed output size from rotary zoomer, the size of the input framebuffer is used instead\n"
"</ul>\n"
"\n"
"<ul><li>new check-box property widget\n"
"</ul>\n"
"\n"
"<ul><li>fixed some bugs and glitches\n"
"</ul>\n"
"\n"
"<hr/>\n"
"\n"
"<h3>0.0.4alpha1</h3>\n"
"\n"
"<ul><li>NumberType changed from unsigned int (32 bit) to IEEE 64 bit floating point value. This changes nearly all effects. \n"
"<li>Many bug fixes\n"
"</ul>\n"
"\n"
"<ul><li>Color-format and framebuffer orientation fixed to BGRA top down (i.e. first line in memory is upper most line)\n"
"</ul>\n"
"\n"
"<ul><li>Ported some effects from EffecTV\n"
"</ul>\n"
"\n"
"<ul><li>Improved the build system (library tests etc.)\n"
"</ul>\n"
"\n"
"<ul><li>Midi input now works for Linux and WIN32\n"
"</ul>\n"
"\n"
"<ul><li>Updated the documentation\n"
"</ul>\n"
"\n"
"<ul><li>Avifile support for Linux\n"
"</ul>\n"
"\n"
"<ul><li>Isingnoize and IFS effects\n"
"</ul>\n"
"\n"
"<ul><li>Better control and property widgets (refactored them to use common code)\n"
"</ul>\n"
"\n"
"<hr/>\n"
"\n"
"<h3>0.0.3</h3>\n"
"\n"
"<ul><li>Fixed countless bugs \n"
"</ul>\n"
"\n"
"<ul><li>Reworked network code (support for unix domain sockets + named pipes)\n"
"</ul>\n"
"<hr/>\n"
"\n"
);

}
