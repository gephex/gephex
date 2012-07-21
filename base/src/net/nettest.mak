# Microsoft Developer Studio Generated NMAKE File, Based on nettest.dsp
!IF "$(CFG)" == ""
CFG=nettest - Win32 Debug
!MESSAGE Keine Konfiguration angegeben. nettest - Win32 Debug wird als Standard verwendet.
!ENDIF 

!IF "$(CFG)" != "nettest - Win32 Release" && "$(CFG)" != "nettest - Win32 Debug"
!MESSAGE UngÅltige Konfiguration "$(CFG)" angegeben.
!MESSAGE Sie kînnen beim AusfÅhren von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "nettest.mak" CFG="nettest - Win32 Debug"
!MESSAGE 
!MESSAGE FÅr die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "nettest - Win32 Release" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE "nettest - Win32 Debug" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE 
!ERROR Eine ungÅltige Konfiguration wurde angegeben.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "nettest - Win32 Release"

OUTDIR=.\nettest___Win32_Release
INTDIR=.\nettest___Win32_Release
# Begin Custom Macros
OutDir=.\nettest___Win32_Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\nettest.exe"

!ELSE 

ALL : "net - Win32 Release" "utils - Win32 Release" "TestFramework - Win32 Release" "$(OUTDIR)\nettest.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"TestFramework - Win32 ReleaseCLEAN" "utils - Win32 ReleaseCLEAN" "net - Win32 ReleaseCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\domainsockettest.obj"
	-@erase "$(INTDIR)\namedpipesockettest.obj"
	-@erase "$(INTDIR)\protocoltest.obj"
	-@erase "$(INTDIR)\tagdispatchertest.obj"
	-@erase "$(INTDIR)\taggertest.obj"
	-@erase "$(INTDIR)\tcpsockettest.obj"
	-@erase "$(INTDIR)\testmain.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\nettest.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MD /w /W0 /GX /O2 /I "../../../util/include" /I ".." /I "../../../" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\nettest.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\nettest.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib wsock32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\nettest.pdb" /machine:I386 /out:"$(OUTDIR)\nettest.exe" 
LINK32_OBJS= \
	"$(INTDIR)\domainsockettest.obj" \
	"$(INTDIR)\namedpipesockettest.obj" \
	"$(INTDIR)\protocoltest.obj" \
	"$(INTDIR)\tagdispatchertest.obj" \
	"$(INTDIR)\taggertest.obj" \
	"$(INTDIR)\tcpsockettest.obj" \
	"$(INTDIR)\testmain.obj" \
	"..\..\lib\TestFramework.lib" \
	"..\..\lib\utils.lib" \
	"..\..\lib\net.lib"

"$(OUTDIR)\nettest.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "nettest - Win32 Debug"

OUTDIR=.\nettest___Win32_Debug
INTDIR=.\nettest___Win32_Debug
# Begin Custom Macros
OutDir=.\nettest___Win32_Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "..\..\..\config.h" "$(OUTDIR)\nettest.exe"

!ELSE 

ALL : "net - Win32 Debug" "utils - Win32 Debug" "TestFramework - Win32 Debug" "..\..\..\config.h" "$(OUTDIR)\nettest.exe"

!ENDIF 

!IF "$(RECURSE)" == "1" 
CLEAN :"TestFramework - Win32 DebugCLEAN" "utils - Win32 DebugCLEAN" "net - Win32 DebugCLEAN" 
!ELSE 
CLEAN :
!ENDIF 
	-@erase "$(INTDIR)\domainsockettest.obj"
	-@erase "$(INTDIR)\namedpipesockettest.obj"
	-@erase "$(INTDIR)\protocoltest.obj"
	-@erase "$(INTDIR)\tagdispatchertest.obj"
	-@erase "$(INTDIR)\taggertest.obj"
	-@erase "$(INTDIR)\tcpsockettest.obj"
	-@erase "$(INTDIR)\testmain.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\nettest.exe"
	-@erase "$(OUTDIR)\nettest.ilk"
	-@erase "$(OUTDIR)\nettest.pdb"
	-@erase "..\..\..\config.h"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MTd /w /W0 /Gm /GX /ZI /Od /I "../../../util/include" /I ".." /I "../../../" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "HAVE_CONFIG_H" /Fp"$(INTDIR)\nettest.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\nettest.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib wsock32.lib /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\nettest.pdb" /debug /machine:I386 /out:"$(OUTDIR)\nettest.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\domainsockettest.obj" \
	"$(INTDIR)\namedpipesockettest.obj" \
	"$(INTDIR)\protocoltest.obj" \
	"$(INTDIR)\tagdispatchertest.obj" \
	"$(INTDIR)\taggertest.obj" \
	"$(INTDIR)\tcpsockettest.obj" \
	"$(INTDIR)\testmain.obj" \
	"..\..\lib\TestFramework.lib" \
	"..\..\lib\utils.lib" \
	"..\..\lib\net.lib"

"$(OUTDIR)\nettest.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("nettest.dep")
!INCLUDE "nettest.dep"
!ELSE 
!MESSAGE Warning: cannot find "nettest.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "nettest - Win32 Release" || "$(CFG)" == "nettest - Win32 Debug"
SOURCE=.\domainsockettest.cpp

