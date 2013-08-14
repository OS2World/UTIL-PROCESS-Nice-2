# GNU Make

DEBUG    = 0

BASE_CC  = icc /c /Ss /G5
BASE_LD  = ilink /pmtype:vio

IMPLIB   = implib /NOI
MKLIB    = ilib /NOBACKUP /CONV /NOE /NOBR

ifeq ($(DEBUG),1)
    CC      = $(BASE_CC) /Ti+ /D_NICE_DEBUG_
    LD_DLL  = $(BASE_LD) /dll /debug
    LD_EXE  = $(BASE_LD) /debug
else
    CC      = $(BASE_CC) /O+ /Oc-
    LD_DLL  = $(BASE_LD) /dll /exepack:2
    LD_EXE  = $(BASE_LD) /exepack:2
endif



VERSION = 005

all: copy_files rxnice.dll samples

copy_files: nice.h nice.lib

nice.h: ..\engine\nice.h
	copy ..\engine\nice.h .
	
nice.lib: ..\engine\nice.lib	
	copy ..\engine\nice.lib .

rxnice.dll: rxnice.obj ..\engine\nice.dll rxnice.def
	$(LD_DLL) /o:rxnice.dll rxnice.obj ..\engine\nice.lib rexx.lib rxnice.def

rxnice.obj: rxnice.c ..\engine\globals.h
	$(CC) /Ge- rxnice.c
	
samples:
	make.exe -f sample.mak

clean:
	-del rxnice.dll
	-del rxnice.obj
	-make.exe -f sample.mak clean
	

