/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: niced.c,v 1.1 1999/02/13 18:24:10 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:10 $
 *
 **/

#ifndef _FRAME_H_
#define _FRAME_H_


#define INCL_WIN
#include <os2.h>


#define ID_FRAME	0x1000

HWND create_frame( void );


#endif
