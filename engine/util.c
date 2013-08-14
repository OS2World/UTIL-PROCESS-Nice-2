/*
 *  Project:
 *  Description:
 *
 *  By Sharon Dagan, idagan@il.ibm.com
 *
 *  $Id: util.c,v 1.1 1999/02/13 18:24:10 idagan Exp idagan $
 *  $Date: 1999/02/13 18:24:10 $
 *
 **/

#define INCL_DOS
#define INCL_WIN
#include <os2.h>
#include "util.h"
#include "dosqss.h"
#include "globals.h"


#define MEMPOOL			32768   // for switch list
#define MEMPOOL2	    262144  // for DosQuerySysState		


/*
 *  APIRET swlPidToHwnd( PID pid, HWND * pHwnd )
 *
 *  Searches the Switch List for a given PID and returns its HWND.
 *
 *  Parameters: pid (input)
 *              pHwnd (output) the HWND of the PID or 0 if the PID was not found.
 *
 *  Returns:    standard RCs.
 *
 **/

APIRET swlPidToHwnd( PID pid, HWND * pHwnd )
{
    APIRET		rc;
    ULONG       cbItems    = 0;
    ULONG       ulBufSize  = 0;
    PSWBLOCK    pswblk     = NULL;
    PVOID       pvSwList   = NULL;
    LONG		i;

    *pHwnd = 0;

    rc = DosAllocMem( &pvSwList, MEMPOOL, PAG_READ | PAG_WRITE );
    if( rc )
    	return rc;

    rc = DosSubSetMem( pvSwList, DOSSUB_INIT | DOSSUB_SPARSE_OBJ, MEMPOOL );
    if( rc )
    	return rc;

    cbItems = WinQuerySwitchList( 0, NULL, 0 );
    ulBufSize = ( cbItems * sizeof( SWENTRY ) ) + sizeof( HSWITCH );

    rc = DosSubAllocMem( pvSwList, ( PVOID ) &pswblk, ulBufSize );
    cbItems = WinQuerySwitchList( 0, pswblk, ulBufSize );

	for( i = 0; i < cbItems; i++ )
		if( pswblk->aswentry[ i ].swctl.idProcess == pid )
		{
			*pHwnd = pswblk->aswentry[ i ].swctl.hwnd;
			break;
		};
		
	rc = DosFreeMem( pvSwList );
	
	return rc;
};


/*
 *  APIRET swlNameToPid( CHAR * name, PID * pPid )
 *
 *  Searches the Switch List for a given NAME and returns its PID.
 *
 *  Parameters: name (input)
 *              pPid (output) the PID or 0 if the name was not found.
 *
 *  Returns:    standard RCs.
 *
 **/

APIRET swlNameToPid( PSZ name, PID * pPid )
{
    APIRET		rc;
    ULONG       cbItems    = 0;
    ULONG       ulBufSize  = 0;
    PSWBLOCK    pswblk     = NULL;
    PVOID       pvSwList   = NULL;
    LONG		i;

    *pPid = 0;

    rc = DosAllocMem( &pvSwList, MEMPOOL, PAG_READ | PAG_WRITE );
    if( rc )
    	return rc;

    rc = DosSubSetMem( pvSwList, DOSSUB_INIT | DOSSUB_SPARSE_OBJ, MEMPOOL );
    if( rc )
    	return rc;

    cbItems = WinQuerySwitchList( 0, NULL, 0 );
    ulBufSize = ( cbItems * sizeof( SWENTRY ) ) + sizeof( HSWITCH );

    rc = DosSubAllocMem( pvSwList, ( PVOID ) &pswblk, ulBufSize );
    cbItems = WinQuerySwitchList( 0, pswblk, ulBufSize );

	for( i = 0; i < cbItems; i++ )
		if( !my_strcmp( pswblk->aswentry[ i ].swctl.szSwtitle, name ) )
		{
			*pPid = pswblk->aswentry[ i ].swctl.idProcess;
			break;
		};
		
	rc = DosFreeMem( pvSwList );
	
	return rc;
};


/*
 *  APIRET qssPmShellPid( PID pidPM, PID * pPid )
 *
 *  returns the PID of the PM Shell (Workplace Shell).
 *
 *  Parameters: pidPM (input) the PID of PM
 *              pPid (output) the PID of the PM Shell or 0 if not found.
 *
 *  Returns:    standard RCs.
 *
 **/

