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
#define INCL_DOSERRORS
#define INCL_WIN
#include <os2.h>
#include <stdlib.h>
#include <string.h>
#include "task_view.h"
#include "update.h"


#define NUM_OF_COLUMNS			6
#define CONTAINER_DELTA	43

extern HMUX	hmuxUpdate;

		
HWND    	hwndNotebook,
       		hwndCntr,
       		hwndClassMenu,
       		hwndDeltaMenu;
PFNWP    	originalOwnerWinProc,
         	originalCntrWinProc;
SHORT		iconColXLeft,
			iconColXRight,
			commandColXLeft,
			commandColXRight,
			classColXLeft,
			classColXRight;
HPOINTER 	hPlusIcon,
         	hMinusIcon;

MRESULT EXPENTRY ownerWinProc( HWND, ULONG, MPARAM, MPARAM );
MRESULT EXPENTRY cntrWinProc( HWND, ULONG, MPARAM, MPARAM );
void create_columns( HWND );
LONG expand( PAPPRECORD );
LONG collapse( PAPPRECORD );


HWND create_task_view( HWND hwnd )
{
	int	tid;
	
	hwndNotebook = hwnd;

	originalOwnerWinProc = WinSubclassWindow( hwndNotebook, ( PFNWP ) ownerWinProc );

	hPlusIcon = WinLoadPointer( HWND_DESKTOP, NULLHANDLE, IDC_PLUS );
	hMinusIcon = WinLoadPointer( HWND_DESKTOP, NULLHANDLE, IDC_MINUS );
	hwndClassMenu = WinLoadMenu( hwndNotebook, NULLHANDLE, IDM_CLASSMENU );
	
	hwndCntr = WinCreateWindow( hwndNotebook,
                                WC_CONTAINER,
                                "Task Container",
                                CCS_AUTOPOSITION |
                                CCS_READONLY |
                                CCS_SINGLESEL |
                                CCS_MINIRECORDCORE,
                                0, 0, 0, 0,
                                hwndNotebook,
                                HWND_BOTTOM,
                                ID_TASKCONTAINER,
                                NULL,
                                NULL);

	originalCntrWinProc = WinSubclassWindow( hwndCntr, ( PFNWP ) cntrWinProc );

	create_columns( hwndCntr );
	
	tid = _beginthread( update_thread, NULL, 32768, ( PVOID ) hwndCntr );
	
	DosSetPriority( PRTYS_THREAD,
   	  			    PRTYC_IDLETIME,
   				    1,
   				    tid );
	
	return hwndCntr;
};


