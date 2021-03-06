/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  REXX Interface to NICE/2. Included functions:
 *
 *  RxNiceLoadFuncs
 *  RxNiceDropFuncs
 *  RxNiceStatus       - Requiers NICE/2 to be installed
 *  RxNiceSetPriority  - Requiers NICE/2 to be installed
 *  RxNicePS
 *  RxNiceMyPID
 *
 *
 *  $Id$
 *  $Date$
 *
 **/

#define INCL_DOS
#define INCL_WINSWITCHLIST
#define INCL_DOSERRORS
#define INCL_REXXSAA
#define INCL_RXFUNC
#include <os2.h>
#include <rexxsaa.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "..\engine\globals.h"
#include "..\engine\nice.h"
#include "..\engine\dosqss.h"


#define NICE_RXMODULE		"RXNICE"
#define IBUF_LEN            4096
#define MAX_RXVAR           256
#define MAX_ITOA            33
#define RC_OK               "0"
#define MEMPOOL             262144 // for switch list and process list

#define INVALID_ROUTINE     40
#define VALID_ROUTINE       0

#define BUILDRXSTRING(t, s) { \
  strcpy((t)->strptr,(s));\
  (t)->strlength = strlen((s)); \
}

typedef struct RxStemData
{
    SHVBLOCK shvb;                     /* Request block for RxVar    */
    CHAR ibuf[IBUF_LEN];               /* Input buffer               */
    CHAR varname[MAX_RXVAR];           /* Buffer for the variable    */
                                       /* name                       */
    CHAR stemname[MAX_RXVAR];          /* Buffer for the variable    */
                                       /* name                       */
    ULONG stemlen;                     /* Length of stem.            */
    ULONG vlen;                        /* Length of variable value   */
    ULONG j;                           /* Temp counter               */
    ULONG tlong;                       /* Temp counter               */
    ULONG count;                       /* Number of elements         */
                                       /* processed                  */
} RXSTEMDATA;

static PSZ NiceFuncTable[] =
{
    "RxNiceDropFuncs",
    "RxNiceStatus",
    "RxNiceSetPriority",
    "RxNicePS",
    "RxNiceMyPID",
    "RxNiceIOCtl"
};

CHAR * aPriorityClass[ 5 ] =
{
    "",
    "IDLE",
    "REG",
    "TC",
    "FGS"
};


/*
 *  RxNiceLoadFuncs()
 *
 *  returns: rc = 0
 *
 **/

ULONG _System
    RxNiceLoadFuncs( CHAR * Name,
                     ULONG argc,
                     RXSTRING argv[],
                     CHAR * queuename,
                     PRXSTRING retstr )
{
    int     entries;
    int     i;

    retstr->strlength = 0;
    entries = sizeof( NiceFuncTable ) / sizeof( PSZ );

    for( i = 0; i < entries; i++ )
        RexxRegisterFunctionDll( NiceFuncTable[ i ], NICE_RXMODULE, NiceFuncTable[ i ] );

    return VALID_ROUTINE;
};


/*
 *  RxNiceDropFuncs()
 *
 *  returns: rc = 0
 *
 **/

ULONG _System
    RxNiceDropFuncs( CHAR * Name,
                     ULONG argc,
                     RXSTRING argv[],
                     CHAR * queuename,
                     PRXSTRING retstr )
{
    int     entries;
    int     i;

    retstr->strlength = 0;
    entries = sizeof( NiceFuncTable ) / sizeof( PSZ );

    for( i = 0; i < entries; i++ )
        RexxDeregisterFunction( NiceFuncTable[ i ] );

    return VALID_ROUTINE;
};


/*
 *  RxNiceStatus()
 *
 *  returns: rc = 0 - the engine is not running,
 *           rc > 0 - the PID under which the engine is running
 *
 **/

ULONG _System
    RxNiceStatus( CHAR * Name,
                  ULONG argc,
                  RXSTRING argv[],
                  CHAR * queuename,
                  PRXSTRING retstr )
{
    APIRET      rc;
    CHAR        buf[ MAX_ITOA ];

    if( argc != 0 )
        return INVALID_ROUTINE;

    rc = NiceStatus();
    _itoa( rc, buf, 10 );
    BUILDRXSTRING( retstr, buf );

    return 0;
};


