/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan <idagan@il.ibm.com>
 *
 *  $Id: nice.h,v 1.1 1999/02/13 18:24:33 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:33 $
 *
 **/

#ifndef _NICE_H_
#define _NICE_H_


#ifdef _cplusplus
extern "C" {
#endif

#define INCL_DOS
#include <os2.h>


/*
 *  Function: NiceSetPriority
 *  Parameters:
 *      pid (input)     - PID of the process
 *      tid (input)     - TID of the thread. If TID is 0, all threads within the
 *                        given PID will be altered. TID > 0 is valid for PM
 *                        processes only
 *      ulClass (input) - Priority class (See OS/2's DosSetPriority)
 *                        0  PRTYC_NOCHANGE          no change, leave as is
 *                        1  PRTYC_IDLETIME          idle-time
 *                        2  PRTYC_REGULAR           regular
 *                        3  PRTYC_TIMECRITICAL      time critical
 *                        4  PRTYC_FOREGROUNDSERVER  server
 *
 *      lDelta (input)  - This value must range from -31 (PRTYD_MINIMUM) to +31
 *                        (PRTYD_MAXIMUM).
 *  Returns:
 *      rc = 0  - successful
 *      rc != 0 - some error
 *
 **/

APIRET NiceSetPriority( PID pid,
                        TID tid,
                        ULONG ulClass,
                        LONG  lDelta );


/*
 *  Function: NiceStatus
 *  Parameters: none
 *  Returns:
 *      rc = 0 - NICE/2 engine is not running
 *      rc > 0 - NICE/2 engine is running under the PID = rc
 *
 **/

APIRET NiceStatus( VOID );


/*
 *  Function: NiceIOCtl
 *  Parameters:
 *		cmd (input)    - command
 *		param1 (input) - command specific information	
 *		param2 (input) - command specific information	
 *	Returns:	
 *      Command specific return code
 *
 *  Remarks:
 *      Use this function to operate the NICE/2 engine. Supported commands:
 *
 *      NICE_IOCTL_PASSIVEMODE - Tell the engine to switch to passive mode. This is
 *          the default. In this mode, when a NICE_CMD_SET_TP (set thread priority)
 *          request is processed, a system wide Input Hook (HK_INPUT) is installed.
 *          When the request has been served, the hook is removed. Switch the engine to
 *          active mode if you intend to interact alot with it - for instance, when
 *          you create a GUI wrapper application for NICE/2 that is expected to
 *          process more than a few requests - this is what NICEPM does.
 *
 *
 *      NICE_IOCTL_ACTIVEMODE - Tell the engine to switch to active mode. in this
 *          mode of operation, the engine uses more OS/2 resources but is more
 *          responsive and takes less CPU to process each request. First time the
 *          NICE_CMD_SET_TP reqeust is recieved, the engine installs a system wide
 *          Input Hook (HK_INPUT). When the request has been served, the engine keeps
 *          the hook installed until a NICE_IOCTL_PASSIVEMODE request is recieved and
 *          successfully processed. It is the resposiblity of the client to set the
 *          engine back to passive mode - a good time to do that would be just before the
 *          application is shutting down or has recieved a WM_QUIT command (OS/2
 *          is shutting down).
 *
 **/

#ifndef _GLOBALS_H_

#define NICE_IOCTL_PASSIVEMODE      0x0000FF03
#define NICE_IOCTL_ACTIVEMODE       0x0000FF04

#endif // _GLOBALS_H_

APIRET NiceIOCtl( ULONG cmd, ULONG param1, ULONG param2 );


#ifdef _cplusplus
}
#endif


#endif // _NICE_H_
