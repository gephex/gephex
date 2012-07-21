# Microsoft Developer Studio Generated NMAKE File, Based on gfxutil.dsp
!IF "$(CFG)" == ""
CFG=gfxutil - Win32 Debug
!MESSAGE Keine Konfiguration angegeben. gfxutil - Win32 Debug wird als Standard verwendet.
!ENDIF 

!IF "$(CFG)" != "gfxutil - Win32 Release" && "$(CFG)" != "gfxutil - Win32 Debug"
!MESSAGE UngÅltige Konfiguration "$(CFG)" angegeben.
!MESSAGE Sie kînnen beim AusfÅhren von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "gfxutil.mak" CFG="gfxutil - Win32 Debug"
!MESSAGE 
!MESSAGE FÅr die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "gfxutil - Win32 Release" (basierend auf  "Win32 (x86) Static Library")
!MESSAGE "gfxutil - Win32 Debug" (basierend auf  "Win32 (x86) Static Library")
!MESSAGE 
!ERROR Eine ungÅltige Konfiguration wurde angegeben.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "gfxutil - Win32 Release"

OUTDIR=.\../../lib
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\../../lib
# End Custom Macros

ALL : "..\..\include\.\gfxutil.h" "$(OUTDIR)\gfxutil.lib"


CLEAN :
	-@erase "$(INTDIR)\gfxutil.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\gfxutil.lib"
	-@erase "..\..\include\.\gfxutil.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /Fp"$(INTDIR)\gfxutil.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gfxutil.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\gfxutil.lib" 
LIB32_OBJS= \
	"$(INTDIR)\gfxutil.obj"

"$(OUTDIR)\gfxutil.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

SOURCE="$(InputPath)"
DS_POSTBUILD_DEP=$(INTDIR)\postbld.dep

ALL : $(DS_POSTBUILD_DEP)

# Begin Custom Macros
OutDir=.\../../lib
# End Custom Macros

$(DS_POSTBUILD_DEP) : "..\..\include\.\gfxutil.h" "$(OUTDIR)\gfxutil.lib"
   del ..\..\include\gfxutil.h
	xcopy gfxutil.h ..\..\include
	echo Helper for Post-build step > "$(DS_POSTBUILD_DEP)"

!ELSEIF  "$(CFG)" == "gfxutil - Win32 Debug"

OUTDIR=.\../../lib
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\../../lib
# End Custom Macros

ALL : "..\..\include\.\gfxutil.h" "$(OUTDIR)\gfxutil.lib"


CLEAN :
	-@erase "$(INTDIR)\gfxutil.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\gfxutil.lib"
	-@erase "..\..\include\.\gfxutil.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MDd /W3 /Gm /GX /ZI /Od /I "c:\code\glsdk\include\glh" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /Fp"$(INTDIR)\gfxutil.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gfxutil.bsc" 
BSC32_SBRS= \
	
LIB32=link.exe -lib
LIB32_FLAGS=/nologo /out:"$(OUTDIR)\gfxutil.lib" 
LIB32_OBJS= \
	"$(INTDIR)\gfxutil.obj"

"$(OUTDIR)\gfxutil.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

SOURCE="$(InputPath)"
DS_POSTBUILD_DEP=$(INTDIR)\postbld.dep

ALL : $(DS_POSTBUILD_DEP)

# Begin Custom Macros
OutDir=.\../../lib
# End Custom Macros

$(DS_POSTBUILD_DEP) : "..\..\include\.\gfxutil.h" "$(OUTDIR)\gfxutil.lib"
   del ..\..\include\gfxutil.h
	xcopy gfxutil.h ..\..\include
	echo Helper for Post-build step > "$(DS_POSTBUILD_DEP)"

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("gfxutil.dep")
!INCLUDE "gfxutil.dep"
!ELSE 
!MESSAGE Warning: cannot find "gfxutil.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "gfxutil - Win32 Release" || "$(CFG)" == "gfxutil - Win32 Debug"
SOURCE=.\gfxutil.cpp

"$(INTDIR)\gfxutil.obj" : $(SOURCE) "$(INTDIR)" ".\gfxutil.h"


SOURCE=.\gfxutil.h

!IF  "$(CFG)" == "gfxutil - Win32 Release"

InputPath=.\gfxutil.h

"..\..\include\gfxutil.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	xcopy $(InputPath) ..\..\include
<< 
	

!ELSEIF  "$(CFG)" == "gfxutil - Win32 Debug"

InputPath=.\gfxutil.h

"..\..\include\gfxutil.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	xcopy $(InputPath) ..\..\include
<< 
	

!ENDIF 


!ENDIF 