APIRET qssPmShellPid( PID pidPM, PID *pPid )
{
	APIRET		rc;
	PVOID		pvBase;
	PQPROCESS	pqProcess;
	PQTHREAD    pqThread;

	*pPid = 0;
	
	rc = DosAllocMem( &pvBase, MEMPOOL, PAG_COMMIT | PAG_READ | PAG_WRITE );
	if( rc )
		return rc;
	
	rc = DosQuerySysState( 0x01, 0L, 0L, 0L, ( PCHAR ) pvBase, MEMPOOL2 );
	if( rc )
		return rc;

	pqProcess = ( ( PQTOPLEVEL ) pvBase )->procdata;	
    while( pqProcess && pqProcess->pid != 0 )
    {
	   	INT 	i;
	   	CHAR    pszModuleName[ 256 ];
	   	PSZ		pszName;

		if( pqProcess->type == 0x03 )  // pm process
			if( pqProcess->ppid == pidPM )  // father is PM
			{
				rc = DosQueryModuleName( pqProcess->hndmod, sizeof( pszModuleName ), pszModuleName );
				if( pszModuleName )
				{
					pszName = my_strrchr( pszModuleName, '\\' );
					if( pszName )
						if( !my_strcmp( ++pszName, "PMSHELL.EXE" ) )
						{
							*pPid = pqProcess->pid;
							break;
						};
				};
			};
			
		pqThread = pqProcess->threads;
		for( i = 0; i < pqProcess->threadcnt; i++, pqThread++ );
		pqProcess = ( PQPROCESS ) pqThread;
	};			
	
	DosFreeMem( pvBase );
					
	return NO_ERROR;
};


/*
 *  all kind of standard CRT stuff
 *
 **/

static void hexn (char *dst, ULONG x, int digits)
{
  int i;

  for (i = digits - 1; i >= 0; --i)
    {
      dst[i] = "0123456789abcdef"[x & 0x0f];
      x >>= 4;
    }
}


/* Convert the unsigned number X to a decimal string at DST.  Return the
   number of characters stored to DST. */

static int udecn (char *dst, unsigned x)
{
  int i, j;
  char digits[12];

  i = 0;
  do
    {
      digits[i++] = (char)(x % 10 + '0');
      x /= 10;
    } while (x != 0);
  for (j = 1; j <= i; ++j)
    *dst++ = digits[i-j];
  return i;
}


/* Convert the signed number X to a decimal string at DST.  Return the
   number of characters stored to DST. */

static int decn (char *dst, int x)
{
  if (x >= 0)
    return udecn (dst, (unsigned)x);
  else
    {
      *dst = '-';
      return udecn (dst+1, (unsigned)(-x)) + 1;
    }
}


LONG my_vsprintf( CHAR * dst, const CHAR * fmt, PVOID args[] )
{
  char *		d;
  int		 	prec, i;
  unsigned 		u;
  const char 	*s;

  d = dst;
  while (*fmt != 0)
    if (*fmt != '%')
      *d++ = *fmt++;
    else if (fmt[1] == '%')
      *d++ = '%', fmt += 2;
    else
      {
        ++fmt; prec = -1;
        if (*fmt == '.')
          {
            ++fmt; prec = 0;
            while (*fmt >= '0' && *fmt <= '9')
              prec = prec * 10 + (*fmt++ - '0');
          }
        switch (*fmt)
          {
          case 's':
            s = va_arg( args, CHAR * );
            if (prec == -1) prec = 1 << 30;
            while (*s != 0 && prec > 0)
              *d++ = *s++, --prec;
            break;
          case 'd':
            i = va_arg( args, INT );
            d += decn (d, i);
            break;
          case 'u':
            u = va_arg( args, ULONG );
            d += udecn (d, u);
            break;
          case 'x':
            u = va_arg( args, ULONG );
            if (prec == -1) prec = 8;
            hexn (d, u, prec);
            d += prec;
            break;
          }
        ++fmt;
      }
  *d = 0;
  return d - dst;
}


LONG my_strlen( CHAR * str )
{
	LONG		len = 0;
	
	while( *str )
	{	
		str++;
		len++;
	};
		
	return len;
};


LONG my_strcmp( CHAR * left, CHAR * right )
{
	while( *left && *right )
		if( *left == *right )
		{
			left++;
			right++;
		}
		else
			break;

	return ( LONG ) *left - *right;
};			


CHAR * my_strchr( CHAR * str, CHAR c )
{
	while( *str )
		if( *str == c )
			return str;
		else
			str++;
			
	return NULL;
};


CHAR * my_strrchr( CHAR * str, CHAR c )
{
	LONG	i;
	
	for( i = my_strlen( str ); i > 0; i-- )
		if( str[ i - 1 ] == c )
			return ( str + i - 1 );
			
	return NULL;		
};



