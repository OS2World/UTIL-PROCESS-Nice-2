#
#  By Sharon Dagan, IBM Israel <idagan@il.ibm.com>
#  (C) 1998, All Rights Reserved, Israel.
#
#  $Date: 1998/07/28 05:57:08 $
#  $Id: Makefile,v 1.2 1998/07/28 05:57:08 idagan Exp idagan $
#

DEBUG	 = 0

BASE_CC  = icc /c /Ss /G5
BASE_LD  = ilink /pmtype:pm

IMPLIB	 = implib /NOI
MKLIB    = ilib /NOBACKUP /CONV /NOE /NOBR

ifeq ($(DEBUG),1)
	CC      = $(BASE_CC) /Ti+ /D_NICE_DEBUG_
	LD_DLL  = $(BASE_LD) /dll /debug
	LD_EXE  = $(BASE_LD) /debug
else
	CC 	    = $(BASE_CC) /O+ /Oc-
	LD_DLL  = $(BASE_LD) /dll /exepack:2
	LD_EXE  = $(BASE_LD) /exepack:2
endif

BIN_DIR  = ..\..\bin


all: nicepm.exe

nicepm.exe: main.obj frame.obj notebook.obj task_view.obj update.obj nicepm.res nicepm.def
	$(LD_EXE) /noe /o:$@ $(filter-out $(filter-out %.obj,$^),$^) nicepm.def
	rc nicepm.res $@
		
main.obj: main.c
	$(CC) main.c

frame.obj: frame.c frame.h
	$(CC) frame.c

notebook.obj: notebook.c notebook.h
	$(CC) notebook.c

task_view.obj: task_view.c task_view.h update.h
	$(CC) /Gm task_view.c

update.obj: update.c update.h task_view.h
	$(CC) /W2 update.c
	
nicepm.res: nicepm.rc task_view.rc
	rc -r nicepm.rc


clean:
	-del main.obj
	-del frame.obj
	-del notebook.obj
	-del task_view.obj
	-del task_view.res
	-del update.obj
	-del nicepm.res
	-del nicepm.exe
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
