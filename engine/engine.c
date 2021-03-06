/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  The engine is started as a seperated thread within the context of the PM
 *  (see hook.c). When started, the engine first registers an exit list function
 *  so a proper cleanup can be made if something goes wrong. Next, the listener
 *  queue is created and engine initialize itself to be able to use PM APIs.
 *  When all initialization is done, engine goes into an infinite loop blocking
 *  on the listner queue until there's a requst.
 *
 *  The engine then takes the request from the queue and decodes it. With every
 *  request, there's a handle of an event semaphore provided by the client. The
 *  clients writes the request to the queue (shared memory) and then waits on this
 *  event semaphore. When the request is served by the engine, the request return
 *  code is put back on the requset packet and the engine posts the semaphore.
 *
 *  The client wakes up, inspects the return code and decides what to do with it.
 *
 *  $Id: engine.c,v 1.1 1999/02/13 18:24:10 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:10 $
 *
 **/

#define INCL_DOS
#define INCL_DOSERRORS
#define INCL_WIN
#include <os2.h>
#include "globals.h"
#include "util.h"
#include "menu.h"


HMODULE  gHmEngine;		        // exported
TID		 gTidEngine;            //

HQUEUE   gHq;         	        // globals to ease cleanup
HAB	     gHab;                  //
HMQ      gHmq;                  //
HEV		 gHevHookDone;          //
ULONG    gHookInstalled;        //

ULONG    gEngineState;          // engine state

VOID     ReportRC( PNICERP, APIRET );
BOOL    _System InputHook( HAB hab, PQMSG pqmsg, ULONG fs );
VOID    _System HookCleanup( VOID );
VOID    _System EngineCleanup( VOID );


#ifdef _RT_DEBUG_
HFILE	 gHfConsole;            // console

/*
 *  can't use C run time, and don't want to be depended on specific compiler,
 *  so no '...' macros.
 *
 **/


#define SAY( fmt ) \
		if( gHfConsole ) \
		ToConsole( fmt, 0, 0, 0, 0, 0 );
		
#define SAY1( fmt, arg1 ) \
		if( gHfConsole ) \
		ToConsole( fmt, ( PVOID ) arg1, 0, 0, 0, 0 );

#define SAY2( fmt, arg1, arg2 ) \
		if( gHfConsole ) \
		ToConsole( fmt, ( PVOID ) arg1, ( PVOID ) arg2, 0, 0, 0 );

#define SAY3( fmt, arg1, arg2, arg3 ) \
		if( gHfConsole ) \
		ToConsole( fmt, ( PVOID ) arg1, ( PVOID ) arg2, ( PVOID ) arg3, 0, 0 );

#define SAY4( fmt, arg1, arg2, arg3, arg4 ) \
		if( gHfConsole ) \
		ToConsole( fmt, ( PVOID ) arg1, ( PVOID ) arg2, ( PVOID ) arg3, ( PVOID ) arg4, 0 );

#define SAY5( fmt, arg1, arg2, arg3, arg4, arg5 ) \
		if( gHfConsole ) \
		ToConsole( fmt, ( PVOID ) arg1, ( PVOID ) arg2, ( PVOID ) arg3, ( PVOID ) arg4, ( PVOID ) arg5 );

#define SETSTATE( NewState ) \
       	SAY2( "[ENGINE] new state: %d  old state: %d", NewState, gEngineState ); \
        gEngineState = NewState;	


VOID ToConsole( CHAR * fmt, PVOID arg1, PVOID arg2, PVOID arg3, PVOID arg4, PVOID arg5 )
{
	PVOID		args[ 5 ];
	static CHAR	pBuf[ 512 ];
	ULONG		cbWritten;

	args[ 0 ] = arg1;
	args[ 1 ] = arg2;
	args[ 2 ] = arg3;
	args[ 3 ] = arg4;
	args[ 4 ] = arg5;

	my_vsprintf( pBuf, fmt, args );	

	DosWrite( gHfConsole, pBuf, my_strlen( pBuf ), &cbWritten );
	DosResetBuffer( gHfConsole );
};

#else
#define SETSTATE( NewState ) \
        gEngineState = NewState

