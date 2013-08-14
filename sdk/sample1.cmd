/*rexx*/

/*
 *  Load the NICE/2 functions
 *
 **/

rc = RxFuncAdd( 'RxNiceLoadFuncs', 'RXNICE', 'RxNiceLoadFuncs' )
rc = RxNiceLoadFuncs()

/*
 *  see if the engine is running
 *
 **/

rc = RxNiceStatus()
if rc == 0 then do
    say 'NICE/2 engine not running, starting the engine...'
    'niced -start'
    if rc <> 0 then exit -1
end
else say 'NICE/2 engine running under PID = ' || rc

my_pid = RxNiceMyPID()
if my_pid > 0 then say 'My PID = ' || my_pid
else do
    say 'Could not get my PID'
    exit -1
end

/*
 *  get my priority
 *
 **/

rc = RxNicePS( my_pid, 'plist.' )
if rc == 0 then do
    parse var plist.2 tid class delta
    say 'My priority is ' || class || ' ' || delta
end
else do
    say 'RxNicePS() failed. OS/2 API rc = ' || rc
    exit -1
end

/*
 *  making myself IDLE 7
 *  Note: TID > 0 only valid for PM processes
 *
 **/

rc = RxNiceSetPriority( my_pid, 0, 'I', 7 )
if rc <> 0 then do
    say 'RxNiceSetPriority() failed with rc = ' || rc
    exit -1
end

/*
 *  get my priority after the change
 *
 **/

rc = RxNicePS( my_pid, 'plist.' )
if rc == 0 then do
    parse var plist.2 tid class delta
    say 'My priority after the change is ' || class || ' ' || delta
end
else do
    say 'RxNicePS() failed. OS/2 API rc = ' || rc
    exit -1
end
/*
 *  drop the functions
 *
 **/

rc = RxNiceDropFuncs()
exit 0