"$(INTDIR)\domainsockettest.obj" : $(SOURCE) "$(INTDIR)" "..\..\..\config.h"


SOURCE=.\namedpipesockettest.cpp

"$(INTDIR)\namedpipesockettest.obj" : $(SOURCE) "$(INTDIR)" "..\..\..\config.h"


SOURCE=.\protocoltest.cpp

"$(INTDIR)\protocoltest.obj" : $(SOURCE) "$(INTDIR)" "..\..\..\config.h"


SOURCE=.\tagdispatchertest.cpp

"$(INTDIR)\tagdispatchertest.obj" : $(SOURCE) "$(INTDIR)" "..\..\..\config.h"


SOURCE=.\taggertest.cpp

"$(INTDIR)\taggertest.obj" : $(SOURCE) "$(INTDIR)" "..\..\..\config.h"


SOURCE=.\tcpsockettest.cpp

"$(INTDIR)\tcpsockettest.obj" : $(SOURCE) "$(INTDIR)" "..\..\..\config.h"


SOURCE=.\testmain.cpp

"$(INTDIR)\testmain.obj" : $(SOURCE) "$(INTDIR)" "..\..\..\config.h"


!IF  "$(CFG)" == "nettest - Win32 Release"

"TestFramework - Win32 Release" : 
   cd "\code\gephex-0.4\base\src\TestFramework"
   $(MAKE) /$(MAKEFLAGS) /F ".\TestFramework.mak" CFG="TestFramework - Win32 Release" 
   cd "..\net"

"TestFramework - Win32 ReleaseCLEAN" : 
   cd "\code\gephex-0.4\base\src\TestFramework"
   $(MAKE) /$(MAKEFLAGS) /F ".\TestFramework.mak" CFG="TestFramework - Win32 Release" RECURSE=1 CLEAN 
   cd "..\net"

!ELSEIF  "$(CFG)" == "nettest - Win32 Debug"

"TestFramework - Win32 Debug" : 
   cd "\code\gephex-0.4\base\src\TestFramework"
   $(MAKE) /$(MAKEFLAGS) /F ".\TestFramework.mak" CFG="TestFramework - Win32 Debug" 
   cd "..\net"

"TestFramework - Win32 DebugCLEAN" : 
   cd "\code\gephex-0.4\base\src\TestFramework"
   $(MAKE) /$(MAKEFLAGS) /F ".\TestFramework.mak" CFG="TestFramework - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\net"

!ENDIF 

!IF  "$(CFG)" == "nettest - Win32 Release"

"utils - Win32 Release" : 
   cd "\code\gephex-0.4\base\src\utils"
   $(MAKE) /$(MAKEFLAGS) /F ".\utils.mak" CFG="utils - Win32 Release" 
   cd "..\net"

"utils - Win32 ReleaseCLEAN" : 
   cd "\code\gephex-0.4\base\src\utils"
   $(MAKE) /$(MAKEFLAGS) /F ".\utils.mak" CFG="utils - Win32 Release" RECURSE=1 CLEAN 
   cd "..\net"

!ELSEIF  "$(CFG)" == "nettest - Win32 Debug"

"utils - Win32 Debug" : 
   cd "\code\gephex-0.4\base\src\utils"
   $(MAKE) /$(MAKEFLAGS) /F ".\utils.mak" CFG="utils - Win32 Debug" 
   cd "..\net"

"utils - Win32 DebugCLEAN" : 
   cd "\code\gephex-0.4\base\src\utils"
   $(MAKE) /$(MAKEFLAGS) /F ".\utils.mak" CFG="utils - Win32 Debug" RECURSE=1 CLEAN 
   cd "..\net"

!ENDIF 

!IF  "$(CFG)" == "nettest - Win32 Release"

"net - Win32 Release" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F ".\net.mak" CFG="net - Win32 Release" 
   cd "."

"net - Win32 ReleaseCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F ".\net.mak" CFG="net - Win32 Release" RECURSE=1 CLEAN 
   cd "."

!ELSEIF  "$(CFG)" == "nettest - Win32 Debug"

"net - Win32 Debug" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F ".\net.mak" CFG="net - Win32 Debug" 
   cd "."

"net - Win32 DebugCLEAN" : 
   cd "."
   $(MAKE) /$(MAKEFLAGS) /F ".\net.mak" CFG="net - Win32 Debug" RECURSE=1 CLEAN 
   cd "."

!ENDIF 

SOURCE=..\..\..\config_h.win32

!IF  "$(CFG)" == "nettest - Win32 Release"

InputPath=..\..\..\config_h.win32

"..\..\..\config.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy $(InputPath) ..\..\..\config.h
<< 
	

!ELSEIF  "$(CFG)" == "nettest - Win32 Debug"

InputPath=..\..\..\config_h.win32

"..\..\..\config.h" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	<<tempfile.bat 
	@echo off 
	copy $(InputPath) ..\..\..\config.h
<< 
	

!ENDIF 


!ENDIF 