#define SAY( fmt ) /* fmt */
#define SAY1( fmt, arg1 ) /* fmt */
#define SAY2( fmt, arg1, arg2 ) /* fmt */
#define SAY3( fmt, arg1, arg2, arg3 ) /* fmt */
#define SAY4( fmt, arg1, arg2, arg3, arg4 ) /* fmt */
#define SAY5( fmt, arg1, arg2, arg3, arg4, arg5 ) /* fmt */
#endif


VOID _System Engine( ULONG arg )
{
	APIRET		rc;
	HAB			hab;            // WinInitialize ...
	HMQ			hmq;
	
	HQUEUE      hq; 			// DosCreateQueue
    PID			pidEngine;
	
	REQUESTDATA	rd;    			// DosReadQueue
	ULONG		cbData;
	BYTE		bPriority;
	
	HEV			hevHookDone;    // handle request packet
	HEV			hevRP;
	ULONG		ulPostCount;
	PNICERP		pNiceRP;
	HWND	    hwnd;
	PID			pid;

	PTIB		ptib;			// to get my PID
	PPIB		ppib;
	
	ULONG       ulEngineMode;
	
	#ifdef _RT_DEBUG_
    ULONG		ulAction;		// console
	#endif

	
    #ifdef _RT_DEBUG_
	if( ( ULONG ) arg & NICE_OPTION_VERBOSE )
	{
		rc = DosOpen( NICE_PIPE_CONSOLE,
			          &gHfConsole,	
				      &ulAction,
				      0,
				      0,
				      FILE_OPEN,
				      OPEN_SHARE_DENYREADWRITE |
				  	      OPEN_ACCESS_WRITEONLY |
				  	      OPEN_FLAGS_NO_CACHE,
				      0 );
		if( rc )
		{
		    ERRORBEEP( 100 );
		    DosExit( EXIT_THREAD, 1 );			
		};

		SETSTATE( ENGINE_OPENED_PIPE );
		SAY( "[ENGINE] successfully connected the console pipe" );
	};
	#endif
	
	SETSTATE( ENGINE_STARTED );	
	SAY( "[ENGINE] engine started..." );
	
	ulEngineMode   = MODE_PASSIVE;
	gHookInstalled = FALSE;
	
	DosGetInfoBlocks( &ptib, &ppib );
	pidEngine = ppib->pib_ulpid;
	SAY2( "[ENGINE] my PID = %d and my TID = %d", pidEngine, gTidEngine );

	/*
	 *  register a cleanup function
	 *
	 **/

	rc = DosExitList( EXLST_ADD, ( PFNEXITLIST ) EngineCleanup );
	if( rc )
	{
		SAY( "[ENGINE] failed to register the engine exit function" );
		SAY3( "[ENGINE] (%s:%d) DosExitList() rc = %d", __FILE__, __LINE__, rc );
		SAY( "[ENGINE] engine ending..." );
		
		#ifdef _RT_DEBUG_
		DosClose( gHfConsole );
		#endif
		
		DosExit( EXIT_THREAD, 1 );
	};
		
	SETSTATE( ENGINE_ADD_EXIT_FUNC );
	SAY( "[ENGINE] successfully registered the engine exit function" );
	
	/*
	 *  create listener queue
	 *
	 **/
	
    rc = DosCreateQueue( &hq,
    					 QUE_FIFO,
    					 NICE_QUEUE_ENGINE );
	gHq = hq;		
	if( rc )
	{
		SAY( "[ENGINE] failed to create the engine queue" );
		SAY3( "[ENGINE] (%s:%d) DosCreateQueue() rc = %d", __FILE__, __LINE__, rc );
		SAY( "[ENGINE] engine ending..." );
		DosExit( EXIT_THREAD, 1 );
	};
			
	SETSTATE( ENGINE_QUEUE_CREATED );	
	SAY( "[ENGINE] successfully created the engine queue" );
	
    /*
     *  semaphore to communicate with the engine PM hook
     *  only used during NICE_SET_TP commands
     *
     **/

	rc = DosCreateEventSem( NULL, &hevHookDone, DC_SEM_SHARED, FALSE );
	gHevHookDone = hevHookDone;	
	if( rc )
	{
		SAY( "[ENGINE] failed to create the engine hook event semaphore" );
		SAY3( "[ENGINE] (%s:%d) DosCreateEventSem() rc = %d", __FILE__, __LINE__, rc );
		SAY( "[ENGINE] engine ending..." );
		DosExit( EXIT_THREAD, 1 );
	};
		
	SETSTATE( ENGINE_HOOK_HEV_CREATED );
	SAY( "[ENGINE] successfully created the engine hook event semaphore" );
	
    /*
     *  a message queue is needed to support the NICE_SET_TP command
     *
     **/

	hab = WinInitialize( 0 );
	gHab = hab;
	if( hab == 0 )
	{
		SAY( "[ENGINE] failed to create a HAB" );
		SAY2( "[ENGINE] (%s:%d) WinInitialize() failed", __FILE__, __LINE__ );
		SAY( "[ENGINE] engine ending..." );
		DosExit( EXIT_THREAD, 1 );
	};
	
	SETSTATE( ENGINE_WIN_INIT );
	SAY( "[ENGINE] successfully created HAB" );

	hmq = WinCreateMsgQueue( hab, 0 );		
	gHmq = hmq;	
	if( !hmq )
	{
		SAY( "[ENGINE] failed to create a msg queue" );
		SAY3( "[ENGINE] (%s:%d) WinCreateMsgQueue() rc = %d", __FILE__, __LINE__, rc );
		SAY( "[ENGINE] engine ending..." );
		DosExit( EXIT_THREAD, 1 );		
	};
				
	SETSTATE( ENGINE_MSGQUEUE_CREATED );	
	SAY( "[ENGINE] successfully created a msg queue" );
			
	WinCancelShutdown( hmq, TRUE );
	
	while( TRUE )
	{
		SETSTATE( ENGINE_READY );
		SAY( "[ENGINE] ready to proccess requests" );
	
		/*
		 *  block until there's something in the queue
		 *
		 **/
	
		rc = DosReadQueue( hq,
						   &rd,
						   &cbData,
						   ( PPVOID ) &pNiceRP,
						   0,
						   DCWW_WAIT,
						   &bPriority,
						   0 );	
		if( rc )
		{
			SAY( "[ENGINE] failed to read a request" );
			SAY3( "[ENGINE] (%s:%d) DosReadQueue() rc = %d", __FILE__, __LINE__, rc );
			SAY( "[ENGINE] engine ending..." );
			break;
		};
		
		SETSTATE( ENGINE_GOT_REQUEST );
		SAY4( "[ENGINE] got request\n" \
		      "         ulData    = %d\n" \
		      "         cbData    = %d\n" \
		      "         pNiceRP   = 0x%x\n" \
		      "         bPriority = %d",
		      rd.ulData,
		      cbData,
		      pNiceRP,
		      bPriority );
			
		if( rd.ulData == NICE_CMD_STOP )
		{
			SETSTATE( ENGINE_CMD_STOP_START );
			SAY( "[ENGINE] start command NICE_CMD_STOP (stop engine)" );
			
			/*
			 *  cleanup and stop the engine - actualy there's nothing to cleanup
			 *  in this version... the DLL itself is unloaded by hook.c
			 *
			 **/
			
			rc = DosGetSharedMem( ( PVOID ) pNiceRP, PAG_READ | PAG_WRITE );
			if( rc )
			{
				SAY( "[ENGINE] failed to get access to a shared memory block" );
				SAY3( "[ENGINE] (%s:%d) DosGetSharedMem() rc = %d", __FILE__, __LINE__, rc );
				SAY( "[ENGINE] engine ending..." );
				break;
			};

			/*
			 *  ReportRC() and DosFreeMem() are invoked just before the engine exits
			 *  outside this loop
			 *
			 **/
			
			SETSTATE( ENGINE_CMD_STOP_END );
			SAY( "[ENGINE] end command NICE_CMD_STOP" );
			break; // exit the engine loop
		}
		else if( rd.ulData == NICE_CMD_SET_PP )
		{
			SETSTATE( ENGINE_CMD_SET_PP_START );
			SAY( "[ENGINE] start command NICE_CMD_SET_PP (set process priority)" );
		
			rc = DosGetSharedMem( ( PVOID ) pNiceRP, PAG_READ | PAG_WRITE );
			if( rc )
			{
				SAY( "[ENGINE] failed to get access to a shared memory block" );
				SAY3( "[ENGINE] (%s:%d) DosGetSharedMem() rc = %d", __FILE__, __LINE__, rc );
				SAY( "[ENGINE] aborting request" );
				continue;
			};
			
			SAY3( "[ENGINE] about to invoke DosSetPriority() with\n" \
			      "         scope   = PRTYS_PROCESS\n" \
			      "         ulClass = %d\n" \
			      "         delta   = %d\n" \
			      "         PorTid  = %d",
			      pNiceRP->ulClass,
			      pNiceRP->lDelta,
			      pNiceRP->pid );
			
			rc = DosSetPriority( PRTYS_PROCESS,
			 				     pNiceRP->ulClass,
								 pNiceRP->lDelta,
								 pNiceRP->pid );

			SAY1( "[ENGINE] DosSetPriority() rc = %d", rc );								
			
			ReportRC( pNiceRP, rc );
			rc = DosFreeMem( pNiceRP );
			
			SETSTATE( ENGINE_CMD_SET_PP_END );
			SAY( "[ENGINE] end command NICE_CMD_SET_PP (set process priority)" );			
		}
		else if( rd.ulData == NICE_CMD_SET_TP )
		{
			SETSTATE( ENGINE_CMD_SET_TP_START );
            SAY( "[ENGINE] start command NICE_CMD_SET_TP (set thread priority)" );			

			rc = DosGetSharedMem( ( PVOID ) pNiceRP, PAG_READ | PAG_WRITE );
			if( rc )
			{
				SAY( "[ENGINE] failed to get access to a shared memory block" );
				SAY3( "[ENGINE] (%s:%d) DosGetSharedMem() rc = %d", __FILE__, __LINE__, rc );
				SAY( "[ENGINE] aborting request" );
				continue;
			};

			#ifdef _ENGINE_DEBUG_
			ReportRC( pNiceRP, NO_ERROR );
			DosFreeMem( pNiceRP );
			continue;
			#endif
                     			
			SETSTATE( ENGINE_PID_TO_HWND );
			SAY1( "[ENGINE] about to invoke sqlPidToHwnd for PID = %d", pNiceRP->pid );
			
			rc = swlPidToHwnd( pNiceRP->pid, &hwnd );
			
			if( rc )
			{	
				SAY1( "[ENGINE] failed to find the HWND of PID = %d", pNiceRP->pid );
				SAY3( "[ENGINE] (%s:%d) swlPidToHwnd() rc = %d\n" \
				      "         Note: the real error is somewhere in util.c : swlPidToHwnd",
				      __FILE__, __LINE__, rc );
				SAY( "[ENGINE] aborting request" );

				ReportRC( pNiceRP, ERR_HWND_NOT_FOUND );
				rc = DosFreeMem( pNiceRP );
				
				continue;
			};
			
			SAY2( "[ENGINE] PID = %d -> HWND = 0x%x", pNiceRP->pid, hwnd );

			/*
			 *  install the hook only if in passive mode or if it is the first
			 *  time in active mode
			 *
			 **/	
		
			if( ulEngineMode & MODE_PASSIVE ||
			    ( ulEngineMode & MODE_ACTIVE && !gHookInstalled ) )
			{
  				rc = DosExitList( EXLST_ADD, ( PFNEXITLIST ) HookCleanup );			
  				if( rc )
  				{
	  				SAY( "[ENGINE] failed to register the hook exit function" );
  					SAY3( "[ENGINE] (%s:%d) DosExitList() rc = %d", __FILE__, __LINE__, rc );
  					SAY( "[ENGINE] aborting request" );
  				
  					ReportRC( pNiceRP, rc );
	  				rc = DosFreeMem( pNiceRP );
  				
  					continue;
  				};
  		
  				SETSTATE(  ENGINE_ADD_HOOK_EXIT_FUNC );
	  			SAY( "[ENGINE] successfully registered the hook exit function" );
			
                rc = WinSetHook( hab,
                                 NULLHANDLE,
                                 HK_INPUT,
                                 ( PFN ) InputHook,
                                 gHmEngine );
                if( !rc )
                {
                    rc = WinGetLastError( hab );
                    SAY( "[ENGINE] failed to install the hook" );
                    SAY5( "[ENGINE] (%s:%d) WinSetHook() failed. WinGetLastError() rc = %d\n" \
                          "         Severity = %d  Error Code = %d",
                          __FILE__, __LINE__, rc, ERRORIDSEV( rc ), ERRORIDERROR( rc ) );
                    SAY( "[ENGINE] aborting request" );

                    ReportRC( pNiceRP, ERR_WINSETHOOK );
                    rc = DosFreeMem( pNiceRP );

                    continue;
                };

                SETSTATE( ENGINE_HOOK_INSTALLED );
                SAY( "[ENGINE] hook installed" );

                gHookInstalled = TRUE;
            };
			
            hevRP = pNiceRP->hevDone;
            pNiceRP->hevDone = hevHookDone;              	

			/*
			 *  post a message to the window - this immediately returns but
			 *  it takes some time for the message to get to the hook
			 *
			 **/

			SETSTATE( ENGINE_PRE_HOOK_FIRE );
			SAY2( "[ENGINE] about to post the request to PID = %d HWND = 0x%x", pNiceRP->pid, hwnd );
			SAY3( "         where it will invoke DosSetPriority() with\n" \
			      "         scope   = PRTYS_THREAD\n" \
			      "         ulClass = %d\n" \
			      "         delta   = %d\n" \
			      "         PorTid  = %d",
			      pNiceRP->ulClass,
			      pNiceRP->lDelta,
			      pNiceRP->pid );
			
  			WinPostMsg( hwnd,
  			            WM_NULL,
  			            MPFROMLONG( NICE_CMD_SET_TP ),
  			            MPFROMLONG( pNiceRP ) );
  			
			SETSTATE( ENGINE_POST_HOOK_FIRE );
			SAY( "[ENGINE] request posted" );
			
			/*
			 *  wait for the hook to process the request - up to SET_TP_TIMEOUT
			 *  if the hook doesn't post the semaphore by this time we assume
			 *  it couldn't server the request
			 *
			 **/
			
			SETSTATE( ENGINE_WAIT_HEV_HOOK );
			SAY1( "[ENGINE] about to wait on the hook event semaphore for max %d milisecs", NICE_ENGINE_HOOK_TIMEOUT );
			
  			rc = DosWaitEventSem( hevHookDone, NICE_ENGINE_HOOK_TIMEOUT );
  			DosResetEventSem( hevHookDone, &ulPostCount );
  			
  			SETSTATE( ENGINE_RETURNED_HEV_HOOK );
  			SAY1( "[ENGINE] DosWaitEventSem() rc = %d", rc );
  			
  			pNiceRP->hevDone = hevRP;
  			
			/*
			 *  remove the hook
			 *
			 **/

			if( ulEngineMode & MODE_PASSIVE )
            {
                SAY( "[ENGINE] about to remove the hook" );

                WinReleaseHook( gHab,
                                NULLHANDLE,
                                HK_INPUT,
                                ( PFN ) InputHook,
                                gHmEngine );

                WinBroadcastMsg( HWND_DESKTOP,
                                 WM_NULL,
                                 0,
                                 0,
                                 BMSG_FRAMEONLY | BMSG_POST );

                SETSTATE( ENGINE_HOOK_REMOVED );
                SAY( "[ENGINE] hook removed and remove message was broadcasted" );

                DosExitList( EXLST_REMOVE, ( PFNEXITLIST ) HookCleanup );
                SETSTATE( ENGINE_DEL_HOOK_EXIT_FUNC );
                SAY( "[ENGINE] removed hook exit function" );

                gHookInstalled = FALSE;
			};
			
            /*
             *  tell the client that the request was processed
             *
             **/

			if( rc == ERROR_TIMEOUT ) // request never completed
			{
				SAY( "[ENGINE] the request never completed" );
				ReportRC( pNiceRP, rc );
			}
			else if( pNiceRP->rc )  // if the DosSetPriority failed inside the hook
  			{
  				SAY1( "[ENGINE] DosSetPriority() rc = %d", pNiceRP->rc );
  				ReportRC( pNiceRP, pNiceRP->rc );	
			}
			else
			    ReportRC( pNiceRP, NO_ERROR );
			
			rc = DosFreeMem( pNiceRP );
			
			SETSTATE( ENGINE_CMD_SET_TP_END );
			SAY( "[ENGINE] end command NICE_CMD_SET_TP (set thread priority)" );			
		}
		else if( rd.ulData == NICE_IOCTL_PASSIVEMODE )
		{
			SETSTATE( ENGINE_IOCTL_PASSIVEMODE_START );

			rc = DosGetSharedMem( ( PVOID ) pNiceRP, PAG_READ | PAG_WRITE );
			if( rc )
			{
				SAY( "[ENGINE] failed to get access to a shared memory block" );
				SAY3( "[ENGINE] (%s:%d) DosGetSharedMem() rc = %d", __FILE__, __LINE__, rc );
				SAY( "[ENGINE] aborting request" );
				continue;
			};
			
			ulEngineMode = MODE_PASSIVE;
			
			if( gHookInstalled )
			{
                SAY( "[ENGINE] about to remove the hook" );

                WinReleaseHook( gHab,
                                NULLHANDLE,
                                HK_INPUT,
                                ( PFN ) InputHook,
                                gHmEngine );

                WinBroadcastMsg( HWND_DESKTOP,
                                 WM_NULL,
                                 0,
                                 0,
                                 BMSG_FRAMEONLY | BMSG_POST );

                SETSTATE( ENGINE_HOOK_REMOVED );
                SAY( "[ENGINE] hook removed and remove message was broadcasted" );

                DosExitList( EXLST_REMOVE, ( PFNEXITLIST ) HookCleanup );
                SETSTATE( ENGINE_DEL_HOOK_EXIT_FUNC );
                SAY( "[ENGINE] removed hook exit function" );
            };

			ReportRC( pNiceRP, NO_ERROR );
			rc = DosFreeMem( pNiceRP );
			
			SETSTATE( ENGINE_IOCTL_PASSIVEMODE_END );
		}
		else if( rd.ulData == NICE_IOCTL_ACTIVEMODE )
		{
			SETSTATE( ENGINE_IOCTL_ACTIVEMODE_START );

			rc = DosGetSharedMem( ( PVOID ) pNiceRP, PAG_READ | PAG_WRITE );
			if( rc )
			{
				SAY( "[ENGINE] failed to get access to a shared memory block" );
				SAY3( "[ENGINE] (%s:%d) DosGetSharedMem() rc = %d", __FILE__, __LINE__, rc );
				SAY( "[ENGINE] aborting request" );
				continue;
			};
			
			ulEngineMode = MODE_ACTIVE;
			
			ReportRC( pNiceRP, NO_ERROR );
			rc = DosFreeMem( pNiceRP );
						
			SETSTATE( ENGINE_IOCTL_ACTIVEMODE_END );
		};
	};

	SETSTATE( ENGINE_ENDED );
	SAY( "[ENGINE] good bye" );
	
	rc = WinDestroyMsgQueue( hmq );
	rc = WinTerminate( hab );
	
	rc = DosCloseEventSem( hevHookDone );	
	rc = DosCloseQueue( hq );
	
    if( rd.ulData = NICE_CMD_STOP )
    {
		ReportRC( pNiceRP, NO_ERROR );
		DosFreeMem( pNiceRP );
	};
	
	#ifdef _RT_DEBUG_
    if( gHfConsole )
        DosClose( gHfConsole );
    #endif
	
	rc = DosExitList( EXLST_REMOVE, ( PFNEXITLIST ) EngineCleanup );
	DosExit( EXIT_THREAD, 1 );
};


