/*rexx*/

rc = RxFuncAdd( 'RxNiceIOCtl', 'RXNICE', 'RxNiceIOCtl' )


NICE_IOCTL_PASSIVEMODE = x2d( '0000FF03' )
NICE_IOCTL_ACTIVEMODE  = x2d( '0000FF04' )


rc = RxNiceIOCtl( NICE_IOCTL_ACTIVEMODE, 0, 0 )
say rc

exit 0
