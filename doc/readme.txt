
  NICE/2 by Sharon Dagan <idagan@il.ibm.com>


  Still under construction...

  NICE/2 is a long term effort to provide end users with a set of tools to
  better control their OS/2 systems. NICE/2 is still under development and
  will have more features with time. 'NICEPM', the NICE/2 PM control center
  will hopefully be added soon - I still have to iron out some bugs...

  Please report bugs and suggestions to idagan@il.ibm.com.
  NICE/2 Homepage is: http://www.geocities.com/Nashville/6525/os2.html

      Important: I'm listening... if you have a suggestion that could make
                 NICE/2 better, please share it with me. Thanks :-)


  What is it?

  Have you ever started a long XCOPY command that ate too much CPU? Have you
  ever wanted to make Netscape/2 more responsive? NICE/2 is here to rescue.
  With NICE/2 you can dynamically change priority of many processes in OS/2.
  As opposed to programs such as SPE that starts a process in a given
  priority, NICE/2 enables you to change the priority of processes and threads
  AFTER they have been started.


  Installation

  Simply copy NICE.EXE and NICED.EXE to somewhere in your PATH, and copy
  NICE.DLL, NICEDHK.DLL and NICEDMN.DLL to somewhere in your LIBPATH. A typical
  place will be your utility directory.


  How to use it?

  NICE/2 is divided into a 'client' program and a 'server' program. At any
  time, you can start the NICE/2 server (NICED.EXE) (even if the process you
  intend to alter is already started) by issuing the command:

      niced.exe -start

  (If you intend to use NICE/2 alot, place 'niced.exe -start' in your
  STARTUP.CMD file - NICE/2 engine takes only a fraction of OS/2 resources).

  After a few seconds, NICED returns. If no error has occurred, NICED will
  report nothing. If a error has occurred, NICED terminates and reports the
  error (see the error codes at the end of this document). After NICED is
  started, you can alter the priority of a given PID by using NICE/2 command
  line or by using the Context Menu of the Task List Window.


  Using the GUI

  Bring up the Task List Window (CTRL+ESC) and select a process. Bring up the
  context menu - notice that NICE/2 added a new submenu called 'Priority'.
  From this menu, select

      [+] Increase Priority
      [+] Decrease Priority

      Use these two to increase or decrease the priority delta of a process
      without changing the priority class - this will add +1 (or subtract) to
      any thread withing the process. Lets say we have the following process
      (niceps.exe output) (*):

          PID   PPID  THRDS  TYPE  COMMAND
          653     19      4     3  D:\DEMO\BLAH.EXE
          TID  CLASS  DELTA
            1   IDLE     31
            2    REG     24
            3    REG     30
            4    FGS      1

      After increasing the priority, it will look like this:

          PID   PPID  THRDS  TYPE  COMMAND
          653     19      4     3  D:\DEMO\BLAH.EXE
          TID  CLASS  DELTA
            1   IDLE     31
            2    REG     25
            3    REG     31
            4    FGS      2


      Make Idle
      Make Regualr
      Make Server

      Use these options to set the priority of all threads within a process to
      a given priority.

          Make Idle    | Low    = IDLE 0
          Make Idle    | Medium = IDLE 15
          Make Idle    | High   = IDLE 31

          Make Regular | Low    = REGULAR 0
          Make Regular | Medium = REGULAR 15
          Make Regular | High   = REGULAR 31

          Make Server  | Low    = FOREGROUND SERVER 0
          Make Server  | Medium = FOREGROUND SERVER 15
          Make Server  | High   = FOREGROUND SERVER 31

      so issuing 'Make Idle | Medium' on the above process (*) will result in:

          PID   PPID  THRDS  TYPE  COMMAND
          653     19      4     3  D:\DEMO\BLAH.EXE
          TID  CLASS  DELTA
            1   IDLE     15
            2   IDLE     15
            3   IDLE     15
            4   IDLE     15


  Using Command Line

  Use the command line to better control priorities. Lets say we want to change
  the priority of PID 71 and send it into the 'background'. From OS/2 command
  line, simply issue:

      nice.exe -p 71 -c i -d 7

  This will alter the priority of process 71 to class IDLE with DELTA of 7.
  Possible values for the CLASS switch '-c' are:

      NC = NO CHANGE priority class will not change
      I  = IDLE priority
      R  = REGULAR priority (most user processes are in this class)
      F  = FOREGROUNDSERVER priority
      TC = TIME CRITICAL priority (use with caution)

  Possible values for the DELTA switch '-d' are:

      -31 =< DELTA <= +31

      Important: To INCREASE or DECREASE the delta of a thread, use the
                 NOCHANGE (NC) priority class. For example, to lower
                 the priority delta of a process by 3, do this:

                 nice.exe -p 71 -c nc -d -3


  How to change the priority of a single thread?

  NICE/2 gives you a fine control over priorities, down to the level of
  altering the priority of a single thread within a process. When you
  issue the NICE command, an optional switch '-t' controls the TID to
  alter. If no TID is given, *ALL* the threads within the target process
  are altered. If a TID is given, NICE will change the priority of that
  thread *ONLY*.

      Important: NICE/2 can alter priorities of a single threads only if
                 they are running within a PM process. To all other processes
                 (VIO, FS and VDM), NICE/2 can only alter the priority of all
                 the threads *TOGETHER*.


  NICE/2 SDK

  NICE/2 now includes a C and REXX SDK. This SDK includes:

      NICE/2 Library, Header file and sample for C developers. The following
      APIs are included (NicePS and NiceMyPID can be easily programmed without
      NICE/2):

          * NiceStatus() - see if the NICE/2 engine is running
          * NiceSetPriority( PID, TID, CLASS, DELTA ) - set priority


      REXX DLL for NICE/2 (RXNICE.DLL) with the following functions (see the
      provided SAMPLE1.CMD and SAMPLE2.CMD for more details):

          * RxNiceLoadFuncs() - load the functions
          * RxNiceDropFuncs() - drop the functions
          * RxNiceStatus() - see if NICE/2 engine is running
          * RxNiceSetPriority( PID, TID, CLASS, DELTA ) - set priority
          * RxNicePS( PID, 'STEM' ) - reports process information
          * RxNiceMyPID() - get the current process PID


  NICE/2 utilities:

      * Utility to report process and thread information - NICEPS.EXE:

          niceps.exe [-p PID]

          When used without switches, NICEPS reports process information
          of all processes within the system. When used with the '-p' switch,
          NICEPS reports process and thread information of the given PID.
          Example of NICEPS output:

              (assuming 653 is Netscape's PID)

              niceps.exe -p 653

              PID   PPID  THRDS  TYPE  COMMAND
              653     19      4     3  D:\NETSCAPE\PROGRAM\NETSCAPE.EXE
              TID  CLASS  DELTA
                1    REG     30
                2    REG     24
                3    REG     30
                4    REG     30


      * Utility to start a process in a given priority - NICEX.EXE:

          nicex.exe -c CLASS -d DELTA COMMAND [...]

          Use this utility to start a process in a given priority. For example,
          to start a long XCOPY command in the lowest priority availabe, issue
          the following command:

          nicexec.exe -c i -d 0 xcopy f:\* g:\ /s

          This will start 'xcopy f:\* g:\ /s' in priority IDLE 0.


  Known limitations but Working As Designed:
  (don't bother me with these)

  * The priority of detached processes cannot be altered.
  * The priority of processes with PID < PID_OF_PMSHELL cannot be altered.
    (PID_OF_PMSHELL can be obtained by: 'niceps | sort | grep PMSHELL' - the
    lowset PID of the two is the one).
  * Single thread operations can be applied to PM processes only.
  * If you have selected more than one process in the Task List Window,
    the priority menu will no appear.


  Known limitations:

  * When a VDM is brought to the foreground, the priority changes back to
    the default of that VDM (usualy R0) - I will address this in a future
    release.
  * Possible minor memory leak - if you think NICE/2 leaks (swapper growing,
    system becomes slow etc) please contact me.


  NICE and NICED return codes (not a complete list):

  rc =  0   NO_ERROR                  no error
  rc = -1   ERR_USAGE                 check switches
  rc = -2   ERR_INSTANCE              another niced.exe is already running
  rc = -3   ERR_ENGINE_STARTED        NICED already running
  rc = -4   ERR_ENGINE_STOPPED        NICED not running
  rc = -5   ERR_WINSETHOOK            internal error - contact the author
  rc = -6   ERR_NOT_PM_PROCESS        the '-t' (TID) switch was specified but
                                      the PID given is not a PM process
  rc = -7   ERR_HWND_NOT_FOUND        internal error - contact the author
  rc = -8   ERR_TLW_STARTED           TLW egnine already running
  rc = -9   ERR_TLW_STOPPED           TLW engine not running
  rc = -10  ERR_WINSUBCLASSWINDOW     internal error - contact the author
  rc = -11  ERR_TLW_HWND_NOT_FOUND    internal error - contact the author

  rc = 303  ERROR_INVALID_PROCID      invalid PID was given
  rc = 304  ERROR_INVALID_PDELTA      the value of the '-d' switch is invalid
  rc = 307  ERROR_INVALID_PCLASS      the value of the '-c' switch is invalid
  rc = 309  ERROR_INVALID_THREADID    invalid TID was given


