/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: client.c,v 1.1 1999/02/13 18:24:10 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:10 $
 *
 **/

#define INCL_DOS
#define INCL_DOSERRORS
#include <os2.h>
#include "nice.h"
#include "globals.h"
#include "dosqss.h"


#define MEMPOOL     32768


APIRET NiceSetPriority( PID pid,
                        TID tid,
                        ULONG ulClass,
                        LONG  lDelta )
{
    APIRET          rc;
    APIRET          result;
    HQUEUE          hq;
    PID             pidEngine;
    HEV             hevDone;
    PNICERP         pNiceRP;
    PQTOPLEVEL      pTop;
    PQPROCESS       pqProcess;
    PQTHREAD        pqThread;
    LONG            i;

    rc = DosAllocSharedMem( ( PPVOID ) &pNiceRP,
                            NULL,
                            sizeof( NICERP ),
                            PAG_COMMIT | OBJ_GETTABLE | PAG_READ | PAG_WRITE );
    ASSERT( !rc );
    if( rc )
        return rc;

    pNiceRP->pid = pid;
    pNiceRP->tid = tid;
    pNiceRP->ulClass = ulClass;
    pNiceRP->lDelta = lDelta;
    pNiceRP->rc = 0;

    rc = DosCreateEventSem( NULL,
                            &hevDone,
                            DC_SEM_SHARED,
                            FALSE );
    ASSERT( !rc );
    if( rc )
        return rc;

    pNiceRP->hevDone = hevDone;

    /*
     *  see if we were given a valid pid. also, if tid > 0 see what type
     *  the process is - tid scope changes can only be made PM processes.
     *
     **/

    DosAllocMem( ( PPVOID ) &pTop, MEMPOOL, PAG_COMMIT | PAG_READ | PAG_WRITE );
    DosQuerySysState( 0x01, 0L, pid, 0L, ( PCHAR ) pTop, MEMPOOL );

    pqProcess = pTop->procdata;
    while( pqProcess && pqProcess->rectype == 1 )
    {
        if( pqProcess->pid == pid )
            if( tid > 0 )
            {
                if( pqProcess->type != 3 ) // not PM Process
                {
                    DosFreeMem( pTop );
                    return ERR_NOT_PM_PROCESS;
                }

                pqThread = pqProcess->threads; // see that the tid exists
                for( i = 0; i < pqProcess->threadcnt; i++, pqThread++ )
                    if( pqThread->threadid == tid )
                        break;

                if( pqThread->threadid == tid )
                    break;

                DosFreeMem( pTop ); // if we get here then the tid is invalid
                return ERROR_INVALID_THREADID;
            }
            else
                break;

        pqThread = pqProcess->threads;
        for( i = 0; i < pqProcess->threadcnt; i++, pqThread++ );

        pqProcess = ( PQPROCESS ) pqThread;
    };
    if( pqProcess->pid != pid ) // pid not found
        return ERROR_INVALID_PROCID;

    DosFreeMem( pTop );

    rc = DosOpenQueue( &pidEngine, &hq, NICE_QUEUE_ENGINE );
    ASSERT( !rc );
    if( rc )
        if( rc == ERROR_QUE_NAME_NOT_EXIST )
            return ERR_ENGINE_STOPPED;
        else
            return rc;

    rc = DosWriteQueue( hq,
                        tid ? NICE_CMD_SET_TP : NICE_CMD_SET_PP,
                        sizeof( NICERP ),
                        ( PVOID ) pNiceRP,
                        0 );
    ASSERT( !rc );

    rc = DosCloseQueue( hq );

    rc = DosWaitEventSem( hevDone, NICE_CLIENT_TIMEOUT );
    DosCloseEventSem( hevDone );

    if( rc )
    	result = rc;
	else
    	result = pNiceRP->rc;

    rc = DosFreeMem( pNiceRP );

    return result;
};


APIRET NiceStatus( VOID )
{
    APIRET      rc;
    PID         pid;
    HQUEUE      hq;

    rc = DosOpenQueue( &pid, &hq, NICE_QUEUE_ENGINE );
    if( !rc )
    {
        DosCloseQueue( hq );
        return pid;
    };

    return 0;
};


APIRET NiceIOCtl( ULONG cmd, ULONG param1, ULONG param2 )
{
    APIRET          rc;
    APIRET          result;
    HQUEUE          hq;
    PID             pidEngine;
    HEV             hevDone;
    PNICERP         pNiceRP;

    rc = DosAllocSharedMem( ( PPVOID ) &pNiceRP,
                            NULL,
                            sizeof( NICERP ),
                            PAG_COMMIT | OBJ_GETTABLE | PAG_READ | PAG_WRITE );
    ASSERT( !rc );
    if( rc )
        return rc;

    pNiceRP->pid = param1;
    pNiceRP->tid = param2;
    pNiceRP->ulClass = 0;
    pNiceRP->lDelta = 0;
    pNiceRP->rc = 0;

    rc = DosCreateEventSem( NULL,
                            &hevDone,
                            DC_SEM_SHARED,
                            FALSE );
    ASSERT( !rc );
    if( rc )
        return rc;

    pNiceRP->hevDone = hevDone;

    rc = DosOpenQueue( &pidEngine, &hq, NICE_QUEUE_ENGINE );
    ASSERT( !rc );
    if( rc )
        if( rc == ERROR_QUE_NAME_NOT_EXIST )
            return ERR_ENGINE_STOPPED;
        else
            return rc;

    rc = DosWriteQueue( hq,
                        cmd,
                        sizeof( NICERP ),
                        ( PVOID ) pNiceRP,
                        0 );
    ASSERT( !rc );

    rc = DosCloseQueue( hq );

    rc = DosWaitEventSem( hevDone, NICE_CLIENT_TIMEOUT );
    DosCloseEventSem( hevDone );

    if( rc )
    	result = rc;
	else
    	result = pNiceRP->rc;

    rc = DosFreeMem( pNiceRP );

    return result;
};	



