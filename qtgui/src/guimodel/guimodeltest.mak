# Microsoft Developer Studio Generated NMAKE File, Based on guimodeltest.dsp
!IF "$(CFG)" == ""
CFG=guimodeltest - Win32 Debug
!MESSAGE Keine Konfiguration angegeben. guimodeltest - Win32 Debug wird als Standard verwendet.
!ENDIF 

!IF "$(CFG)" != "guimodeltest - Win32 Release" && "$(CFG)" != "guimodeltest - Win32 Debug"
!MESSAGE UngÅltige Konfiguration "$(CFG)" angegeben.
!MESSAGE Sie kînnen beim AusfÅhren von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "guimodeltest.mak" CFG="guimodeltest - Win32 Debug"
!MESSAGE 
!MESSAGE FÅr die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "guimodeltest - Win32 Release" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE "guimodeltest - Win32 Debug" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE 
!ERROR Eine ungÅltige Konfiguration wurde angegeben.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "guimodeltest - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\guimodeltest.exe"


CLEAN :
	-@erase "$(INTDIR)\testmain.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\guimodeltest.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MD /w /W0 /GR /GX /O2 /D "_CONSOLE" /D "_MBCS" /D "NDEBUG" /D "WIN32" /D for="if (0) {} else for" /D "HAVE_CONFIG_H" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\guimodeltest.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\guimodeltest.pdb" /machine:I386 /out:"$(OUTDIR)\guimodeltest.exe" 
LINK32_OBJS= \
	"$(INTDIR)\testmain.obj"

"$(OUTDIR)\guimodeltest.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "guimodeltest - Win32 Debug"

OUTDIR=.\guimodeltest___Win32_Debug
INTDIR=.\guimodeltest___Win32_Debug
# Begin Custom Macros
OutDir=.\guimodeltest___Win32_Debug
# End Custom Macros

ALL : "$(OUTDIR)\guimodeltest.exe"


CLEAN :
	-@erase "$(INTDIR)\testmain.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\guimodeltest.exe"
	-@erase "$(OUTDIR)\guimodeltest.ilk"
	-@erase "$(OUTDIR)\guimodeltest.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /MTd /w /W0 /Gm /GR /GX /ZI /Od /I "../../../base/src" /D "_CONSOLE" /D "_MBCS" /D "_DEBUG" /D "WIN32" /D for="if (0) {} else for" /D "HAVE_CONFIG_H" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\guimodeltest.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib testframework.lib /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\guimodeltest.pdb" /debug /machine:I386 /out:"$(OUTDIR)\guimodeltest.exe" /pdbtype:sept /libpath:"../../../base/lib" 
LINK32_OBJS= \
	"$(INTDIR)\testmain.obj"

"$(OUTDIR)\guimodeltest.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("guimodeltest.dep")
!INCLUDE "guimodeltest.dep"
!ELSE 
!MESSAGE Warning: cannot find "guimodeltest.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "guimodeltest - Win32 Release" || "$(CFG)" == "guimodeltest - Win32 Debug"
SOURCE=.\testmain.cpp

"$(INTDIR)\testmain.obj" : $(SOURCE) "$(INTDIR)"



!ENDIF 

