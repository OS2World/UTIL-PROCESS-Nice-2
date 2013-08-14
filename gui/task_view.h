/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: niced.c,v 1.1 1999/02/13 18:24:10 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:10 $
 *
 **/

#ifndef _THREAD_VIEW_H_
#define _THREAD_VIEW_H_


#define INCL_DOS
#define INCL_WIN
#include <os2.h>
#include "dosqss.h"

/*
 *  resources
 *
 **/

#define IDC_PLUS 				0x0100
#define IDC_MINUS   			0x0101

#define IDM_CLASSMENU       	0x0110
#define IDM_CM_BASE				0x0110
#define IDM_CM_IDLE             0x0111
#define IDM_CM_REGULAR          0x0112
#define IDM_CM_TIMECRITICAL     0x0113
#define IDM_CM_FOREGROUND       0x0114


#define ID_TASKCONTAINER  	 	0x1010
#define ID_PID_BUTTON     	 	0x1020
#define ID_PPID_BUTTON      	0x1021
#define ID_COMMAND_BUTTON		0x1022

#define	STR_COLTITLE_PID		"PID"
#define STR_COLTITLE_PPID		"PPID"
#define	STR_COLTITLE_CPU		"CPU"
#define	STR_COLTITLE_COMMAND	"Command"
#define	STR_COLTITLE_CLASS  	"Class"
#define	STR_COLTITLE_DELTA  	"Delta"

#define KC_PLUS 				0x002B
#define KC_MINUS				0x002D

#define MAXCOMMANDLEN		256

typedef struct _APPRECORD
{
	MINIRECORDCORE	core;
	
	PQPROCESS		pqProcess;

	PSZ				pszPid;
	PSZ				pszPpid;	
	PSZ				pszCpu;
	PSZ				pszCommand;
	PSZ				pszClass;      // constant string no need for storage
	PSZ				pszDelta;

	CHAR			szPid[ 6 ];
	CHAR			szPpid[ 6 ];
	CHAR			szCpu[ 5 ];
	CHAR			szDelta[ 3 ];
	
	CHAR			szCommand[ MAXCOMMANDLEN ];
	
} APPRECORD, * PAPPRECORD;


HWND create_task_view( HWND );


#endif
