/*
 *  Project: NICE/2
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: exec.c,v 1.1 1999/02/13 18:23:46 idagan Exp idagan $
 *  $Date: 1999/02/13 18:23:46 $
 *
 **/

#define INCL_DOS
#define INCL_DOSERRORS
#include <os2.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "..\engine\globals.h"

#define ARG_COMMAND		5


char * argVal( int argc, char ** argv, char * arg );
int    argIndex( int argc, char ** argv, char * arg );
char * nextArg( int argc, char ** argv, int index );
long message( long rc );


int main( int argc, char ** argv )
{
    APIRET      	rc;
    ULONG       	ulClass;
    LONG        	lDelta;
    CHAR *      	pszClassName;
    PPIB			ppib;
    PTIB			ptib;
    RESULTCODES     rcChildRC;
    UCHAR			pszLoadError[ CCHMAXPATH ] = { 0 };
    char			args[ 512 ];
    char  			exec[ 256 ];
    int				i;

    if( argc < 6 )
        return message( ERR_USAGE );

    if( !argIndex( argc, argv, "-c" ) ||
        !argIndex( argc, argv, "-d" ) )
        return message( ERR_USAGE );

    pszClassName = nextArg( argc, argv, argIndex( argc, argv, "-c" ) );
    if( !stricmp( pszClassName, "nc" ) )
        ulClass = PRTYC_NOCHANGE;
    else if( !stricmp( pszClassName, "i" ) )
        ulClass = PRTYC_IDLETIME;
    else if( !stricmp( pszClassName, "r" ) )
        ulClass = PRTYC_REGULAR;
    else if( !stricmp( pszClassName, "f" ) )
        ulClass = PRTYC_FOREGROUNDSERVER;
    else if( !stricmp( pszClassName, "tc" ) )
        ulClass = PRTYC_TIMECRITICAL;
    else return message( ERROR_INVALID_PCLASS );

    lDelta = atoi( argVal( argc, argv, "-d" ) );
    if( lDelta < -31 ||
        lDelta > 31 )
        return message( ERROR_INVALID_PDELTA );

	rc = DosGetInfoBlocks( &ptib, &ppib );
	if( rc )
		return message( rc );
	
    rc = DosSetPriority( PRTYS_PROCESS,
    					 ulClass,
    					 lDelta,
    					 ppib->pib_ulpid );
	if( rc )
		return message( rc );    					

	for( i = ARG_COMMAND; i < argc; i++ )
	{
    	strcat( args, argv[ i ] );
    	strcat( args, " " );
    };
    args[ strlen( args ) + 1 ] = '\0';
    args[ strlen( argv[ ARG_COMMAND ] ) ] = '\0';

	rc = DosExecPgm( pszLoadError,
				     sizeof( pszLoadError ),
				     EXEC_SYNC,
				     args,
				     NULL,
				     &rcChildRC,
				     argv[ ARG_COMMAND ] );
				
	if( rc == ERROR_FILE_NOT_FOUND );
	{
		strcpy( exec, argv[ ARG_COMMAND ] );
		strcat( exec, ".EXE" );
		
		rc = DosExecPgm( pszLoadError,
				     	 sizeof( pszLoadError ),
				     	 EXEC_SYNC,
				     	 args,
				     	 NULL,
				     	 &rcChildRC,
				     	 exec );
	};			

    return message( rc );
};


int argIndex( int argc, char ** argv, char * arg )
{
    while( argc > 1 )
        if( !strcmp( argv[ argc - 1 ], arg ) )
            return argc - 1;
        else
            argc--;

    return 0;
};


char * argVal( int argc, char ** argv, char * arg )
{
    int index;

    index = argIndex( argc, argv, arg );
    if( index == 0 )
        return NULL;

    return nextArg( argc, argv, index );
};


char * nextArg( int argc, char ** argv, int index )
{
    if( index >= argc - 1 )
        return NULL;

    return argv[ index + 1 ];
};


long message( long rc )
{
    char        msg[ 256 ];

    switch( rc )
    {
        case NO_ERROR:
            return rc;

        case ERR_USAGE:
            printf( "NICE/2 by Sharon Dagan <idagan@il.ibm.com>\n" \
                    "usage: nicex.exe -c CLASS -d DELTA COMMAND [...] \n" \
                    "where CLASS   is the priority class NC=no change I=idle R=regular\n"
                    "              F=forground TC=time critical\n" \
                    "      DELTA   is the priority delta -31 =< DELTA <= +31\n" \
                    "      COMMAND is the program to run\n" );
            return rc;

        default:
            strcpy( msg, "returned from an OS/2 API call\n" );
    };

    printf( "rc = %d %s", rc, msg );
    return rc;
};