/*
 *  RxNiceSetPriority( PID, TID, CLASS, DELTA )
 *
 *  PID   - process identifier
 *  TID   - thread identifier, for none-PM processes must be 0.
 *  CLASS - string 'I' 'R' 'F' 'TC'
 *  DELTA - integer
 *
 *  returns: rc from NiceSetPriority()
 *
 **/

ULONG _System
    RxNiceSetPriority( CHAR * Name,
                       ULONG argc,
                       RXSTRING argv[],
                       CHAR * queuename,
                       PRXSTRING retstr )
{
    APIRET      rc;
    PID         pid;
    TID         tid;
    ULONG       ulClass;
    LONG        lDelta;
    CHAR        buf[ MAX_ITOA ];

    if( argc != 4 ||
        !RXVALIDSTRING( argv[ 0 ] ) ||
        !RXVALIDSTRING( argv[ 1 ] ) ||
        !RXVALIDSTRING( argv[ 2 ] ) ||
        !RXVALIDSTRING( argv[ 3 ] ) )
        return INVALID_ROUTINE;

    pid = atoi( argv[ 0 ].strptr );
    tid = atoi( argv[ 1 ].strptr );

    if( !stricmp( argv[ 2 ].strptr, "nc" ) )
        ulClass = PRTYC_NOCHANGE;
    else if( !stricmp( argv[ 2 ].strptr, "i" ) )
        ulClass = PRTYC_IDLETIME;
    else if( !stricmp( argv[ 2 ].strptr, "r" ) )
        ulClass = PRTYC_REGULAR;
    else if( !stricmp( argv[ 2 ].strptr, "f" ) )
        ulClass = PRTYC_FOREGROUNDSERVER;
    else if( !stricmp( argv[ 2 ].strptr, "tc" ) )
        ulClass = PRTYC_TIMECRITICAL;
    else
    {
        _itoa( ERROR_INVALID_PCLASS, buf, 10 );
        BUILDRXSTRING( retstr, buf );
        return VALID_ROUTINE;
    };

    lDelta = atoi( argv[ 3 ].strptr );
    if( lDelta < -31 ||
        lDelta > 31 )
    {
        _itoa( ERROR_INVALID_PDELTA, buf, 10 );
        BUILDRXSTRING( retstr, buf );
        return VALID_ROUTINE;
    };

    rc = NiceSetPriority( pid, tid, ulClass, lDelta );

    _itoa( rc, buf, 10 );
    BUILDRXSTRING( retstr, buf );

    return VALID_ROUTINE;
};


/*
 *  RxNicePS( PID, stem )
 *
 *  PID - process identifier or PID = 0 to return all process information
 *  stem - stem to hold result
 *         if PID = 0 : PID PPID THREADS TYPE COMMAND (for every PID)
 *
 *         if PID > 0 : PID PPID THREADS TYPE COMMAND (first line only)
 *                      TID CLASS DELTA               (for every thread)
 *
 *  returns: rc = 0 : no error
 *           rc > 0 : some error
 *
 **/


