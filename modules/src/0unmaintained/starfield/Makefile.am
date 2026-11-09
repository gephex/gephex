libdir = @gphx_module_lib_dir@

PLUC=python3 @srcdir@/../../pluc.py

starfield_auto.c: starfield.spec starfield.h
	$(PLUC) c @srcdir@/starfield.spec

starfield.h: starfield.spec
	$(PLUC) h @srcdir@/starfield.spec

# the generated header must exist before any object is compiled
BUILT_SOURCES = starfield.h

lib_LTLIBRARIES = libstarfield.la

libstarfield_la_SOURCES = 	starfield_auto.c \
				starfield.c \
				starfield.h \
				starfield.spec \
				starfield.xpm

libstarfield_la_LDFLAGS = -module -avoid-version

INCLUDES = 	-I @srcdir@/../../../engine/src/engine \
		-I @srcdir@/../../../util/include \
		-I @srcdir@/../../../types/src/numbertype \
		-I @srcdir@/../../../types/src/rgbtype \
		-I @srcdir@/../../../types/src/framebuffertype 

 

DISTCLEANFILES = starfield.h starfield_auto.c
