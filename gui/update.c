/*
 *  Project: NICE/2
 *  This module is resposible for updating the container records.
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: niced.c,v 1.1 1999/02/13 18:24:10 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:10 $
 *
 **/

#define  INCL_DOS
#define  INCL_WIN
#include <os2.h>
#include <stdlib.h>
#include <string.h>
#include "dosqss.h"
#include "task_view.h"
#include "update.h"


#define MAX_THREADS		1024			// magic numbers
#define MAX_PROCESSES	256
#define MEMPOOL         1048576


extern HPOINTER hPlusIcon;
extern HPOINTER hMinusIcon;


CHAR * pszEmptyStr = "";

CHAR * aPriorityClass[ 5 ] =
{
    "",
	"IDLE",
	"REG",
	"TC",
	"FGS"
};


HMUX	hmuxUpdate;


int   sort_by_pid( const void *, const void * );
VOID  sort_raw( PQTOPLEVEL, PQPROCESSARRAY );

VOID  build_update_lists( PQPROCESSARRAY, PQPROCESSARRAY,
	 					  PAPPRECORDARRAY,
	 					  PQPROCESSARRAY,
						  PQTHREADARRAY,
						  PQTHREADARRAY );
						
VOID  update_container( HWND,
                        PAPPRECORDARRAY,
	 					PQPROCESSARRAY,
						PQTHREADARRAY,
						PQTHREADARRAY );
						
VOID  fill_proc_rec( PAPPRECORD, PQPROCESS );
VOID  fill_thread_rec( PAPPRECORD, PQTHREAD );


VOID update_thread( PVOID cntr )
{
	APIRET			rc;
	HAB				hab;
	HMQ             hmq;
	
	PVOID			pvFlipRaw,
					pvFlopRaw;

	QPROCESSARRAY   apqFlipSorted,
					apqFlopSorted;

	APPRECORDARRAY	removeList;
	QPROCESSARRAY  	procInsertList;
	QTHREADARRAY   	threadInsertList;
	QTHREADARRAY   	updateList;

	
	hab = WinInitialize( 0 );
	hmq = WinCreateMsgQueue( hab, 0 );

	rc = DosAllocMem( &pvFlipRaw, MEMPOOL, PAG_COMMIT | PAG_READ | PAG_WRITE );
	rc = DosAllocMem( &pvFlopRaw, MEMPOOL, PAG_COMMIT | PAG_READ | PAG_WRITE );
	
	rc = DosAllocMem( ( PPVOID ) &apqFlipSorted.pData,
					  sizeof( PQPROCESS ) * MAX_PROCESSES,
					  PAG_COMMIT | PAG_READ | PAG_WRITE );
	apqFlipSorted.ulSize = 0;					

	rc = DosAllocMem( ( PPVOID ) &apqFlopSorted.pData,
					  sizeof( PQPROCESS ) * MAX_PROCESSES,
					  PAG_COMMIT | PAG_READ | PAG_WRITE );
	apqFlopSorted.ulSize = 0;
		
	rc = DosAllocMem( ( PPVOID ) &removeList.pData,
					  sizeof( PAPPRECORD ) * ( MAX_PROCESSES + MAX_THREADS ),
					  PAG_COMMIT | PAG_READ | PAG_WRITE );
	removeList.ulSize = 0;
	
	rc = DosAllocMem( ( PPVOID ) &procInsertList.pData,
					  sizeof( PQPROCESS ) * MAX_PROCESSES,
					  PAG_COMMIT | PAG_READ | PAG_WRITE );
	procInsertList.ulSize = 0;
					
	rc = DosAllocMem( ( PPVOID ) &threadInsertList.pData,
					  sizeof( PQTHREAD ) * MAX_THREADS,
					  PAG_COMMIT | PAG_READ | PAG_WRITE );
	threadInsertList.ulSize = 0;

	rc = DosAllocMem( ( PPVOID ) &updateList.pData,
					  sizeof( PQTHREAD ) * MAX_THREADS,
					  PAG_COMMIT | PAG_READ | PAG_WRITE );
	updateList.ulSize = 0;

	DosCreateMutexSem( NULL,
					   &hmuxUpdate,
					   0L,
					   FALSE );

	/*
	 *  to save time, the update is done in the flip-flop way - this saves
	 *  the cost of reallocating and commiting memory
	 *
	 **/
	
    while( TRUE )
    {
    	memset( pvFlipRaw, 0, MEMPOOL );
		rc = DosQuerySysState( 0x01, 0L, 0L, 0L, ( PCHAR ) pvFlipRaw, MEMPOOL );
		sort_raw( ( PQTOPLEVEL ) pvFlipRaw, &apqFlipSorted );

		DosRequestMutexSem( hmuxUpdate, SEM_INDEFINITE_WAIT );		
		build_update_lists( &apqFlipSorted, &apqFlopSorted,
							&removeList,
							&procInsertList,
							&threadInsertList,
							&updateList );
		
		update_container( ( HWND ) cntr,
		                  &removeList,
						  &procInsertList,
						  &threadInsertList,
						  &updateList );		
		DosReleaseMutexSem( hmuxUpdate );						
							
		DosSleep( 5 * 1000 );

    	memset( pvFlopRaw, 0, MEMPOOL );
		rc = DosQuerySysState( 0x01, 0L, 0L, 0L, ( PCHAR ) pvFlopRaw, MEMPOOL );
		sort_raw( ( PQTOPLEVEL ) pvFlopRaw, &apqFlopSorted );

		DosRequestMutexSem( hmuxUpdate, SEM_INDEFINITE_WAIT );		
		build_update_lists( &apqFlopSorted, &apqFlipSorted,
							&removeList,
							&procInsertList,
							&threadInsertList,
							&updateList );
							
		update_container( ( HWND ) cntr,
						  &removeList,
						  &procInsertList,
						  &threadInsertList,
						  &updateList );
		DosReleaseMutexSem( hmuxUpdate );
									
		DosSleep( 5 * 1000 );
    };
};


