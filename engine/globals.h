/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: globals.h,v 1.1 1999/02/13 18:24:33 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:33 $
 *
 **/

#ifndef _GLOBALS_H_
#define _GLOBALS_H_


#ifdef _NICE_DEBUG_
#include <assert.h>
#define ASSERT( arg ) assert( arg )
#define ERRORBEEP( time ) DosBeep( 100, time )
#else
#define ASSERT( arg )
#define ERRORBEEP( time )
#endif


typedef struct _NICERP		// request packet
{
	PID			pid;
	TID			tid;
	ULONG		ulClass;
	LONG		lDelta;
	HEV			hevDone;	
	APIRET  	rc;

} NICERP, * PNICERP;


/*
 *  module names
 *
 **/

#define NICE_MODULE_HOOK   	    	"NICEDHK"
#define NICE_MODULE_ENGINE  		"NICEDMN"


/*
 *  command line options
 *
 **/

#define NICE_OPTION_VERBOSE			0x00000001


/*
 *  engine strings
 *
 **/

#define NICE_HEV_INSTANCE			"\\SEM32\\NICE\\NICE.SEM"
#define NICE_QUEUE_ENGINE			"\\QUEUES\\NICE\\ENGINE.QUE"
#define NICE_QUEUE_INST_HOOK        "\\QUEUES\\NICE\\INSTHOOK.QUE"
#define NICE_QUEUE_TP_HOOK      	"\\QUEUES\\NICE\\TPHOOK.QUE"
#define NICE_PIPE_CONSOLE           "\\PIPE\\NICE\\CONSOLE.P"


/*
 *  error codes
 *
 **/

#define NO_ERROR			 	 	0
#define ERR_USAGE					-1
#define ERR_INSTANCE        		-2
#define ERR_ENGINE_STARTED 			-3
#define ERR_ENGINE_STOPPED			-4
#define ERR_WINSETHOOK				-5
#define ERR_NOT_PM_PROCESS  		-6
#define ERR_HWND_NOT_FOUND			-7


/*
 *  Engine Commands
 *
 **/

#define NICE_CMD_START    			0x0000F00D 	// start the engine
#define NICE_CMD_STOP           	0x0000D00F 	// stop the engine
#define NICE_CMD_SET_PP				0x0000FF01 	// set process priority
#define NICE_CMD_SET_TP				0x0000FF02 	// set thread priority
#define NICE_IOCTL_PASSIVEMODE      0x0000FF03  // switch to passive mode
#define NICE_IOCTL_ACTIVEMODE       0x0000FF04  // switch to active mode


/*
 *  Engine Modes
 *
 **/

#define MODE_PASSIVE                0x00000001
#define MODE_ACTIVE                 0x00000002


/*
 *  Timeouts
 *
 **/

#define NICE_CLIENT_TIMEOUT			30000       // max time a client should wait
#define NICE_CTXHOOK_TIMEOUT    	10000       // max time to wait for context hook to complete
#define NICE_ENGINE_STOP_TIMEOUT    10000       // max time to wait for the engine to stop
#define NICE_ENGINE_HOOK_TIMEOUT    6000        // max time to wait for the engine hook to process a request
#define NICE_UNLOAD_TIMEOUT			1000        // time to sleep before killing the engine thread


/*
 *  Engine States
 *
 **/

#define ENGINE_INC_FH                  10
#define ENGINE_OPENED_PIPE             11
#define ENGINE_STARTED                 12
#define ENGINE_ADD_EXIT_FUNC           13
#define ENGINE_QUEUE_CREATED           14
#define ENGINE_HOOK_HEV_CREATED        15
#define ENGINE_WIN_INIT                16
#define ENGINE_GET_PMSHELL_PID         17
#define ENGINE_READY                   18
#define ENGINE_GOT_REQUEST             19
#define ENGINE_ENDED                   20

#define ENGINE_CMD_SET_PP_START        30
#define ENGINE_CMD_SET_PP_END          31

#define ENGINE_CMD_SET_TP_START        40
#define ENGINE_MSGQUEUE_CREATED        41
#define ENGINE_PID_TO_HWND             42
#define ENGINE_ADD_HOOK_EXIT_FUNC      43
#define ENGINE_HOOK_INSTALLED          44
#define ENGINE_PRE_HOOK_FIRE           45
#define ENGINE_POST_HOOK_FIRE          46
#define ENGINE_WAIT_HEV_HOOK           47
#define ENGINE_RETURNED_HEV_HOOK       48
#define ENGINE_HOOK_REMOVED            49
#define ENGINE_DEL_HOOK_EXIT_FUNC      50
#define ENGINE_MSGQUEUE_DESTROYED      51
#define ENGINE_CMD_SET_TP_END          52

#define ENGINE_CMD_STOP_START          60
#define ENGINE_CMD_STOP_END            61

#define ENGINE_IOCTL_PASSIVEMODE_START 70
#define ENGINE_IOCTL_PASSIVEMODE_END   71

#define ENGINE_IOCTL_ACTIVEMODE_START  80
#define ENGINE_IOCTL_ACTIVEMODE_END    81

#define ENGINE_HOOK_XF_STARTED		   101
#define ENGINE_XF_STARTED	           102


#endif
