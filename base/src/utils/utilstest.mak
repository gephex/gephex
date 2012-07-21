# Microsoft Developer Studio Generated NMAKE File, Based on utilstest.dsp
!IF "$(CFG)" == ""
CFG=utilstest - Win32 Debug
!MESSAGE Keine Konfiguration angegeben. utilstest - Win32 Debug wird als Standard verwendet.
!ENDIF 

!IF "$(CFG)" != "utilstest - Win32 Release" && "$(CFG)" != "utilstest - Win32 Debug"
!MESSAGE UngÅltige Konfiguration "$(CFG)" angegeben.
!MESSAGE Sie kînnen beim AusfÅhren von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "utilstest.mak" CFG="utilstest - Win32 Debug"
!MESSAGE 
!MESSAGE FÅr die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "utilstest - Win32 Release" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE "utilstest - Win32 Debug" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE 
!ERROR Eine ungÅltige Konfiguration wurde angegeben.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "utilstest - Win32 Release"

OUTDIR=.\utilstest___Win32_Release
INTDIR=.\utilstest___Win32_Release
# Begin Custom Macros
OutDir=.\utilstest___Win32_Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\utilstest.exe"

!ELSE 

ALL : "utils - Win32 Release" "TestFramework - Win32 Release" "$(OUTDIR)\utilstest.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"TestFramework - Win32 ReleaseCLEAN" "utils - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\autoptrtest.obj"
	-@erase "$(INTDIR)\bufferstreamtest.obj"
	-@erase "$(INTDIR)\buffertest.obj"
	-@erase "$(INTDIR)\circularbuffertest.obj"
	-@erase "$(INTDIR)\filesystemtest.obj"
	-@erase "$(INTDIR)\sharedlibrarytest.obj"
	-@erase "$(INTDIR)\streamtokenizertest.obj"
	-@erase "$(INTDIR)\stringtokenizertest.obj"
	-@erase "$(INTDIR)\structreadertest.obj"
	-@erase "$(INTDIR)\structscannertest.obj"
	-@erase "$(INTDIR)\testmain.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\xmlutilstest.obj"
	-@erase "$(OUTDIR)\utilstest.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MD /w /W0 /GX /O2 /I "../../../util/include" /I ".." /I "../../../" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\utilstest.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\utilstest.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\utilstest.pdb" /machine:I386 /out:"$(OUTDIR)\utilstest.exe" 
LINK32_OBJS= \
	"$(INTDIR)\autoptrtest.obj" \
	"$(INTDIR)\bufferstreamtest.obj" \
	"$(INTDIR)\buffertest.obj" \
	"$(INTDIR)\circularbuffertest.obj" \
	"$(INTDIR)\filesystemtest.obj" \
	"$(INTDIR)\sharedlibrarytest.obj" \
	"$(INTDIR)\streamtokenizertest.obj" \
	"$(INTDIR)\stringtokenizertest.obj" \
	"$(INTDIR)\structreadertest.obj" \
	"$(INTDIR)\structscannertest.obj" \
	"$(INTDIR)\testmain.obj" \
	"$(INTDIR)\xmlutilstest.obj" \
	"..\..\lib\TestFramework.lib" \
	"..\..\lib\utils.lib"

"$(OUTDIR)\utilstest.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "utilstest - Win32 Debug"

OUTDIR=.\utilstest___Win32_Debug
INTDIR=.\utilstest___Win32_Debug
# Begin Custom Macros
OutDir=.\utilstest___Win32_Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\utilstest.exe"

!ELSE 

