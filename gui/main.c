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
#include "frame.h"
#include "notebook.h"


int main()
{
	HAB     hab;
	HMQ		hmq;
	QMSG    qmsg;
	HWND    hwndFrame,
	        hwndNotebook;
	
	hab = WinInitialize( 0 );
	if( !hab )
		return 0;
		
	hmq = WinCreateMsgQueue( hab, 0 );
	if( !hmq )
		return 0;
		
	hwndFrame = create_frame();
	hwndNotebook = create_notebook( hwndFrame );
	
	WinShowWindow( hwndFrame, TRUE );
	
    while( WinGetMsg( hab, &qmsg, NULLHANDLE, 0, 0 ) )
        WinDispatchMsg( hab, &qmsg );
	
	WinDestroyMsgQueue( hmq );
	WinTerminate( hab );
	
	return 0;
};
