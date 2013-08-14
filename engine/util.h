/*
 *  Project:
 *  Description:
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: util.h,v 1.1 1999/02/13 18:24:33 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:33 $
 *
 **/

#ifndef _UTIL_H_
#define _UTIL_H_


#define INCL_DOS
#define INCL_WIN
#include <os2.h>


APIRET swlPidToHwnd( PID, HWND * );
APIRET swlNameToPid( PSZ, PID * );
APIRET qssPmShellPid( PID, PID * );
LONG   my_strlen( CHAR * );
LONG   my_strcmp( CHAR *, CHAR * );
CHAR * my_strchr( CHAR *, CHAR );
CHAR * my_strrchr( CHAR *, CHAR );

#define va_arg( arg, type ) \
        ( type ) *arg; arg++;

LONG   my_vsprintf( CHAR *, const CHAR *, PVOID * );


#endif