void create_columns( HWND hwndCntr )
{
	CNRINFO			cnrInfo;
	PFIELDINFO  	pfiColumn,
					pfiCur;
	FIELDINFOINSERT fiiColumn;
	USHORT			usColX;
	char 			buf[ 32 ];
	
	strcpy( buf, "9.WarpSans" );
	WinSetPresParam( hwndCntr,
					 PP_FONTNAMESIZE,
					 sizeof( buf ),
					 buf );
					
	cnrInfo.flWindowAttr = CV_DETAIL | CA_DETAILSVIEWTITLES;
	cnrInfo.slBitmapOrIcon.cx = 14;
	cnrInfo.slBitmapOrIcon.cy = 14;
    WinSendMsg( hwndCntr,
                CM_SETCNRINFO,
                &cnrInfo,
                MPFROMLONG( CMA_FLWINDOWATTR | CMA_SLBITMAPORICON ) );

	/*
	 *  allocate the details columns
	 *
	 **/

	pfiColumn = WinSendMsg( hwndCntr,
							CM_ALLOCDETAILFIELDINFO,
							MPFROMLONG( NUM_OF_COLUMNS ),
							MPFROMLONG( 0 ) );
	pfiCur = pfiColumn;
	
	usColX = 0;
	
	pfiCur->cb = sizeof( FIELDINFO );
	pfiCur->flData = CFA_STRING | CFA_SEPARATOR | CFA_RIGHT;
	pfiCur->flTitle = CFA_VCENTER | CFA_CENTER | CFA_FITITLEREADONLY;
	pfiCur->pTitleData = STR_COLTITLE_PID;
	pfiCur->offStruct = ( ULONG ) FIELDOFFSET( APPRECORD, pszPid );
	pfiCur->pUserData = 0;
	pfiCur->cxWidth = 28;
	
	usColX += pfiCur->cxWidth;
    pfiCur = pfiCur->pNextFieldInfo;
	

	pfiCur->cb = sizeof( FIELDINFO );
	pfiCur->flData = CFA_STRING | CFA_SEPARATOR | CFA_RIGHT;
	pfiCur->flTitle = CFA_VCENTER | CFA_CENTER | CFA_FITITLEREADONLY;
	pfiCur->pTitleData = STR_COLTITLE_PPID;
	pfiCur->offStruct = ( ULONG ) FIELDOFFSET( APPRECORD, pszPpid );
	pfiCur->pUserData = 0;
	pfiCur->cxWidth = 28;
	
	usColX += pfiCur->cxWidth;
    pfiCur = pfiCur->pNextFieldInfo;

	pfiCur->cb = sizeof( FIELDINFO );
	pfiCur->flData = CFA_BITMAPORICON | CFA_CENTER;
	pfiCur->flTitle = CFA_VCENTER | CFA_CENTER | CFA_FITITLEREADONLY;
	pfiCur->pTitleData = NULL;
	pfiCur->offStruct = ( ULONG ) FIELDOFFSET( APPRECORD, core.hptrIcon );
	pfiCur->pUserData = 0;
	pfiCur->cxWidth = 12;
	
	iconColXLeft = CONTAINER_DELTA + usColX;
	iconColXRight = iconColXLeft + pfiCur->cxWidth;
	usColX += pfiCur->cxWidth;
    pfiCur = pfiCur->pNextFieldInfo;

	pfiCur->cb = sizeof( FIELDINFO );
	pfiCur->flData = CFA_STRING | CFA_SEPARATOR | CFA_LEFT;
	pfiCur->flTitle = CFA_VCENTER | CFA_LEFT | CFA_FITITLEREADONLY;
	pfiCur->pTitleData = STR_COLTITLE_COMMAND;
	pfiCur->offStruct = ( ULONG ) FIELDOFFSET( APPRECORD, pszCommand );
	pfiCur->pUserData = 0;
	pfiCur->cxWidth = 450;

    cnrInfo.cb = sizeof( CNRINFO );
    cnrInfo.pFieldInfoLast = pfiCur;
    cnrInfo.xVertSplitbar = 360;
	WinSendMsg( hwndCntr,
	            CM_SETCNRINFO,
	            MPFROMP( &cnrInfo ),
                MPFROMLONG( CMA_PFIELDINFOLAST | CMA_XVERTSPLITBAR ) );

	commandColXLeft = usColX + CONTAINER_DELTA;
	commandColXRight = commandColXLeft + pfiCur->cxWidth;
	usColX += pfiCur->cxWidth;
    pfiCur = pfiCur->pNextFieldInfo;

	pfiCur->cb = sizeof( FIELDINFO );
	pfiCur->flData = CFA_STRING | CFA_SEPARATOR | CFA_CENTER;
	pfiCur->flTitle = CFA_VCENTER | CFA_CENTER | CFA_FITITLEREADONLY;
	pfiCur->pTitleData = STR_COLTITLE_CLASS;
	pfiCur->offStruct = ( ULONG ) FIELDOFFSET( APPRECORD, pszClass );
	pfiCur->pUserData = 0;
	pfiCur->cxWidth = 40;

	classColXLeft = usColX;
    classColXRight = classColXLeft + pfiCur->cxWidth + 15;
    usColX += pfiCur->cxWidth;
	pfiCur = pfiCur->pNextFieldInfo;

	pfiCur->cb = sizeof( FIELDINFO );
	pfiCur->flData = CFA_STRING | CFA_SEPARATOR | CFA_CENTER;
	pfiCur->flTitle = CFA_VCENTER | CFA_CENTER | CFA_FITITLEREADONLY;
	pfiCur->pTitleData = STR_COLTITLE_DELTA;
	pfiCur->offStruct = ( ULONG ) FIELDOFFSET( APPRECORD, pszDelta );
	pfiCur->pUserData = 0;
	pfiCur->cxWidth = 40;
	
	usColX += pfiCur->cxWidth;
	
	/*
	 *  insert the columns
	 *
	 **/
	
	fiiColumn.cb = sizeof( FIELDINFOINSERT );
	fiiColumn.pFieldInfoOrder = ( PFIELDINFO ) CMA_FIRST;
	fiiColumn.fInvalidateFieldInfo = TRUE;
	fiiColumn.cFieldInfoInsert = NUM_OF_COLUMNS;
		
	WinSendMsg( hwndCntr,
	            CM_INSERTDETAILFIELDINFO,
	            pfiColumn,
	            &fiiColumn );
};


