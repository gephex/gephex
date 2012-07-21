# Microsoft Developer Studio Generated NMAKE File, Based on modeltest.dsp
!IF "$(CFG)" == ""
CFG=modeltest - Win32 Debug
!MESSAGE Keine Konfiguration angegeben. modeltest - Win32 Debug wird als Standard verwendet.
!ENDIF 

!IF "$(CFG)" != "modeltest - Win32 Release" && "$(CFG)" != "modeltest - Win32 Debug"
!MESSAGE UngÅltige Konfiguration "$(CFG)" angegeben.
!MESSAGE Sie kînnen beim AusfÅhren von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "modeltest.mak" CFG="modeltest - Win32 Debug"
!MESSAGE 
!MESSAGE FÅr die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "modeltest - Win32 Release" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE "modeltest - Win32 Debug" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE 
!ERROR Eine ungÅltige Konfiguration wurde angegeben.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "modeltest - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "..\..\config.h" "$(OUTDIR)\modeltest.exe"

!ELSE 

ALL : "model - Win32 Release" "..\..\config.h" "$(OUTDIR)\modeltest.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"model - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\datatreetest.obj"
	-@erase "$(INTDIR)\testmain.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\modeltest.exe"
	-@erase "..\..\config.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MD /w /W0 /GX /O2 /I "../interfaces" /I ".." /I "../../../base/src" /I "../../../" /D "_CONSOLE" /D "NDEBUG" /D "_MBCS" /D for="if (0) {} else for" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\modeltest.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\modeltest.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\modeltest.pdb" /machine:I386 /out:"$(OUTDIR)\modeltest.exe" 
LINK32_OBJS= \
	"$(INTDIR)\datatreetest.obj" \
	"$(INTDIR)\testmain.obj" \
	"..\..\lib\model.lib"

"$(OUTDIR)\modeltest.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "modeltest - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "..\..\..\config.h" "$(OUTDIR)\modeltest.exe"

!ELSE 

ALL : "model - Win32 Debug" "..\..\..\config.h" "$(OUTDIR)\modeltest.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"model - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\datatreetest.obj"
	-@erase "$(INTDIR)\testmain.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\modeltest.exe"
	-@erase "$(OUTDIR)\modeltest.ilk"
	-@erase "$(OUTDIR)\modeltest.pdb"
	-@erase "..\..\..\config.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MTd /w /W0 /Gm /GR /GX /ZI /Od /I ".." /I "../../../base/src" /I "../../../" /D "_CONSOLE" /D "_DEBUG" /D "_MBCS" /D for="if (0) {} else for" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\modeltest.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\modeltest.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib testframework.lib utils.lib /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\modeltest.pdb" /debug /machine:I386 /out:"$(OUTDIR)\modeltest.exe" /pdbtype:sept /libpath:"../../../base/lib" 
LINK32_OBJS= \
	"$(INTDIR)\datatreetest.obj" \
	"$(INTDIR)\testmain.obj" \
	"..\..\lib\model.lib"

"$(OUTDIR)\modeltest.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("modeltest.dep")
!INCLUDE "modeltest.dep"
!ELSE 
!MESSAGE Warning: cannot find "modeltest.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "modeltest - Win32 Release" || "$(CFG)" == "modeltest - Win32 Debug"
SOURCE=..\model\datatreetest.cpp

"$(INTDIR)\datatreetest.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\model\testmain.cpp

"$(INTDIR)\testmain.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!IF  "$(CFG)" == "modeltest - Win32 Release"

"model - Win32 Release" : 
   cd "\code\gephex-0.4\engine\src\model"
   $(MAKE) /$(MAKEFLAGS) /F ".\model.mak" CFG="model - Win32 Release" 
   cd "..\modeltest"

"model - Win32 ReleaseCLEAN" : 
   cd "\code\gephex-0.4\engine\src\model"
   $(MAKE) /$(MAKEFLAGS) /F ".\model.mak" CFG="model - Win32 Release" RECURSE=1 CLEAN 
   cd "..\modeltest"

!ELSEIF  "$(CFG)" == "modeltest - Win32 Debug"

"model - Win32 Debug" : 
   cd "\code\gephex-0.4\engine\src\model"
   $(MAKE) /$(MAKEFLAGS) /F ".\model.mak" CFG="model - Win32 Debug" 
   cd "..\modeltest"

"model - Win32 DebugCLEAN" : 
   cd "\code\gephex-0.4\engine\src\model"
   $(MAKE) /$(MAKEFLAGS) /F ".\model.mak" CFG="model - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\modeltest"

!ENDIF 

SOURCE=..\..\..\config_h.win32

!IF  "$(CFG)" == "modeltest - Win32 Release"

InputPath=..\..\..\config_h.win32

"..\..\config.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy $(InputPath) ..\..\config.h
<< 
	

!ELSEIF  "$(CFG)" == "modeltest - Win32 Debug"

InputPath=..\..\..\config_h.win32

"..\..\..\config.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy $(InputPath)  ..\..\..\config.h
<< 
	

!ENDIF 


!ENDIF 

