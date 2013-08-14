/*rexx*/

rc = RxFuncAdd( 'RxNicePS', 'RXNICE', 'RxNicePS' )

rc = RxNicePS( 0, 'plist.' )

say '    PID   PPID  THRDS  TYPE  COMMAND'
do i = 1 to plist.0
    parse var plist.i pid ppid threads type module
    say '    ' left( pid, 6 ) left( ppid, 6 ) left( threads, 4 )  left( type, 4 )  module
end

exit 0