MRESULT EXPENTRY ownerWinProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 )
{
	switch( msg )
	{
		case WM_CONTROL:
			switch( SHORT2FROMMP( mp1 ) )
			{
			};
	};
	
    return ( *originalOwnerWinProc ) ( hwnd, msg, mp1, mp2 );
};


MRESULT EXPENTRY cntrWinProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 )
{
	QUERYRECFROMRECT	qrfr;	
	PAPPRECORD			parAppRec;
	

	switch( msg )
	{
		case WM_CHAR:
			if( SHORT1FROMMP( mp1 ) & KC_CHAR )
				switch( SHORT1FROMMP( mp2 ) )
				{
					case KC_PLUS:
						parAppRec = WinSendMsg( hwnd,
												CM_QUERYRECORDEMPHASIS,
												MPFROMLONG( CMA_FIRST ),
												MPFROMLONG( CRA_SELECTED ) );
				
				        if( !parAppRec )
				        	break;
				        	
				        if( !parAppRec->pqProcess )
				        	break;
				
						if( parAppRec->core.flRecordAttr & CRA_EXPANDED )
							break;
							
						return ( MRESULT ) expand( parAppRec );
						
					case KC_MINUS:
						parAppRec = WinSendMsg( hwnd,
												CM_QUERYRECORDEMPHASIS,
												MPFROMLONG( CMA_FIRST ),
												MPFROMLONG( CRA_SELECTED ) );
				
				        if( !parAppRec )
				        	break;
				        	
				        if( !parAppRec->pqProcess )
				        	break;
				
						if( parAppRec->core.flRecordAttr & CRA_COLLAPSED )
							break;
							
						return ( MRESULT ) collapse( parAppRec );
				};
			break;
		
		case WM_BUTTON1UP:
		    if( ( ( PPOINTS ) &mp1 )->x < iconColXLeft ||
		        ( ( PPOINTS ) &mp1 )->x > iconColXRight )
				break;            	
		
			qrfr.cb = sizeof( QUERYRECFROMRECT );
			qrfr.rect.xLeft   = ( ( PPOINTS ) &mp1 )->x;
			qrfr.rect.yBottom = ( ( PPOINTS ) &mp1 )->y;
			qrfr.rect.xRight  = ( ( PPOINTS ) &mp1 )->x + 1;
			qrfr.rect.yTop    = ( ( PPOINTS ) &mp1 )->y + 1;
			qrfr.fsSearch = CMA_ITEMORDER | CMA_PARTIAL;
			
			parAppRec = WinSendMsg( hwnd,
									CM_QUERYRECORDFROMRECT,
									MPFROMLONG( CMA_FIRST ),
									MPFROMLONG( &qrfr ) );
						
			if( !parAppRec )
				break;
				
			if( parAppRec->core.flRecordAttr & CRA_EXPANDED )
				return ( MPARAM ) collapse( parAppRec );
			else
				return ( MPARAM ) expand( parAppRec );
			
			break;
			
		case WM_BUTTON2DOWN:
			/*
		    if( ( ( PPOINTS ) &mp1 )->x < classColXLeft ||
		        ( ( PPOINTS ) &mp1 )->x > classColXRight )
				break;            	
            */
			qrfr.cb = sizeof( QUERYRECFROMRECT );
			qrfr.rect.xLeft   = ( ( PPOINTS ) &mp1 )->x;
			qrfr.rect.yBottom = ( ( PPOINTS ) &mp1 )->y;
			qrfr.rect.xRight  = ( ( PPOINTS ) &mp1 )->x + 1;
			qrfr.rect.yTop    = ( ( PPOINTS ) &mp1 )->y + 1;
			qrfr.fsSearch = CMA_ITEMORDER | CMA_PARTIAL;
			
			parAppRec = WinSendMsg( hwnd,
									CM_QUERYRECORDFROMRECT,
									MPFROMLONG( CMA_FIRST ),
									MPFROMLONG( &qrfr ) );
									
			if( !parAppRec )
				break;
				
			/*
			 *  if it's a process record, bail out
			 *
			 **/	
			
			/*
			if( parAppRec->pqProcess )
				break;
			*/
				
			/*
			 *  it's a thread record. popup thr menu with the correct class
			 *
			 **/	
			
			/*
			WinSendMsg( hwndClassMenu,
						MM_SETITEMATTR,
						MPFROM2SHORT( IDM_CM_BASE + atoi( parAppRec->pszDelta ), FALSE ),
						MPFROM2SHORT( MIA_CHECKED, MIA_CHECKED ) );
			*/
				
			WinPopupMenu( hwnd,
						  hwnd,
						  hwndClassMenu,
						  ( ( PPOINTS ) &mp1 )->x/* + commandColXRight*/,
						  ( ( PPOINTS ) &mp1 )->y,
						  0,
						  0 );
						
			DosBeep( 100, 100 );
			return ( MPARAM ) 0;
		
			
	};
	
	return ( *originalCntrWinProc ) ( hwnd, msg, mp1, mp2 );
};


