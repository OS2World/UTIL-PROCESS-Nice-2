/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: niced.c,v 1.1 1999/02/13 18:24:10 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:10 $
 *
 **/

#ifndef _UPDATE_H_
#define _UPDATE_H_


#define INCL_DOS
#define INCL_WIN
#include <os2.h>
#include "dosqss.h"


typedef struct _APPRECORDARRAY
{
	ULONG		 ulSize;
	PAPPRECORD * pData;
	
} APPRECORDARRAY, * PAPPRECORDARRAY;


typedef struct _QPROCESSARRAY
{
	ULONG		ulSize;
	PQPROCESS * pData;
	
} QPROCESSARRAY, * PQPROCESSARRAY;


typedef struct _QTHREADARRAY
{
	ULONG		ulSize;
	PQTHREAD *	pData;
	
} QTHREADARRAY, * PQTHREADARRAY;


VOID update_thread( PVOID );


#endif