VOID ReportRC( PNICERP pNiceRP, APIRET rc )
{
	SAY2( "[REPORT] reporting rc = %d and posting event semaphore HEV = 0x%x", rc, pNiceRP->hevDone );
	pNiceRP->rc = rc;
	DosOpenEventSem( NULL, &( pNiceRP->hevDone ) );
	DosPostEventSem( pNiceRP->hevDone );
	DosCloseEventSem( pNiceRP->hevDone );
};


/*
 *  when we enter here, we are running in the context of the target process.
 *  from within this context we can alter the priority of a single thread.
 *
 **/

BOOL _System InputHook( HAB hab, PQMSG pqmsg, ULONG fs )
{
	APIRET 		rc;
	HFILE		hf;
	ULONG		ulAction;

    if( pqmsg->msg == WM_NULL &&
    	LONGFROMMP( pqmsg->mp1 ) == NICE_CMD_SET_TP )
    {
    	#ifdef _RT_DEBUG_
    	if( gHfConsole )
			rc = DosOpen( NICE_PIPE_CONSOLE,
			          	  &hf,	
				      	  &ulAction,
				          0,
				          0,
				          FILE_OPEN,
				             OPEN_SHARE_DENYREADWRITE |
				  	         OPEN_ACCESS_WRITEONLY |
				  	         OPEN_FLAGS_NO_CACHE,
				          0 );
		#endif				

    	SAY( "[HOOK] hello" );

		/*
		 *  get access to the request packet
		 *
		 **/
			
		rc = DosGetSharedMem( ( PVOID ) ( PNICERP ) pqmsg->mp2, PAG_READ | PAG_WRITE );
		if( rc )
		{
			SAY( "[HOOK] failed to get access to a shared memory block" );
			SAY3( "[HOOK] (%s:%d) DosGetSharedMem() rc = %d", __FILE__, __LINE__, rc );
			SAY( "[HOOK] engine ending..." );
			
			#ifdef _RT_DEBUG_
        	if( gHfConsole )
        		DosClose( hf );
        	#endif

			return TRUE;
		};
		
		SAY( "[HOOK] about to invoke DosSetPriority()" );
		
		rc = DosSetPriority( PRTYS_THREAD,
							 ( ( PNICERP ) pqmsg->mp2 )->ulClass,
							 ( ( PNICERP ) pqmsg->mp2 )->lDelta,
							 ( ( PNICERP ) pqmsg->mp2 )->tid );
							
		SAY1( "[HOOK] invoked DosSetPriority() rc = %d", rc );							
		
		ReportRC( ( PNICERP ) pqmsg->mp2, rc );					
    	DosFreeMem( ( PNICERP ) pqmsg->mp2 );
		
        SAY( "[HOOK] goodbye" );

        #ifdef _RT_DEBUG_
        if( gHfConsole )
        	DosClose( hf );
        #endif

    	return TRUE; // don't pass on the message
    };

	return FALSE;
};


VOID _System HookCleanup( VOID )
{
	SETSTATE( ENGINE_HOOK_XF_STARTED );
	SAY2( "[ENGINE] (%s:%d) HookCleanup() is starting...", __FILE__, __LINE__ );

    WinReleaseHook( gHab,
       				NULLHANDLE,
       				HK_INPUT,
       				( PFN ) InputHook,
       				gHmEngine );
            				
    WinBroadcastMsg( HWND_DESKTOP,
                     WM_NULL,
                     0,
                     0,
                     BMSG_FRAMEONLY | BMSG_POST );

	DosExitList( EXLST_EXIT, ( PFNEXITLIST ) NULL );
};


VOID _System EngineCleanup( VOID )
{
	SETSTATE( ENGINE_XF_STARTED );
	SAY2( "[ENGINE] (%s:%d) EngineCleanup() is starting...", __FILE__, __LINE__ );

	WinTerminate( gHab );
	DosCloseEventSem( gHevHookDone );
	DosCloseQueue( gHq );
	
	#ifdef _RT_DEBUG_
    if( gHfConsole )
        DosClose( gHfConsole );
    #endif

	DosExitList( EXLST_EXIT, ( PFNEXITLIST ) NULL );
};



