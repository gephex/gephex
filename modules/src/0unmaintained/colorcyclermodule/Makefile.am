libdir = @gphx_module_lib_dir@
colorcyclermodule_auto.c: colorcyclermodule.spec colorcyclermodule.h
	python3 ../../pluc.py c colorcyclermodule.spec

colorcyclermodule.h: colorcyclermodule.spec
	python3 ../../pluc.py h colorcyclermodule.spec

# the generated header must exist before any object is compiled
BUILT_SOURCES = colorcyclermodule.h

lib_LTLIBRARIES = colorcyclermodule.la
colorcyclermodule_la_SOURCES = colorcyclermodule_auto.c colorcyclermodule.c colorcyclermodule.h colorcyclermodule.spec colorcyclermodule.xpm

colorcyclermodule_la_LDFLAGS = -module -avoid-version

INCLUDES = -I$(baseincludedir) -I$(baseincludedir)/types -I$(baseincludedir)/engine -I ../../../engine/src/engine -I ../../../util/include -I ../../../types/src/stringtype -I ../../../types/src/rgbtype