/*
 *  This function is used to build the delta between two invocations of
 *  DosQuerySysState. It will output 4 lists:
 *  removeList: will contain the container records to be removed
 *  procInsertList: will contain the new PQPROCESS records
 *  procThreadList: will contain the new PQTHREAD records - only for existing
 *                  processes
 *  updateList: will contain PQTHREAD records that have changed (priority change)
 *
 *  This codes exmines the old and new lists record by record (these are PQPROCESS
 *  records).
 *
 **/

VOID build_update_lists( PQPROCESSARRAY pNew, PQPROCESSARRAY pOld,
						 PAPPRECORDARRAY removeList,
						 PQPROCESSARRAY procInsertList,
						 PQTHREADARRAY threadInsertList,
						 PQTHREADARRAY updateList )
{
	ULONG	i, j;

	i = 0, j = 0;
	removeList->ulSize = 0;
	procInsertList->ulSize = 0;
	threadInsertList->ulSize = 0;
	updateList->ulSize = 0;
	
	while( i < pOld->ulSize &&
	       j < pNew->ulSize )
	{
		LONG lProcCase;
		
		lProcCase = pNew->pData[ j ]->pid - pOld->pData[ i ]->pid;
		if( lProcCase == 0 )
		{
			/*
			 *  the pid's are the same, lets check the threads
			 *
			 **/
		
			PQTHREAD	pqOldThread,
			            pqNewThread;
			ULONG 		x, y;
			
			/*
			 *  Update the new list with the records pointers
			 *
			 **/

			pNew->pData[ j ]->_reserved2_ = pOld->pData[ i ]->_reserved2_;
			( ( PAPPRECORD ) pNew->pData[ j ]->_reserved2_ )->pqProcess = pNew->pData[ j ];
			
			/*
			 *  check threads
			 *
			 **/
			
			x = 0, y = 0;
			pqOldThread = pOld->pData[ i ]->threads;
			pqNewThread = pNew->pData[ j ]->threads;
			while( x < pOld->pData[ i ]->threadcnt &&
			       y < pNew->pData[ j ]->threadcnt )
			{
				LONG lThreadCase;
				
				lThreadCase = pqNewThread->threadid - pqOldThread->threadid;
			    if( lThreadCase == 0 )
			    {
			    	/*
			    	 *  copy the pointers to the container records to the new
			    	 *  list
			    	 *
			    	 **/
			
			    	pqNewThread->rectype = pqOldThread->rectype;
			    	pqNewThread->sleepid = pqOldThread->sleepid;

					/*
					 *  see if the priority has changed
					 *
					 **/

			    	if( pqOldThread->priority != pqNewThread->priority )
			    		updateList->pData[ updateList->ulSize++ ] = pqNewThread;
			    		
			    	pqOldThread++;
			    	x++;
			    	pqNewThread++;
			    	y++;
				}
				else if( lThreadCase > 0 )
				{
					while( x < pOld->pData[ i ]->threadcnt &&
						   pqOldThread->threadid != pqNewThread->threadid )
					{
						removeList->pData[ removeList->ulSize++ ] = ( PAPPRECORD ) pqOldThread->sleepid;
						pqOldThread++;
						x++;
					};
					
					if( x == pOld->pData[ i ]->threadcnt )
					{
						for( ; x < pNew->pData[ j ]->threadcnt; pqNewThread++, x++ )
						{
							/*
							 *  save a pointer to the parent container record
							 *
							 **/
						
							pqNewThread->rectype = ( ULONG ) pNew->pData[ j ];
							threadInsertList->pData[ threadInsertList->ulSize++ ] = pqNewThread;
						};
							
						break;
					};
				}
				else if( lThreadCase < 0 )
				{
					pqNewThread->rectype = ( ULONG ) pNew->pData[ j ];
					threadInsertList->pData[ threadInsertList->ulSize++ ] = pqNewThread;
					pqNewThread++;
					y++;
				};
			};       	
			
			if( x == pOld->pData[ i ]->threadcnt &&
	    		y <  pNew->pData[ j ]->threadcnt )
			{
				
				for( ; y < pNew->pData[ j ]->threadcnt; y++, pqNewThread++ )
				{
				    pqNewThread->rectype = ( ULONG ) pNew->pData[ j ];
					threadInsertList->pData[ threadInsertList->ulSize++ ] = pqNewThread;
				};
			}
			else if( y == pNew->pData[ j ]->threadcnt &&
			         x <  pOld->pData[ i ]->threadcnt )	
			{
				for( ; x < pOld->pData[ i ]->threadcnt; x++, pqOldThread++ )
					removeList->pData[ removeList->ulSize++ ] = ( PAPPRECORD ) pqOldThread->sleepid;
			};		
						
			i++;
			j++;
		}
	    else if( lProcCase > 0 )
	    {
	    	/*
	    	 *  removing records
	    	 *
	    	 **/
		
			while( i < pOld->ulSize &&
				   pOld->pData[ i ]->pid != pNew->pData[ j ]->pid )
			{
				PQTHREAD pqThread;
				ULONG	 z;
				
				removeList->pData[ removeList->ulSize++ ] = ( PAPPRECORD ) pOld->pData[ i ]->_reserved2_;
				pqThread = pOld->pData[ i ]->threads;
				for( z = 0; z < pOld->pData[ i ]->threadcnt; z++, pqThread++ )
					removeList->pData[ removeList->ulSize++ ] = ( PAPPRECORD ) pqThread->sleepid;					
				
				i++;
		    };
		
		    if( i == pOld->ulSize )
		    {
		    	/*
		    	 *  insert the rest of the records
		    	 *
		    	 **/
		
		    	for( ; j < pNew->ulSize; j++ )
		    		procInsertList->pData[ procInsertList->ulSize++ ] = pNew->pData[ j ];
		    	
		    	break;		
		    };
		}
		else if( lProcCase < 0 )
		{
			/*
			 *  for times when the system pid has zeroed again.
			 *  this code never has been tested.
			 *
			 **/

			procInsertList->pData[ procInsertList->ulSize++ ] = pNew->pData[ j ];
			j++;
		};
	};
	
	if( i == pOld->ulSize &&
	    j < pNew->ulSize )
	{
		for( ; j < pNew->ulSize; j++ )
			procInsertList->pData[ procInsertList->ulSize++ ] = pNew->pData[ j ];
	}
	else if( j == pNew->ulSize &&
			 i < pOld->ulSize )	
	{
		for( ; i < pOld->ulSize; i++ )
		{
			PQTHREAD pqThread;
			ULONG	 z;

			removeList->pData[ removeList->ulSize++ ] = ( PAPPRECORD ) pOld->pData[ i ]->_reserved2_;
			
			pqThread = pOld->pData[ i ]->threads;
			for( z = 0; z < pOld->pData[ i ]->threadcnt; z++, pqThread++ )
				removeList->pData[ removeList->ulSize++ ] = ( PAPPRECORD ) pqThread->sleepid;					
		};
	};
};


