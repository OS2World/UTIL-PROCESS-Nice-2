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

VERSION = 006

all: nicex.exe

nicex.exe: exec.obj
	$(LD_EXE) /o:nicex.exe exec.obj exec.def

exec.obj: exec.c
	$(CC) exec.c


clean:
	-del nicex.exe
	-del exec.obj
	

