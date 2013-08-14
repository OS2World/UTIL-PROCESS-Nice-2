# GNU Makefile

CC = icc
LD = ilink

CC_FLAGS = /c
LD_FLAGS = /pmtype:vio

all: sample.exe

sample.exe: sample.obj
	$(LD) $(LD_FLAGS) /o:sample.exe sample.obj nice.lib
	
sample.obj: sample.c nice.h
	$(CC) $(CC_FLAGS) sample.c


clean:
	-del sample.exe
	-del sample.obj

