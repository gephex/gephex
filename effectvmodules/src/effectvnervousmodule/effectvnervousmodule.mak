# Microsoft Developer Studio Generated NMAKE File, Based on effectvnervousmodule.dsp
!IF "$(CFG)" == ""
CFG=effectvnervousmodule - Win32 Debug
!MESSAGE Keine Konfiguration angegeben. effectvnervousmodule - Win32 Debug wird als Standard verwendet.
!ENDIF 

!IF "$(CFG)" != "effectvnervousmodule - Win32 Release" && "$(CFG)" != "effectvnervousmodule - Win32 Debug"
!MESSAGE Ung�ltige Konfiguration "$(CFG)" angegeben.
!MESSAGE Sie k�nnen beim Ausf�hren von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "effectvnervousmodule.mak" CFG="effectvnervousmodule - Win32 Debug"
!MESSAGE 
!MESSAGE F�r die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "effectvnervousmodule - Win32 Release" (basierend auf  "Win32 (x86) Dynamic-Link Library")
!MESSAGE "effectvnervousmodule - Win32 Debug" (basierend auf  "Win32 (x86) Dynamic-Link Library")
!MESSAGE 
!ERROR Eine ung�ltige Konfiguration wurde angegeben.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "effectvnervousmodule - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : ".\effectvnervousmodule_auto.c" ".\effectvnervousmodule.h" ".\effectvnervousmodule.def" "$(OUTDIR)\effectvnervousmodule.dll"

!ELSE 

ALL : "libeffectv - Win32 Release" ".\effectvnervousmodule_auto.c" ".\effectvnervousmodule.h" ".\effectvnervousmodule.def" "$(OUTDIR)\effectvnervousmodule.dll"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"libeffectv - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\effectvnervousmodule.obj"
	-@erase "$(INTDIR)\effectvnervousmodule_auto.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\effectvnervousmodule.dll"
	-@erase "$(OUTDIR)\effectvnervousmodule.exp"
	-@erase "$(OUTDIR)\effectvnervousmodule.lib"
	-@erase "effectvnervousmodule.def"
	-@erase "effectvnervousmodule.h"
	-@erase "effectvnervousmodule_auto.c"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /G6 /MD /W3 /GX /O2 /Ob2 /I "../../../types/src/numbertype" /I "../../../types/src/framebuffertype" /I "../../../" /I "../../../engine/src/engine" /I "../../../util/include" /I "../libeffectv" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "effectvnervousmodule_EXPORTS" /D "WIN32" /D "NDEBUG" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\effectvnervousmodule.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
MTL_PROJ=/nologo /D "NDEBUG" /mktyplib203 /win32 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\effectvnervousmodule.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /incremental:no /pdb:"$(OUTDIR)\effectvnervousmodule.pdb" /machine:I386 /def:".\effectvnervousmodule.def" /out:"$(OUTDIR)\effectvnervousmodule.dll" /implib:"$(OUTDIR)\effectvnervousmodule.lib" 
DEF_FILE= \
	".\effectvnervousmodule.def"
LINK32_OBJS= \
	"$(INTDIR)\effectvnervousmodule.obj" \
	"$(INTDIR)\effectvnervousmodule_auto.obj" \
	"..\libeffectv\Release\libeffectv.lib"

"$(OUTDIR)\effectvnervousmodule.dll" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

TargetPath=.\Release\effectvnervousmodule.dll
SOURCE="$(InputPath)"
PostBuild_Desc=Kopiere Dll...
DS_POSTBUILD_DEP=$(INTDIR)\postbld.dep

ALL : $(DS_POSTBUILD_DEP)

# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

$(DS_POSTBUILD_DEP) : "libeffectv - Win32 Release" ".\effectvnervousmodule_auto.c" ".\effectvnervousmodule.h" ".\effectvnervousmodule.def" "$(OUTDIR)\effectvnervousmodule.dll"
   copy .\Release\effectvnervousmodule.dll ..\..\..\dlls\modules
	echo Helper for Post-build step > "$(DS_POSTBUILD_DEP)"

!ELSEIF  "$(CFG)" == "effectvnervousmodule - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\effectvnervousmodule.dll"

!ELSE 

ALL : "libeffectv - Win32 Debug" "$(OUTDIR)\effectvnervousmodule.dll"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"libeffectv - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\effectvnervousmodule.obj"
	-@erase "$(INTDIR)\effectvnervousmodule_auto.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\effectvnervousmodule.dll"
	-@erase "$(OUTDIR)\effectvnervousmodule.exp"
	-@erase "$(OUTDIR)\effectvnervousmodule.ilk"
	-@erase "$(OUTDIR)\effectvnervousmodule.lib"
	-@erase "$(OUTDIR)\effectvnervousmodule.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /G6 /MDd /W2 /Gm /GX /ZI /Od /I "../../../types/src/numbertype" /I "../../../types/src/framebuffertype" /I "../../../" /I "../../../engine/src/engine" /I "../../../util/include" /I "../libeffectv" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "effectvnervousmodule_EXPORTS" /D "WIN32" /D "_DEBUG" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\effectvnervousmodule.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 