ULONG _System
    RxNicePS( CHAR * Name,
              ULONG argc,
              RXSTRING argv[],
              CHAR * queuename,
              PRXSTRING retstr )
{
    APIRET          rc;
    PVOID           pvBase;
    PQPROCESS       pqProcess;
    PQTHREAD        pqThread;

    ULONG           cbItems    = 0,
                    ulBufSize  = 0;
    PSWBLOCK        pswblk     = NULL;
    PVOID           pvSwList   = NULL;
    ULONG           ulPid;

    RXSTEMDATA      ldp;
    CHAR            line[ 256 + 30 ]; // max module name + other info
    CHAR            buf[ MAX_ITOA ];

    if( argc != 2 ||
        !RXVALIDSTRING( argv[ 0 ] ) ||
        !RXVALIDSTRING( argv[ 1 ] ) )
        return INVALID_ROUTINE;

    /*
     *  prepare the stem
     *
     **/

    ldp.count = 0;
    strcpy( ldp.varname, argv[ 1 ].strptr );
    ldp.stemlen = argv[ 1 ].strlength;
    strupr( ldp.varname );

    if( ldp.varname[ ldp.stemlen - 1 ] != '.' )
        ldp.varname[ ldp.stemlen++ ] = '.';

    /*
     *  get the switch list (to know title name of VDMs)
     *
     **/

    rc = DosAllocMem( &pvBase, MEMPOOL, PAG_COMMIT | PAG_READ | PAG_WRITE );
    if( rc )
    {
        _itoa( rc, buf, 10 );
        BUILDRXSTRING( retstr, buf );
        return VALID_ROUTINE;
    };

    ulPid = atoi( argv[ 0 ].strptr );
    rc = DosQuerySysState( 0x01, 0L, ulPid, 0L, ( PCHAR ) pvBase, MEMPOOL );
    if( rc )
    {
        _itoa( rc, buf, 10 );
        BUILDRXSTRING( retstr, buf );
        return VALID_ROUTINE;
    };

    rc = DosAllocMem( &pvSwList, MEMPOOL, PAG_READ | PAG_WRITE );
    rc = DosSubSetMem( pvSwList, DOSSUB_INIT | DOSSUB_SPARSE_OBJ, MEMPOOL );

    cbItems = WinQuerySwitchList( 0, NULL, 0 );
    ulBufSize = ( cbItems * sizeof( SWENTRY ) ) + sizeof( HSWITCH );

    rc = DosSubAllocMem( pvSwList, ( PVOID ) &pswblk, ulBufSize );
    cbItems = WinQuerySwitchList( 0, pswblk, ulBufSize );

    /*
     *  get the process information
     *
     **/

    pqProcess = ( ( PQTOPLEVEL ) pvBase )->procdata;
    while( pqProcess && pqProcess->pid != 0 )
    {
        int i, j, len;
        char cModuleName[ 256 ];

        if( pqProcess->type == 0x01 )  // VDM
        {
            for( i = 0; i < cbItems; i++ )
                if( pswblk->aswentry[ i ].swctl.idProcess == pqProcess->pid )
                {
                    strcpy( cModuleName, "VDM (" );
                    strcat( cModuleName, pswblk->aswentry[ i ].swctl.szSwtitle );
                    strcat( cModuleName, ")" );
                    break;
                }
        }
        else
            rc = DosQueryModuleName( pqProcess->hndmod, sizeof( cModuleName ), cModuleName );

        sprintf( line, "%d %d %d %d %s",
                pqProcess->pid,
                pqProcess->ppid,
                pqProcess->threadcnt,
                pqProcess->type,
                cModuleName );

        len = strlen( line );
        memcpy( ldp.ibuf, line, len );
        ldp.vlen = len;

        ldp.count++;
        sprintf( ldp.varname+ldp.stemlen, "%d", ldp.count );

        if( ldp.ibuf[ ldp.vlen - 1 ] == '\n' )
            ldp.vlen--;
        ldp.shvb.shvnext = NULL;
        ldp.shvb.shvname.strptr = ldp.varname;
        ldp.shvb.shvname.strlength = strlen( ldp.varname );
        ldp.shvb.shvnamelen = ldp.shvb.shvname.strlength;
        ldp.shvb.shvvalue.strptr = ldp.ibuf;
        ldp.shvb.shvvalue.strlength = ldp.vlen;
        ldp.shvb.shvvaluelen = ldp.vlen;
        ldp.shvb.shvcode = RXSHV_SET;
        ldp.shvb.shvret = 0;
        if( RexxVariablePool( &ldp.shvb ) == RXSHV_BADN )
            return INVALID_ROUTINE;

        /*
         *  now deal with threads
         *
         **/

        pqThread = pqProcess->threads;
        for( j = 0; j < pqProcess->threadcnt; j++, pqThread++ )
            if( ulPid )
            {
                sprintf( line, "%d %s %d\n",
                        pqThread->threadid,
                        aPriorityClass[ ( pqThread->priority >> 8 ) & 0x00FF ],
                        pqThread->priority & 0x001F );

                len = strlen( line );
                memcpy( ldp.ibuf, line, len );
                ldp.vlen = len;

                ldp.count++;
                sprintf( ldp.varname+ldp.stemlen, "%d", ldp.count );

                if( ldp.ibuf[ ldp.vlen - 1 ] == '\n' )
                    ldp.vlen--;
                ldp.shvb.shvnext = NULL;
                ldp.shvb.shvname.strptr = ldp.varname;
                ldp.shvb.shvname.strlength = strlen( ldp.varname );
                ldp.shvb.shvnamelen = ldp.shvb.shvname.strlength;
                ldp.shvb.shvvalue.strptr = ldp.ibuf;
                ldp.shvb.shvvalue.strlength = ldp.vlen;
                ldp.shvb.shvvaluelen = ldp.vlen;
                ldp.shvb.shvcode = RXSHV_SET;
                ldp.shvb.shvret = 0;
                if( RexxVariablePool( &ldp.shvb ) == RXSHV_BADN )
                    return INVALID_ROUTINE;
            };

        pqProcess = ( PQPROCESS ) pqThread;
    };

    rc = DosFreeMem( pvSwList );
    rc = DosFreeMem( pvBase );

    sprintf( ldp.ibuf, "%d", ldp.count );
    ldp.varname[ ldp.stemlen ] = '0';
    ldp.varname[ ldp.stemlen+1 ] = 0;
    ldp.shvb.shvnext = NULL;
    ldp.shvb.shvname.strptr = ldp.varname;
    ldp.shvb.shvname.strlength = ldp.stemlen+1;
    ldp.shvb.shvnamelen = ldp.stemlen+1;
    ldp.shvb.shvvalue.strptr = ldp.ibuf;
    ldp.shvb.shvvalue.strlength = strlen( ldp.ibuf );
    ldp.shvb.shvvaluelen = ldp.shvb.shvvalue.strlength;
    ldp.shvb.shvcode = RXSHV_SET;
    ldp.shvb.shvret = 0;
    if( RexxVariablePool( &ldp.shvb ) == RXSHV_BADN )
        return INVALID_ROUTINE;

    BUILDRXSTRING( retstr, RC_OK );
    return VALID_ROUTINE;
};


