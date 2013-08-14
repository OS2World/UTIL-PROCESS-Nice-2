
#define INCL_DOS
#include <os2.h>
#include <stdio.h>
#include <stdlib.h>
#include "nice.h"


CHAR * aPriorityClass[ 5 ] =
{
    "",
    "IDLE",
    "REG",
    "TC",
    "FGS"
};


int error( APIRET );


int main()
{
	APIRET		rc;
	PPIB		ppib;
	PTIB		ptib;
	
	rc = NiceStatus();
	if( !rc )
	{
		printf( "NICE/2 engine is not running.\n" \
		        "Please start the engine before running this example ('niced.exe -start').\n" );
		exit( -3 );
	};
	
	printf( "NICE/2 engine is running under PID = %d\n", rc );
	
	rc = DosGetInfoBlocks( &ptib, &ppib );
	if( rc )
		return error( rc );
		
	printf( "My PID is %d and my Parent PID is %d\n",
	         ppib->pib_ulpid, ppib->pib_ulppid );

	rc = NiceSetPriority( ppib->pib_ulppid, 0, PRTYC_IDLETIME, 7 );
	if( rc )
		return error( rc );
		
	printf( "Altered my Parent priority to IDLE 7\n" \
	        "run 'niceps -p %d' and see...\n",
	        ppib->pib_ulppid );

    return 0;
};


int error( APIRET rc )
{
	printf( "rc = %d from an OS/2 API call\n", rc );
	return rc;
};