MTL_PROJ=/nologo /D "_DEBUG" /mktyplib203 /win32 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\effectvnervousmodule.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /incremental:yes /pdb:"$(OUTDIR)\effectvnervousmodule.pdb" /debug /machine:I386 /nodefaultlib:"msvcrt" /nodefaultlib:"winspool" /nodefaultlib:"comdlg32" /nodefaultlib:"uuid" /nodefaultlib:"odbc32" /nodefaultlib:"odbccp32" /nodefaultlib:"oleaut32" /def:".\effectvnervousmodule.def" /out:"$(OUTDIR)\effectvnervousmodule.dll" /implib:"$(OUTDIR)\effectvnervousmodule.lib" /pdbtype:sept 
DEF_FILE= \
	".\effectvnervousmodule.def"
LINK32_OBJS= \
	"$(INTDIR)\effectvnervousmodule.obj" \
	"$(INTDIR)\effectvnervousmodule_auto.obj" \
	"..\libeffectv\Debug\libeffectv.lib"

"$(OUTDIR)\effectvnervousmodule.dll" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

TargetPath=.\Debug\effectvnervousmodule.dll
SOURCE="$(InputPath)"
PostBuild_Desc=Kopiere Dll...
DS_POSTBUILD_DEP=$(INTDIR)\postbld.dep

ALL : $(DS_POSTBUILD_DEP)

# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

$(DS_POSTBUILD_DEP) : "libeffectv - Win32 Debug" "$(OUTDIR)\effectvnervousmodule.dll"
   copy .\Debug\effectvnervousmodule.dll ..\..\..\dlls\modules
	echo Helper for Post-build step > "$(DS_POSTBUILD_DEP)"

!ENDIF 

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


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("effectvnervousmodule.dep")
!INCLUDE "effectvnervousmodule.dep"
!ELSE 
!MESSAGE Warning: cannot find "effectvnervousmodule.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "effectvnervousmodule - Win32 Release" || "$(CFG)" == "effectvnervousmodule - Win32 Debug"
SOURCE=.\effectvnervousmodule.c

!IF  "$(CFG)" == "effectvnervousmodule - Win32 Release"

CPP_SWITCHES=/nologo /G6 /MD /W3 /GX /O2 /Ob2 /I "../../../types/src/numbertype" /I "../../../types/src/framebuffertype" /I "../../../" /I "../../../engine/src/engine" /I "../../../util/include" /I "../libeffectv" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "effectvnervousmodule_EXPORTS" /D "WIN32" /D "NDEBUG" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\effectvnervousmodule.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\effectvnervousmodule.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "effectvnervousmodule - Win32 Debug"

CPP_SWITCHES=/nologo /G6 /MDd /W2 /Gm /GX /ZI /Od /I "../../../types/src/numbertype" /I "../../../types/src/framebuffertype" /I "../../../" /I "../../../engine/src/engine" /I "../../../util/include" /I "../libeffectv" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "effectvnervousmodule_EXPORTS" /D "WIN32" /D "_DEBUG" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\effectvnervousmodule.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\effectvnervousmodule.obj" : $(SOURCE) "$(INTDIR)" ".\effectvnervousmodule.h"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\effectvnervousmodule_auto.c

"$(INTDIR)\effectvnervousmodule_auto.obj" : $(SOURCE) "$(INTDIR)"


!IF  "$(CFG)" == "effectvnervousmodule - Win32 Release"

"libeffectv - Win32 Release" : 
   cd "\code\gephex-0.4\effectvmodules\src\libeffectv"
   $(MAKE) /$(MAKEFLAGS) /F ".\libeffectv.mak" CFG="libeffectv - Win32 Release" 
   cd "..\effectvnervousmodule"

"libeffectv - Win32 ReleaseCLEAN" : 
   cd "\code\gephex-0.4\effectvmodules\src\libeffectv"
   $(MAKE) /$(MAKEFLAGS) /F ".\libeffectv.mak" CFG="libeffectv - Win32 Release" RECURSE=1 CLEAN 
   cd "..\effectvnervousmodule"

!ELSEIF  "$(CFG)" == "effectvnervousmodule - Win32 Debug"

"libeffectv - Win32 Debug" : 
   cd "\code\gephex-0.4\effectvmodules\src\libeffectv"
   $(MAKE) /$(MAKEFLAGS) /F ".\libeffectv.mak" CFG="libeffectv - Win32 Debug" 
   cd "..\effectvnervousmodule"

"libeffectv - Win32 DebugCLEAN" : 
   cd "\code\gephex-0.4\effectvmodules\src\libeffectv"
   $(MAKE) /$(MAKEFLAGS) /F ".\libeffectv.mak" CFG="libeffectv - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\effectvnervousmodule"

!ENDIF 

SOURCE=.\effectvnervousmodule.spec

!IF  "$(CFG)" == "effectvnervousmodule - Win32 Release"

InputPath=.\effectvnervousmodule.spec
InputName=effectvnervousmodule

".\effectvnervousmodule.h"	".\effectvnervousmodule_auto.c"	".\effectvnervousmodule.def" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	python ..\..\..\modules\pluc.py c $(InputName).spec 
	python ..\..\..\modules\pluc.py h $(InputName).spec 
	python ..\..\..\modules\pluc.py def $(InputName).spec
<< 
	

!ELSEIF  "$(CFG)" == "effectvnervousmodule - Win32 Debug"

InputPath=.\effectvnervousmodule.spec
InputName=effectvnervousmodule

".\effectvnervousmodule.h"	".\effectvnervousmodule_auto.c"	".\effectvnervousmodule.def" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	python ..\..\..\modules\pluc.py c $(InputName).spec 
	python ..\..\..\modules\pluc.py h $(InputName).spec 
	python ..\..\..\modules\pluc.py def $(InputName).spec
<< 
	

!ENDIF 


!ENDIF 