VOID  update_container( HWND cntr,
                        PAPPRECORDARRAY removeList,
	 					PQPROCESSARRAY procInsertList,
						PQTHREADARRAY threadInsertList,
						PQTHREADARRAY updateList )
{
	PAPPRECORD			pmrcFirst,
	                	pmrcCur;
	RECORDINSERT	 	recsIn;
	APPRECORDARRAY		refreshList;
	static PAPPRECORD   aarData[ MAX_PROCESSES + MAX_THREADS ];
	static char 		buf[ 256 ];
	ULONG				i, j;
	
	refreshList.pData = aarData;
	refreshList.ulSize = 0;
			
	if( removeList->ulSize > 0 )
		WinSendMsg( cntr,
					CM_REMOVERECORD,
					MPFROMLONG( removeList->pData ),
					MPFROM2SHORT( removeList->ulSize, CMA_FREE | CMA_INVALIDATE ) );
					
	if( updateList->ulSize > 0 )
		for( i = 0; i < updateList->ulSize; i++ )
		{
			refreshList.pData[ refreshList.ulSize++ ] = ( PAPPRECORD ) updateList->pData[ i ]->sleepid;
		
			( ( PAPPRECORD ) updateList->pData[ i ]->sleepid )->pszClass =
				aPriorityClass[ ( updateList->pData[ i ]->priority >> 8 ) & 0x00FF ];
			
			( ( PAPPRECORD ) updateList->pData[ i ]->sleepid )->pszDelta =
				( ( PAPPRECORD ) updateList->pData[ i ]->sleepid )->szDelta;
			_itoa( updateList->pData[ i ]->priority & 0x001F, buf, 10 );
			strncpy( ( PSZ ) ( ( PAPPRECORD ) updateList->pData[ i ]->sleepid )->szDelta, buf, 3 );
		};
		
	if( procInsertList->ulSize > 0 )
	{
		ULONG ulProcsAndThreads = procInsertList->ulSize;
		
		for( i = 0; i < procInsertList->ulSize; i++ )
	    	ulProcsAndThreads += procInsertList->pData[ i ]->threadcnt;
	    	
		pmrcFirst = ( PAPPRECORD )
    		WinSendMsg( cntr,
            	        CM_ALLOCRECORD,
                	    MPFROMLONG( sizeof( APPRECORD ) - sizeof( MINIRECORDCORE ) ),
                    	MPFROMLONG( ulProcsAndThreads ) );
                    	
        pmrcCur = pmrcFirst;            	
		for( i = 0; i < procInsertList->ulSize; i++ )
		{
			PQTHREAD pqThread;
		
			refreshList.pData[ refreshList.ulSize++ ] = ( PAPPRECORD ) pmrcCur;
			fill_proc_rec( pmrcCur, procInsertList->pData[ i ] );
			pmrcCur = ( PAPPRECORD ) pmrcCur->core.preccNextRecord;
			
			pqThread = procInsertList->pData[ i ]->threads;
			for( j = 0; j < procInsertList->pData[ i ]->threadcnt; j++, pqThread++ )
			{
				refreshList.pData[ refreshList.ulSize++ ] = pmrcCur;
				fill_thread_rec( pmrcCur, pqThread );
				
				/*
				 *  filter the thread according to the father state
				 *
				 **/
				
				if( !( ( ( PAPPRECORD ) procInsertList->pData[ i ]->_reserved2_ )->core.flRecordAttr & CRA_COLLAPSED ) )
					pmrcCur->core.flRecordAttr = pmrcCur->core.flRecordAttr | CRA_FILTERED;
					
				pmrcCur = ( PAPPRECORD ) pmrcCur->core.preccNextRecord;
			};
		};
			               	
		recsIn.cb = sizeof( RECORDINSERT );
		recsIn.pRecordOrder = ( PRECORDCORE ) CMA_END;
    	recsIn.pRecordParent = ( PRECORDCORE ) NULL;		
	    recsIn.zOrder = ( USHORT ) CMA_TOP;
	    recsIn.fInvalidateRecord = FALSE;
	    recsIn.cRecordsInsert = ulProcsAndThreads;
	
        WinSendMsg( cntr,
        			CM_INSERTRECORD,
        			( PMINIRECORDCORE ) pmrcFirst,
        			&recsIn );
	};
	
	if( threadInsertList->ulSize > 0 )
	{
		pmrcFirst = ( PAPPRECORD )
    		WinSendMsg( cntr,
            	        CM_ALLOCRECORD,
                	    MPFROMLONG( sizeof( APPRECORD ) - sizeof( MINIRECORDCORE ) ),
                    	MPFROMLONG( threadInsertList->ulSize ) );

		recsIn.cb = sizeof( RECORDINSERT );
		recsIn.pRecordParent = ( PRECORDCORE ) NULL;		
	    recsIn.zOrder = ( USHORT ) CMA_TOP;
	    recsIn.fInvalidateRecord = FALSE;
	    recsIn.cRecordsInsert = 1;
                    	
		for( i = 0, pmrcCur = pmrcFirst; i < threadInsertList->ulSize; i++, pmrcCur = ( PAPPRECORD ) pmrcCur->core.preccNextRecord )
		{
			refreshList.pData[ refreshList.ulSize++ ] = pmrcCur;
			fill_thread_rec( pmrcCur, threadInsertList->pData[ i ] );
			
			recsIn.pRecordOrder = ( PRECORDCORE ) ( ( PQPROCESS ) threadInsertList->pData[ i ]->rectype )->_reserved2_;               	
			
	        /*
			 *  filter the thread according to the father state
			 *
			 **/
				
			if( ( ( PAPPRECORD ) ( ( PQPROCESS ) threadInsertList->pData[ i ]->rectype )->_reserved2_ )->core.flRecordAttr & CRA_COLLAPSED )
				pmrcCur->core.flRecordAttr = pmrcCur->core.flRecordAttr | CRA_FILTERED;

        	WinSendMsg( cntr,
        				CM_INSERTRECORD,
        				( PMINIRECORDCORE ) pmrcCur,
        				&recsIn );
        };
	};	
				
	if( refreshList.ulSize > 0 )				
		WinSendMsg( cntr,
					CM_INVALIDATERECORD,
					MPFROMLONG( refreshList.pData ),
					MPFROM2SHORT( refreshList.ulSize, CMA_TEXTCHANGED | CMA_REPOSITION ) );
};


