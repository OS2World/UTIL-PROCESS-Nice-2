# GNU Make


#DEBUG	 = 1

DEBUG_DEFS = /D_RT_DEBUG_
#DEBUG_DEFS = /D_RT_DEBUG_ /D_ENGINE_DEBUG_ /D_NICE_DEBUG_
#DEBUG_OBJS = nicedmn.lib


BASE_CC  = icc /c /Ss /G5 $(DEBUG_DEFS)
BASE_LD  = ilink /pmtype:vio

IMPLIB   = implib /NOI
MKLIB    = ilib /NOBACKUP /CONV /NOE /NOBR

ifdef DEBUG
    CC      = $(BASE_CC) /Ti+
    LD_DLL  = $(BASE_LD) /dll /debug
    LD_EXE  = $(BASE_LD) /debug
else
    CC      = $(BASE_CC) /O+ /Oc-
    LD_DLL  = $(BASE_LD) /dll /exepack:2
    LD_EXE  = $(BASE_LD) /exepack:2
endif

VERSION = 006

all: nicedmn.dll nicedhk.dll niced.exe nice.dll nice.exe

niced.exe: niced.obj util.obj nicedhk.lib
	$(LD_EXE) /o:niced.exe niced.obj util.obj nicedhk.lib $(DEBUG_OBJS) niced.def

niced.obj: niced.c globals.h
	$(CC) /W2 niced.c

util.obj: util.c util.h
	$(CC) util.c

nicedhk.dll: hook.obj nicedmn.lib
	$(LD_DLL) /o:nicedhk.dll hook.obj nicedmn.lib nicedhk.def
	$(IMPLIB) nicedhk.lib nicedhk.def
	$(MKLIB) nicedhk.lib ,,

hook.obj: hook.c globals.h
	$(CC) /Gm+ hook.c

nicedmn.dll: engine.obj util.obj menu.res
	$(LD_DLL) /o:nicedmn.dll engine.obj util.obj nicedmn.def
	$(IMPLIB) nicedmn.lib nicedmn.def
	$(MKLIB) nicedmn.lib ,,
	rc menu.res nicedmn.dll

engine.obj: engine.c globals.h
	$(CC) /W2 /Gd- /Ge- /Rn engine.c
	
menu.res: menu.rc menu.h
	rc -r menu.rc	

nice.dll: client.obj
	$(LD_DLL) /o:nice.dll client.obj nice.def
	$(IMPLIB) nice.lib nice.def
	$(MKLIB) nice.lib ,,

client.obj: client.c nice.h globals.h
	$(CC) client.c

nice.exe: nice.obj client.obj
	$(LD_EXE) /o:nice.exe nice.obj client.obj nice.def

nice.obj: nice.c nice.h globals.h
	$(CC) nice.c


clean:
#-niced.exe -stop
	-del niced.exe
	-del niced.obj
	-del nicedhk.dll
	-del nicedhk.lib
	-del hook.obj
	-del nicedmn.dll
	-del nicedmn.lib
	-del engine.obj
	-del nice.dll
	-del nice.lib
	-del client.obj
	-del nice.exe
	-del nice.obj
	-del util.obj
	-del menu.res
	
	