/*
 *  RxNiceMyPID()
 *
 *  returns: rc = 0 - some error during DosGetInfoBlocks()
 *           rc > 0 - the PID of the current process
 *
 **/

ULONG _System
    RxNiceMyPID( CHAR * Name,
                 ULONG argc,
                 RXSTRING argv[],
                 CHAR * queuename,
                 PRXSTRING retstr )
{
    APIRET      rc;
    PPIB        ppib;
    PTIB        ptib;
    CHAR        buf[ MAX_ITOA ];

    if( argc != 0 )
        return INVALID_ROUTINE;

    rc = DosGetInfoBlocks( &ptib, &ppib );
    if( rc )
    {
        BUILDRXSTRING( retstr, RC_OK );
        return VALID_ROUTINE;
    };

    _itoa( ppib->pib_ulpid, buf, 10 );
    BUILDRXSTRING( retstr, buf );

    return VALID_ROUTINE;
};


/*
 *  RxNiceIOCtl( CMD, PARAM1, PARAM2 )
 *
 *  CMD    - command
 *  PARAM1 - param1
 *  PARAM2 - param2
 *
 *  returns: rc from NiceIOCtl()
 *
 **/

ULONG _System
    RxNiceIOCtl( CHAR * Name,
                 ULONG argc,
                 RXSTRING argv[],
                 CHAR * queuename,
                 PRXSTRING retstr )
{
    APIRET      rc;
    ULONG       cmd;
    ULONG		param1,
                param2;
    CHAR        buf[ MAX_ITOA ];

    if( argc != 3 ||
        !RXVALIDSTRING( argv[ 0 ] ) ||
        !RXVALIDSTRING( argv[ 1 ] ) ||
        !RXVALIDSTRING( argv[ 2 ] ) )
        return INVALID_ROUTINE;

    cmd = atoi( argv[ 0 ].strptr );
    param1 = atoi( argv[ 1 ].strptr );
    param2 = atoi( argv[ 1 ].strptr );

    rc = NiceIOCtl( cmd, param1, param2 );

    _itoa( rc, buf, 10 );
    BUILDRXSTRING( retstr, buf );

    return VALID_ROUTINE;
};