LONG expandCollapse( PAPPRECORD parAppRec, BOOL fWhat )
{
	PQTHREAD        pqThread;
	PAPPRECORD *    refreshList;
	int             i;

    if( parAppRec->pqProcess == NULL )
        return -1;

    /*
     *  must take semaphore!
     *
     **/

    if( WinRequestMutexSem( hmuxUpdate, 3 * 1000 ) == ERROR_TIMEOUT )
        return -1;

	if( fWhat )
	{
    	parAppRec->core.flRecordAttr &= ~CRA_COLLAPSED;
    	parAppRec->core.flRecordAttr |= CRA_EXPANDED;
    	parAppRec->core.hptrIcon = hMinusIcon;
    }
    else
    {
    	parAppRec->core.flRecordAttr &= ~CRA_EXPANDED;
    	parAppRec->core.flRecordAttr |= CRA_COLLAPSED;
    	parAppRec->core.hptrIcon = hPlusIcon;
    };

    refreshList = ( PAPPRECORD * ) malloc( sizeof( PAPPRECORD ) * parAppRec->pqProcess->threadcnt + 1 );
    refreshList[ 0 ] = parAppRec;

    pqThread = parAppRec->pqProcess->threads;

    for( i = 0; i < parAppRec->pqProcess->threadcnt; i++, pqThread++ )
    {
        refreshList[ i + 1 ] = ( PAPPRECORD ) pqThread->sleepid;
        if( fWhat )
        	( ( PAPPRECORD ) pqThread->sleepid )->core.flRecordAttr &= ~CRA_FILTERED;
        else
        	( ( PAPPRECORD ) pqThread->sleepid )->core.flRecordAttr |= CRA_FILTERED;
    };

    WinSendMsg( hwndCntr,
                CM_INVALIDATERECORD,
                MPFROMLONG( refreshList ),
                MPFROMLONG( i + 1 ) );

    DosReleaseMutexSem( hmuxUpdate );

    free( refreshList );
    return 0;
};


LONG expand( PAPPRECORD parAppRec )
{
	return expandCollapse( parAppRec, TRUE );
};


LONG collapse( PAPPRECORD parAppRec )
{
	return expandCollapse( parAppRec, FALSE );
};
		