int _Optlink sort_by_pid( const void * left, const void * right )
{
	return ( *( ( PQPROCESS * ) left ) )->pid - ( *( ( PQPROCESS * ) right ) )->pid;
};


VOID sort_raw( PQTOPLEVEL pqTopLevel, PQPROCESSARRAY apqList )
{
	PQPROCESS pqProcess;
	PQTHREAD  pqThread;
	ULONG	  i;
	
	/*
	 *  count the processes and threads and insert them to the array
	 *
	 **/
	
	apqList->ulSize = 0;
	
	pqProcess = pqTopLevel->procdata;	
	while( pqProcess && pqProcess->pid != 0 )
	{
		apqList->pData[ apqList->ulSize++ ] = pqProcess;
		
		pqThread = pqProcess->threads;
		for( i = 0; i < pqProcess->threadcnt; i++, pqThread++ );
		pqProcess = ( PQPROCESS ) pqThread;
	};

    /*
     *  Sort the array by PID
     *  	
     **/

	qsort( apqList->pData, apqList->ulSize, sizeof( PQPROCESS ), sort_by_pid ); 			
};


VOID fill_proc_rec( PAPPRECORD parAppRec, PQPROCESS pqProcess )
{
	static char buf[ MAXCOMMANDLEN ];

	pqProcess->_reserved2_ = ( ULONG ) parAppRec;
	parAppRec->pqProcess = pqProcess;
	parAppRec->core.cb = sizeof( APPRECORD );
	
	/*
	 *  bitmap
	 *
	 **/
	
	parAppRec->core.hptrIcon = hPlusIcon;
			
	/*
	 *  command name
	 *
	 **/
			
	parAppRec->pszCommand = parAppRec->szCommand;
	DosQueryModuleName( pqProcess->hndmod, MAXCOMMANDLEN, parAppRec->szCommand );
			
	/*	
	 *  pid ppid
	 *
	 **/
			
	parAppRec->pszPid = parAppRec->szPid;
	_itoa( pqProcess->pid, buf, 10 );
	strncpy( parAppRec->pszPid, buf, sizeof( parAppRec->szPid ) );

    parAppRec->pszPpid = parAppRec->szPpid;
	_itoa( pqProcess->ppid, buf, 10 );
	strncpy( parAppRec->pszPpid, buf, sizeof( parAppRec->szPpid ) );
			
	parAppRec->core.pszIcon = pszEmptyStr;   			// tid
	parAppRec->pszClass = pszEmptyStr;       			// class
};


