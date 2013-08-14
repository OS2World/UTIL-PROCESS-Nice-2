/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: niced.c,v 1.1 1999/02/13 18:24:10 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:10 $
 *
 **/

#define INCL_DOS
#define INCL_WIN
#include <os2.h>
#include <stdlib.h>
#include "dosqss.h"
#include "task_view.h"
#include "frame.h"


HWND create_frame()
{
	HWND		hwndFrame;
	FRAMECDATA  fcd;

    fcd.cb = sizeof(FRAMECDATA);
    fcd.flCreateFlags = FCF_TITLEBAR |
                        FCF_SYSMENU |
                        FCF_SIZEBORDER |
                        FCF_SHELLPOSITION |
                        FCF_MINMAX |
                        FCF_TASKLIST;
    fcd.hmodResources = NULLHANDLE;
    fcd.idResources = 0;

    hwndFrame = WinCreateWindow( HWND_DESKTOP,
                                 WC_FRAME,
                                 "NICE/2 PM Control Center",
                                 0,
                                 100, 100, 515, 450,
                                 NULLHANDLE,
                                 HWND_TOP,
                                 ID_FRAME,
                                 &fcd,
                                 NULL );
	return hwndFrame;
};


