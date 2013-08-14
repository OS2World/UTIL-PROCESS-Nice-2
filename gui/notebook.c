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
#include <string.h>
#include "task_view.h"
#include "notebook.h"


HWND create_notebook( HWND hwndFrame )
{	
 	HWND	hwndNotebook,
 	        hwndTaskView,
 	        hwndSettings,
 	        hwndAbout;
 	
 	ULONG	ulPageId;
 	CHAR	buf[ 32 ];
 	
 	hwndNotebook = WinCreateWindow( hwndFrame,
 							   	    WC_NOTEBOOK,
 					 				NULL,
 					 				0x00000800 | BKS_MAJORTABRIGHT |
 					 				BKS_BACKPAGESBR |
 					 				BKS_SQUARETABS |
 					 				BKS_SPIRALBIND |
 					 				BKS_STATUSTEXTCENTER |
 					 				BKS_TABTEXTLEFT,
 					 				0, 0,
 					 				0, 0,
 					 				hwndFrame,
 					 				HWND_BOTTOM,
 					 				FID_CLIENT,
 					 				NULL,
 					 				NULL );
 					 				
	strcpy( buf, "9.WarpSans" );
	WinSetPresParam( hwndNotebook,
					 PP_FONTNAMESIZE,
					 sizeof( buf ),
					 buf );
	
    /*
     *  task view
     *
     **/

	ulPageId = ( ULONG ) WinSendMsg( hwndNotebook,
						  			 BKM_INSERTPAGE,
						  			 MPFROMLONG( 0 ),
						  			 MPFROM2SHORT( BKA_AUTOPAGESIZE | BKA_MAJOR, BKA_FIRST ) );
	
	WinSendMsg( hwndNotebook,
				BKM_SETTABTEXT,
				MPFROMLONG( ulPageId ),
				MPFROMLONG( "Task" ) );
	
	hwndTaskView = create_task_view( hwndNotebook );
	WinSendMsg( hwndNotebook,
				BKM_SETPAGEWINDOWHWND,
				MPFROMLONG( ulPageId ),
				MPFROMLONG( hwndTaskView ) );				
				
    /*
     *  settings view
     *
     **/

	ulPageId = ( ULONG ) WinSendMsg( hwndNotebook,
						  			 BKM_INSERTPAGE,
						  			 MPFROMLONG( 0 ),
						  			 MPFROM2SHORT( BKA_AUTOPAGESIZE | BKA_MAJOR, BKA_LAST ) );
	
	WinSendMsg( hwndNotebook,
				BKM_SETTABTEXT,
				MPFROMLONG( ulPageId ),
				MPFROMLONG( "Settings" ) );

    /*
     *  about view
     *
     **/

	ulPageId = ( ULONG ) WinSendMsg( hwndNotebook,
						  			 BKM_INSERTPAGE,
						  			 MPFROMLONG( 0 ),
						  			 MPFROM2SHORT( BKA_AUTOPAGESIZE | BKA_MAJOR, BKA_LAST ) );
	
	WinSendMsg( hwndNotebook,
				BKM_SETTABTEXT,
				MPFROMLONG( ulPageId ),
				MPFROMLONG( "About" ) );
 					 				
	return hwndNotebook;
};