VOID fill_thread_rec( PAPPRECORD parAppRec, PQTHREAD pqThread )
{
	static char buf[ MAXCOMMANDLEN ];

	pqThread->sleepid = ( ULONG ) parAppRec;
	parAppRec->core.cb = sizeof( APPRECORD );
	parAppRec->pqProcess = NULL;
	
	parAppRec->core.hptrIcon = NULLHANDLE;				// bitmap
	
	parAppRec->pszCommand = parAppRec->szCommand;       // command
	strcpy( parAppRec->szCommand, "    Thread " );
	_itoa( pqThread->threadid, buf, 10 );
	strcat( parAppRec->szCommand, buf );
	
	parAppRec->pszPid = pszEmptyStr;   					// pid
	parAppRec->pszPpid = pszEmptyStr;  					// ppid
			
	/*
	 *  Class
	 *
	 **/
				
	parAppRec->pszClass = aPriorityClass[ ( pqThread->priority >> 8 ) & 0x00FF ];
			
	/*
	 *  Delta
	 *
	 **/
				
	parAppRec->pszDelta = parAppRec->szDelta;
	_itoa( pqThread->priority & 0x001F, buf, 10 );
	strncpy( parAppRec->pszDelta, buf, sizeof( parAppRec->szDelta ) );
};
			
			
			
			
			
			
			