ALL : "utils - Win32 Debug" "TestFramework - Win32 Debug" "$(OUTDIR)\utilstest.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"TestFramework - Win32 DebugCLEAN" "utils - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\autoptrtest.obj"
	-@erase "$(INTDIR)\bufferstreamtest.obj"
	-@erase "$(INTDIR)\buffertest.obj"
	-@erase "$(INTDIR)\circularbuffertest.obj"
	-@erase "$(INTDIR)\filesystemtest.obj"
	-@erase "$(INTDIR)\sharedlibrarytest.obj"
	-@erase "$(INTDIR)\streamtokenizertest.obj"
	-@erase "$(INTDIR)\stringtokenizertest.obj"
	-@erase "$(INTDIR)\structreadertest.obj"
	-@erase "$(INTDIR)\structscannertest.obj"
	-@erase "$(INTDIR)\testmain.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\xmlutilstest.obj"
	-@erase "$(OUTDIR)\utilstest.exe"
	-@erase "$(OUTDIR)\utilstest.ilk"
	-@erase "$(OUTDIR)\utilstest.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MTd /w /W0 /Gm /GX /ZI /Od /I "../../../util/include" /I ".." /I "../../../" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\utilstest.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\utilstest.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\utilstest.pdb" /debug /machine:I386 /out:"$(OUTDIR)\utilstest.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\autoptrtest.obj" \
	"$(INTDIR)\bufferstreamtest.obj" \
	"$(INTDIR)\buffertest.obj" \
	"$(INTDIR)\circularbuffertest.obj" \
	"$(INTDIR)\filesystemtest.obj" \
	"$(INTDIR)\sharedlibrarytest.obj" \
	"$(INTDIR)\streamtokenizertest.obj" \
	"$(INTDIR)\stringtokenizertest.obj" \
	"$(INTDIR)\structreadertest.obj" \
	"$(INTDIR)\structscannertest.obj" \
	"$(INTDIR)\testmain.obj" \
	"$(INTDIR)\xmlutilstest.obj" \
	"..\..\lib\TestFramework.lib" \
	"..\..\lib\utils.lib"

"$(OUTDIR)\utilstest.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("utilstest.dep")
!INCLUDE "utilstest.dep"
!ELSE 
!MESSAGE Warning: cannot find "utilstest.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "utilstest - Win32 Release" || "$(CFG)" == "utilstest - Win32 Debug"
SOURCE=.\autoptrtest.cpp

"$(INTDIR)\autoptrtest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\bufferstreamtest.cpp

"$(INTDIR)\bufferstreamtest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\buffertest.cpp

"$(INTDIR)\buffertest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\circularbuffertest.cpp

"$(INTDIR)\circularbuffertest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\filesystemtest.cpp

"$(INTDIR)\filesystemtest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\sharedlibrarytest.cpp

"$(INTDIR)\sharedlibrarytest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\streamtokenizertest.cpp

"$(INTDIR)\streamtokenizertest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\stringtokenizertest.cpp

"$(INTDIR)\stringtokenizertest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\structreadertest.cpp

"$(INTDIR)\structreadertest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\structscannertest.cpp

"$(INTDIR)\structscannertest.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\testmain.cpp

"$(INTDIR)\testmain.obj" : $(SOURCE) "$(INTDIR)"


SOURCE=.\xmlutilstest.cpp

"$(INTDIR)\xmlutilstest.obj" : $(SOURCE) "$(INTDIR)"


!IF  "$(CFG)" == "utilstest - Win32 Release"

"TestFramework - Win32 Release" : 
   cd "\code\gephex-0.4\base\src\TestFramework"
   $(MAKE) /$(MAKEFLAGS) /F ".\TestFramework.mak" CFG="TestFramework - Win32 Release" 
   cd "..\utils"

"TestFramework - Win32 ReleaseCLEAN" : 
   cd "\code\gephex-0.4\base\src\TestFramework"
   $(MAKE) /$(MAKEFLAGS) /F ".\TestFramework.mak" CFG="TestFramework - Win32 Release" RECURSE=1 CLEAN 
   cd "..\utils"

!ELSEIF  "$(CFG)" == "utilstest - Win32 Debug"

"TestFramework - Win32 Debug" : 
   cd "\code\gephex-0.4\base\src\TestFramework"
   $(MAKE) /$(MAKEFLAGS) /F ".\TestFramework.mak" CFG="TestFramework - Win32 Debug" 
   cd "..\utils"

"TestFramework - Win32 DebugCLEAN" : 
   cd "\code\gephex-0.4\base\src\TestFramework"
   $(MAKE) /$(MAKEFLAGS) /F ".\TestFramework.mak" CFG="TestFramework - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\utils"

!ENDIF 

!IF  "$(CFG)" == "utilstest - Win32 Release"

"utils - Win32 Release" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F ".\utils.mak" CFG="utils - Win32 Release" 
   cd "."

"utils - Win32 ReleaseCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F ".\utils.mak" CFG="utils - Win32 Release" RECURSE=1 CLEAN 
   cd "."

!ELSEIF  "$(CFG)" == "utilstest - Win32 Debug"

"utils - Win32 Debug" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F ".\utils.mak" CFG="utils - Win32 Debug" 
   cd "."

"utils - Win32 DebugCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F ".\utils.mak" CFG="utils - Win32 Debug" RECURSE=1 CLEAN 
   cd "."

!ENDIF 


!ENDIF 

