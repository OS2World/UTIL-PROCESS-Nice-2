#line 14 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\os2.h"
#pragma info( none )

      #pragma info( none )

#pragma info( restore )
#line 20 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\os2def.h"
#pragma info( none )

   #pragma info( none )

#pragma info( restore )
#line 69
typedef unsigned long  APIRET;
typedef unsigned short APIRET16;
typedef unsigned long  APIRET32;
#line 89
typedef unsigned short   SHANDLE;
typedef unsigned long    LHANDLE;
#line 105
typedef unsigned char  UCHAR;    
typedef unsigned short USHORT;   
typedef unsigned long  ULONG;    
#line 110
   typedef unsigned int UINT;    
#line 113
typedef UCHAR     * _Seg16 PUCHAR16;
typedef char      * _Seg16 PCHAR16;

typedef char BYTE;      

typedef char *PSZ;
typedef char *NPSZ;

typedef char *PCH;
typedef char *NPCH;
typedef const char *PCSZ;

typedef int ( _System _PFN)  ();
typedef _PFN    *PFN;
typedef int ( _System _NPFN)  ();
typedef _NPFN   *NPFN;
#line 131
typedef BYTE *PBYTE;
typedef BYTE *NPBYTE;

typedef char *PCHAR;
typedef short *PSHORT;
typedef long *PLONG;
#line 139
   typedef int *PINT;
#line 142
typedef UCHAR *PUCHAR;
typedef USHORT *PUSHORT;
typedef ULONG *PULONG;
#line 147
   typedef UINT *PUINT;
#line 150
typedef void   *PVOID;
typedef PVOID  *PPVOID;
typedef void   * _Seg16  PVOID16;

typedef unsigned long BOOL;      
typedef BOOL *PBOOL;

typedef unsigned short  BOOL16;
typedef BOOL16     * _Seg16 PBOOL16;
#line 167
typedef struct _QWORD           
{
   ULONG   ulLo;
   ULONG   ulHi;
} QWORD;
typedef QWORD *PQWORD;
#line 176
   typedef unsigned short SEL;      
   typedef SEL *PSEL;
#line 216
typedef ULONG ERRORID;   
typedef ERRORID *PERRORID;
#line 246
typedef LHANDLE HMODULE;         
typedef LHANDLE PID;             
typedef LHANDLE TID;             
#line 251
   typedef USHORT  SGID;         
#line 254
typedef HMODULE *PHMODULE;
typedef PID *PPID;
typedef TID *PTID;
#line 263
       typedef void *HSEM;       
       typedef HSEM *PHSEM;
#line 270
typedef LHANDLE   HAB;          
typedef HAB *PHAB;
#line 275
typedef LHANDLE   HPS;          
typedef HPS *PHPS;

typedef LHANDLE   HDC;          
typedef HDC *PHDC;

typedef LHANDLE   HRGN;         
typedef HRGN *PHRGN;

typedef LHANDLE   HBITMAP;      
typedef HBITMAP *PHBITMAP;

typedef LHANDLE   HMF;          
typedef HMF *PHMF;

typedef LHANDLE   HPAL;         
typedef HPAL *PHPAL;

typedef long     COLOR;         
typedef COLOR *PCOLOR;

typedef struct _POINTL          
{
   long  x;
   long  y;
} POINTL;
typedef POINTL *PPOINTL;
typedef POINTL *NPPOINTL;

typedef struct _POINTS          
{
   short x;
   short y;
} POINTS;
typedef POINTS *PPOINTS;

typedef struct _RECTL           
{
   long  xLeft;
   long  yBottom;
   long  xRight;
   long  yTop;
} RECTL;
typedef RECTL *PRECTL;
typedef RECTL *NPRECTL;

typedef char STR8[8];           
typedef STR8 *PSTR8;
#line 328
typedef struct _DRIVDATA        
{
   long    cb;
   long    lVersion;
   char    szDeviceName[32];
   char    abGeneralData[1];
} DRIVDATA;
typedef DRIVDATA *PDRIVDATA;
#line 339
typedef PSZ *PDEVOPENDATA;
#line 356
   typedef struct _DEVOPENSTRUC       
   {
      PSZ        pszLogAddress;
      PSZ        pszDriverName;
      PDRIVDATA  pdriv;
      PSZ        pszDataType;
      PSZ        pszComment;
      PSZ        pszQueueProcName;
      PSZ        pszQueueProcParams;
      PSZ        pszSpoolerParams;
      PSZ        pszNetworkParams;
   } DEVOPENSTRUC;
   typedef DEVOPENSTRUC *PDEVOPENSTRUC;
#line 373
typedef struct _PRINTDEST      
{
   ULONG        cb;
   long         lType;
   PSZ          pszToken;
   long         lCount;
   PDEVOPENDATA pdopData;
   ULONG        fl;
   PSZ          pszPrinter;
} PRINTDEST;
typedef PRINTDEST *PPRINTDEST;
#line 412
typedef struct _FATTRS             
{
   USHORT  usRecordLength;
   USHORT  fsSelection;
   long    lMatch;
   char    szFacename[32];
   USHORT  idRegistry;
   USHORT  usCodePage;
   long    lMaxBaselineExt;
   long    lAveCharWidth;
   USHORT  fsType;
   USHORT  fsFontUse;
} FATTRS;
typedef FATTRS *PFATTRS;
#line 477
typedef struct _PANOSE    
{
   BYTE    bFamilyType;
   BYTE    bSerifStyle;
   BYTE    bWeight;
   BYTE    bProportion;
   BYTE    bContrast;
   BYTE    bStrokeVariation;
   BYTE    bArmStyle;
   BYTE    bLetterform;
   BYTE    bMidline;
   BYTE    bXHeight;
   BYTE    fbPassedISO;
   BYTE    fbFailedISO;
} PANOSE;

typedef struct _FONTMETRICS      
{
   char    szFamilyname[32];
   char    szFacename[32];
   USHORT  idRegistry;
   USHORT  usCodePage;
   long    lEmHeight;
   long    lXHeight;
   long    lMaxAscender;
   long    lMaxDescender;
   long    lLowerCaseAscent;
   long    lLowerCaseDescent;
   long    lInternalLeading;
   long    lExternalLeading;
   long    lAveCharWidth;
   long    lMaxCharInc;
   long    lEmInc;
   long    lMaxBaselineExt;
   short   sCharSlope;
   short   sInlineDir;
   short   sCharRot;
   USHORT  usWeightClass;
   USHORT  usWidthClass;
   short   sXDeviceRes;
   short   sYDeviceRes;
   short   sFirstChar;
   short   sLastChar;
   short   sDefaultChar;
   short   sBreakChar;
   short   sNominalPointSize;
   short   sMinimumPointSize;
   short   sMaximumPointSize;
   USHORT  fsType;
   USHORT  fsDefn;
   USHORT  fsSelection;
   USHORT  fsCapabilities;
   long    lSubscriptXSize;
   long    lSubscriptYSize;
   long    lSubscriptXOffset;
   long    lSubscriptYOffset;
   long    lSuperscriptXSize;
   long    lSuperscriptYSize;
   long    lSuperscriptXOffset;
   long    lSuperscriptYOffset;
   long    lUnderscoreSize;
   long    lUnderscorePosition;
   long    lStrikeoutSize;
   long    lStrikeoutPosition;
   short   sKerningPairs;
   short   sFamilyClass;
   long    lMatch;
   long    FamilyNameAtom;
   long    FaceNameAtom;
   PANOSE  panose;
} FONTMETRICS;
typedef FONTMETRICS *PFONTMETRICS;
#line 552
typedef LHANDLE HWND;       
typedef HWND *PHWND;

typedef LHANDLE HMQ;        
typedef LHANDLE *PHMQ;
#line 568
typedef struct _ICONINFO {   
   ULONG   cb;                   
   ULONG   fFormat;
   PSZ     pszFileName;          
   HMODULE hmod;                 
   ULONG   resid;                
   ULONG   cbIconData;           
   PVOID   pIconData;            
} ICONINFO;
typedef ICONINFO  *PICONINFO;
#line 590
#pragma info( none )

   #pragma info( restore )

#pragma info( restore )
#line 24 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bse.h"
#pragma info( none )

      #pragma info( none )

#pragma info( restore )
#line 49 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bsedos.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 94
   APIRET _System DosBeep(ULONG freq,
                           ULONG dur);
#line 98
   void _System DosExit(ULONG action,
                         ULONG result);
#line 14 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bsetib.h"
#pragma info( none )

      #pragma info( none )

#pragma info( restore )
#line 33
struct tib2_s
       {
       ULONG   tib2_ultid;              
       ULONG   tib2_ulpri;              
       ULONG   tib2_version;            
       USHORT  tib2_usMCCount;          
       USHORT  tib2_fMCForceFlag;       
       };

typedef struct tib2_s TIB2;
typedef struct tib2_s *PTIB2;

struct tib_s                            
       {
        PVOID   tib_pexchain;            
        PVOID   tib_pstack;              
        PVOID   tib_pstacklimit;         
        PTIB2   tib_ptib2;               
        ULONG   tib_version;             
        ULONG   tib_ordinal;             
       };
#line 56
typedef struct tib_s    tib_t;
typedef struct tib_s    TIB;
typedef struct tib_s    *PTIB;
#line 66
struct pib_s {                          
       ULONG   pib_ulpid;               
       ULONG   pib_ulppid;              
       ULONG   pib_hmte;                
       PCHAR   pib_pchcmd;              
       PCHAR   pib_pchenv;              
       ULONG   pib_flstatus;            
       ULONG   pib_ultype;              
       };
#line 77
typedef struct pib_s    pib_t;
typedef struct pib_s    PIB;
typedef struct pib_s    *PPIB;
#line 87
#pragma info( none )

      #pragma info( restore )

#pragma info( restore )
#line 114 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bsedos.h"
   typedef  void _System FNTHREAD(ULONG);
   typedef FNTHREAD *PFNTHREAD;

   APIRET _System DosCreateThread(PTID ptid,
                                   PFNTHREAD pfn,
                                   ULONG param,
                                   ULONG flag,
                                   ULONG cbStack);

   APIRET _System DosResumeThread(TID tid);

   APIRET _System DosSuspendThread(TID tid);

   APIRET _System DosGetInfoBlocks(PTIB *pptib,
                                    PPIB *pppib);

   APIRET _System DosKillThread(TID tid);

   APIRET _System DosAllocThreadLocalMemory(ULONG cb, PULONG *p);

   APIRET _System DosFreeThreadLocalMemory(ULONG *p);
#line 153
   typedef struct _RESULTCODES        
   {
      ULONG codeTerminate;
      ULONG codeResult;
   } RESULTCODES;
   typedef RESULTCODES *PRESULTCODES;

   APIRET _System DosWaitChild(ULONG action,
                                ULONG option,
                                PRESULTCODES pres,
                                PPID ppid,
                                PID pid);

   APIRET _System DosWaitThread(PTID ptid,
                                 ULONG option);

   APIRET _System DosSleep(ULONG msec);
#line 184
typedef struct _uDB {            
        unsigned long   Pid;             
        unsigned long   Tid;             
        long            Cmd;             
        long            Value;           
        unsigned long   Addr;            
        unsigned long   Buffer;          
        unsigned long   Len;             
        unsigned long   Index;           
        unsigned long   MTE;             
        unsigned long   EAX;             
        unsigned long   ECX;
        unsigned long   EDX;
        unsigned long   EBX;
        unsigned long   ESP;
        unsigned long   EBP;
        unsigned long   ESI;
        unsigned long   EDI;
        unsigned long   EFlags;
        unsigned long   EIP;
        unsigned long   CSLim;
        unsigned long   CSBase;
        unsigned char   CSAcc;
        unsigned char   CSAtr;
        unsigned short  CS;
        unsigned long   DSLim;
        unsigned long   DSBase;
        unsigned char   DSAcc;
        unsigned char   DSAtr;
        unsigned short  DS;
        unsigned long   ESLim;
        unsigned long   ESBase;
        unsigned char   ESAcc;
        unsigned char   ESAtr;
        unsigned short  ES;
        unsigned long   FSLim;
        unsigned long   FSBase;
        unsigned char   FSAcc;
        unsigned char   FSAtr;
        unsigned short  FS;
        unsigned long   GSLim;
        unsigned long   GSBase;
        unsigned char   GSAcc;
        unsigned char   GSAtr;
        unsigned short  GS;
        unsigned long   SSLim;
        unsigned long   SSBase;
        unsigned char   SSAcc;
        unsigned char   SSAtr;
        unsigned short  SS;
} uDB_t;
#line 332
typedef struct _TStat {          
        unsigned char   DbgState;        
        unsigned char   TState;          
        unsigned short  TPriority;       
} TStat_t;
#line 461
   APIRET _System DosDebug(PVOID pdbgbuf);
#line 472
   typedef void _System FNEXITLIST(ULONG);
   typedef FNEXITLIST *PFNEXITLIST;

   APIRET _System DosEnterCritSec(void);

   APIRET _System DosExitCritSec(void);

   APIRET _System DosExitList(ULONG ordercode,
                               PFNEXITLIST pfn);
#line 497
   APIRET _System DosExecPgm(PCHAR pObjname,
                              long cbObjname,
                              ULONG execFlag,
                              PSZ pArg,
                              PSZ pEnv,
                              PRESULTCODES pRes,
                              PSZ pName);
#line 517
   APIRET _System  DosSetPriority(ULONG scope,
                                   ULONG ulClass,
                                   long  delta,
                                   ULONG PorTid);
#line 541
   APIRET _System DosKillProcess(ULONG action,
                                  PID pid);
#line 680
   typedef struct  _EASIZEBUF        
   {
      USHORT  cbMaxEASize;         
      ULONG   cbMaxEAListSize;     
   } EASIZEBUF;
   typedef EASIZEBUF  *PEASIZEBUF;
#line 701
   typedef struct  _FSQBUFFER        
   {
      USHORT  iType;               
      USHORT  cbName;              
      UCHAR   szName[1];           
      USHORT  cbFSDName;           
      UCHAR   szFSDName[1];        
      USHORT  cbFSAData;           
      UCHAR   rgFSAData[1];        
   } FSQBUFFER;
   typedef FSQBUFFER  *PFSQBUFFER;
#line 714
   typedef struct _FSQBUFFER2        
   {
      USHORT  iType;
      USHORT  cbName;
      USHORT  cbFSDName;
      USHORT  cbFSAData;
      UCHAR   szName[1];
      UCHAR   szFSDName[1];
      UCHAR   rgFSAData[1];
   } FSQBUFFER2;
   typedef FSQBUFFER2 *PFSQBUFFER2;

   typedef struct _SPOOLATTACH       
   {
      USHORT  hNmPipe;             
      ULONG   ulKey;               
   } SPOOLATTACH;
   typedef SPOOLATTACH  *PSPOOLATTACH;
#line 758
         typedef struct _FTIME            
         {
            UINT   twosecs : 5;
            UINT   minutes : 6;
            UINT   hours   : 5;
         } FTIME;
         typedef FTIME *PFTIME;
#line 776
         typedef struct _FDATE            
         {
            UINT   day     : 5;
            UINT   month   : 4;
            UINT   year    : 7;
         } FDATE;
         typedef FDATE   *PFDATE;
#line 795
   typedef struct _VOLUMELABEL       
   {
      BYTE cch;
      char szVolLabel[12];
   } VOLUMELABEL;
   typedef VOLUMELABEL  *PVOLUMELABEL;

   typedef struct _FSINFO       
   {
      FDATE fdateCreation;
      FTIME ftimeCreation;
      VOLUMELABEL vol;
   } FSINFO;
   typedef FSINFO *PFSINFO;
#line 817
   typedef struct _FILELOCK       
   {
      long lOffset;
      long lRange;
   } FILELOCK;
   typedef FILELOCK  *PFILELOCK;

   typedef LHANDLE HFILE;      
   typedef HFILE   *PHFILE;
#line 829
      typedef  ULONG    HEV;              
      typedef  HEV      *PHEV;
#line 833
   typedef  ULONG  FHLOCK;
   typedef  PULONG  PFHLOCK;

   APIRET _System DosSetFileLocks(HFILE hFile,
                                   PFILELOCK pflUnlock,
                                   PFILELOCK pflLock,
                                   ULONG timeout,
                                   ULONG flags);
   APIRET _System DosProtectSetFileLocks(HFILE hFile,
                                          PFILELOCK pflUnlock,
                                          PFILELOCK pflLock,
                                          ULONG timeout, ULONG flags,
                                          FHLOCK fhFileHandleLockID);

   APIRET _System DosCancelLockRequest(HFILE hFile,
                                        PFILELOCK pflLock);
#line 853
      typedef struct _FILEFINDBUF      
      {
         FDATE  fdateCreation;
         FTIME  ftimeCreation;
         FDATE  fdateLastAccess;
         FTIME  ftimeLastAccess;
         FDATE  fdateLastWrite;
         FTIME  ftimeLastWrite;
         ULONG  cbFile;
         ULONG  cbFileAlloc;
         USHORT attrFile;
         UCHAR  cchName;
         char   achName[256];
      } FILEFINDBUF;

      typedef FILEFINDBUF *PFILEFINDBUF;
#line 871
      #pragma pack(2)

      typedef struct _FILEFINDBUF2     
      {
         FDATE  fdateCreation;
         FTIME  ftimeCreation;
         FDATE  fdateLastAccess;
         FTIME  ftimeLastAccess;
         FDATE  fdateLastWrite;
         FTIME  ftimeLastWrite;
         ULONG  cbFile;
         ULONG  cbFileAlloc;
         USHORT attrFile;
         ULONG  cbList;
         UCHAR  cchName;
         char   achName[256];
      } FILEFINDBUF2;
      typedef FILEFINDBUF2 *PFILEFINDBUF2;

      typedef struct _FILEFINDBUF3                  
      {
         ULONG   oNextEntryOffset;             
         FDATE   fdateCreation;
         FTIME   ftimeCreation;
         FDATE   fdateLastAccess;
         FTIME   ftimeLastAccess;
         FDATE   fdateLastWrite;
         FTIME   ftimeLastWrite;
         ULONG   cbFile;
         ULONG   cbFileAlloc;
         ULONG   attrFile;                     
         UCHAR   cchName;
         char    achName[256];
      } FILEFINDBUF3;
      typedef FILEFINDBUF3 *PFILEFINDBUF3;

      typedef struct _FILEFINDBUF4                  
      {
         ULONG   oNextEntryOffset;             
         FDATE   fdateCreation;
         FTIME   ftimeCreation;
         FDATE   fdateLastAccess;
         FTIME   ftimeLastAccess;
         FDATE   fdateLastWrite;
         FTIME   ftimeLastWrite;
         ULONG   cbFile;
         ULONG   cbFileAlloc;
         ULONG   attrFile;                     
         ULONG   cbList;
         UCHAR   cchName;
         char    achName[256];
      } FILEFINDBUF4;
      typedef FILEFINDBUF4  *PFILEFINDBUF4;
#line 927
      typedef struct _GEA          
      {
         BYTE cbName;         
         char szName[1];      
      } GEA;
      typedef GEA *PGEA;

      typedef struct _GEALIST      
      {
         ULONG cbList;        
         GEA list[1];         
      } GEALIST;
      typedef GEALIST  *PGEALIST;

      typedef struct _FEA          
      {
         BYTE fEA;            
         BYTE cbName;         
         USHORT cbValue;      
      } FEA;
      typedef FEA *PFEA;
#line 952
      typedef struct _FEALIST      
      {
         ULONG cbList;        
         FEA list[1];         
      } FEALIST;
      typedef FEALIST *PFEALIST;

      typedef struct _EAOP         
      {
         PGEALIST fpGEAList;  
         PFEALIST fpFEAList;  
         ULONG oError;
      } EAOP;
      typedef EAOP *PEAOP;
#line 968
      #pragma pack(1)
#line 971
      typedef struct _FEA2          
      {
         ULONG   oNextEntryOffset;     
         BYTE    fEA;
         BYTE    cbName;
         USHORT  cbValue;
         char    szName[1];            
      } FEA2;
      typedef FEA2 *PFEA2;
#line 982
      typedef struct _FEA2LIST      
      {
         ULONG   cbList;
         FEA2    list[1];
      } FEA2LIST;
      typedef FEA2LIST *PFEA2LIST;

      typedef struct _GEA2           
      {
         ULONG   oNextEntryOffset;      
         BYTE    cbName;
         char    szName[1];             
      } GEA2;
      typedef GEA2 *PGEA2;

      typedef struct _GEA2LIST       
      {
         ULONG   cbList;
         GEA2    list[1];
      } GEA2LIST;
      typedef GEA2LIST *PGEA2LIST;

      typedef struct _EAOP2          
      {
         PGEA2LIST   fpGEA2List;        
         PFEA2LIST   fpFEA2List;        
         ULONG       oError;            
      } EAOP2;
      typedef EAOP2 *PEAOP2;
#line 1035
   #pragma pack()
#line 1050
   APIRET _System  DosOpen(PSZ    pszFileName,
                            PHFILE pHf,
                            PULONG pulAction,
                            ULONG  cbFile,
                            ULONG  ulAttribute,
                            ULONG  fsOpenFlags,
                            ULONG  fsOpenMode,
                            PEAOP2 peaop2);
#line 1071
   APIRET _System  DosProtectOpen(PSZ pszFileName,
                                   PHFILE phf,
                                   PULONG pulAction,
                                   ULONG cbFile,
                                   ULONG ulAttribute,
                                   ULONG fsOpenFlags,
                                   ULONG fsOpenMode,
                                   PEAOP2 peaop2,
                                   PFHLOCK pfhFileHandleLockID);
#line 1082
   APIRET _System  DosClose(HFILE hFile);

   APIRET _System  DosProtectClose(HFILE hFile,
                                    FHLOCK fhFileHandleLockID);

   APIRET _System  DosRead(HFILE hFile,
                            PVOID pBuffer,
                            ULONG cbRead,
                            PULONG pcbActual);

   APIRET _System  DosProtectRead(HFILE hFile,
                                   PVOID pBuffer,
                                   ULONG cbRead,
                                   PULONG pcbActual,
                                   FHLOCK fhFileHandleLockID);

   APIRET _System  DosWrite(HFILE hFile,
                             PVOID pBuffer,
                             ULONG cbWrite,
                             PULONG pcbActual);

   APIRET _System  DosProtectWrite(HFILE hFile,
                                    PVOID pBuffer,
                                    ULONG cbWrite,
                                    PULONG pcbActual,
                                    FHLOCK fhFileHandleLockID);
#line 1111
   typedef struct _FILESTATUS       
   {
      FDATE  fdateCreation;
      FTIME  ftimeCreation;
      FDATE  fdateLastAccess;
      FTIME  ftimeLastAccess;
      FDATE  fdateLastWrite;
      FTIME  ftimeLastWrite;
      ULONG  cbFile;
      ULONG  cbFileAlloc;
      USHORT attrFile;
   } FILESTATUS;
   typedef FILESTATUS *PFILESTATUS;

   typedef struct _FILESTATUS2      
   {
      FDATE  fdateCreation;
      FTIME  ftimeCreation;
      FDATE  fdateLastAccess;
      FTIME  ftimeLastAccess;
      FDATE  fdateLastWrite;
      FTIME  ftimeLastWrite;
      ULONG  cbFile;
      ULONG  cbFileAlloc;
      USHORT attrFile;
      ULONG  cbList;
   } FILESTATUS2;
   typedef FILESTATUS2 *PFILESTATUS2;

   typedef struct _FILESTATUS3      
   {
      FDATE  fdateCreation;
      FTIME  ftimeCreation;
      FDATE  fdateLastAccess;
      FTIME  ftimeLastAccess;
      FDATE  fdateLastWrite;
      FTIME  ftimeLastWrite;
      ULONG  cbFile;
      ULONG  cbFileAlloc;
      ULONG  attrFile;
   } FILESTATUS3;
   typedef FILESTATUS3 *PFILESTATUS3;

   typedef struct _FILESTATUS4       
   {
      FDATE  fdateCreation;
      FTIME  ftimeCreation;
      FDATE  fdateLastAccess;
      FTIME  ftimeLastAccess;
      FDATE  fdateLastWrite;
      FTIME  ftimeLastWrite;
      ULONG  cbFile;
      ULONG  cbFileAlloc;
      ULONG  attrFile;
      ULONG  cbList;
   } FILESTATUS4;
   typedef FILESTATUS4  *PFILESTATUS4;
#line 1170
   typedef struct _FSALLOCATE       
   {
      ULONG  idFileSystem;
      ULONG  cSectorUnit;
      ULONG  cUnit;
      ULONG  cUnitAvail;
      USHORT cbSector;
   } FSALLOCATE;
   typedef FSALLOCATE *PFSALLOCATE;

   typedef LHANDLE HDIR;         
   typedef HDIR    *PHDIR;
#line 1212
   APIRET _System  DosDelete(PSZ pszFile);
#line 1218
   APIRET _System  DosForceDelete(PSZ pszFile);
#line 1221
   APIRET _System  DosDupHandle(HFILE hFile,
                                 PHFILE pHfile);

   APIRET _System  DosQueryFHState(HFILE hFile,
                                    PULONG pMode);
   APIRET _System  DosProtectQueryFHState(HFILE hFile,
                                           PULONG pMode,
                                           FHLOCK fhFileHandleLockID);

   APIRET _System  DosSetFHState(HFILE hFile,
                                  ULONG mode);

   APIRET _System  DosProtectSetFHState(HFILE hFile,
                                         ULONG mode,
                                         FHLOCK fhFileHandleLockID);

   APIRET _System  DosQueryHType(HFILE hFile,
                                  PULONG pType,
                                  PULONG pAttr);
#line 1250
   APIRET _System  DosFindFirst(PSZ    pszFileSpec,
                                 PHDIR  phdir,
                                 ULONG  flAttribute,
                                 PVOID  pfindbuf,
                                 ULONG  cbBuf,
                                 PULONG pcFileNames,
                                 ULONG  ulInfoLevel);
#line 1259
   APIRET _System  DosFindNext(HDIR   hDir,
                                PVOID  pfindbuf,
                                ULONG  cbfindbuf,
                                PULONG pcFilenames);

   APIRET _System  DosFindClose(HDIR hDir);
#line 1273
   APIRET _System  DosFSAttach(PSZ pszDevice,
                                PSZ pszFilesystem,
                                PVOID pData,
                                ULONG cbData,
                                ULONG flag);
#line 1287
   APIRET _System  DosQueryFSAttach(PSZ    pszDeviceName,
                                     ULONG  ulOrdinal,
                                     ULONG  ulFSAInfoLevel,
                                     PFSQBUFFER2 pfsqb,
                                     PULONG pcbBuffLength);
#line 1306
   APIRET _System  DosFSCtl(PVOID pData,
                             ULONG cbData,
                             PULONG pcbData,
                             PVOID pParms,
                             ULONG cbParms,
                             PULONG pcbParms,
                             ULONG function,
                             PSZ pszRoute,
                             HFILE hFile,
                             ULONG method);
#line 1318
   APIRET _System  DosSetFileSize(HFILE hFile,
                                   ULONG cbSize);

   APIRET _System  DosProtectSetFileSize(HFILE hFile,
                                          ULONG cbSize,
                                          FHLOCK fhFileHandleLockID);

   APIRET _System  DosResetBuffer(HFILE hFile);

   APIRET _System  DosSetFilePtr(HFILE hFile,
                                  long ib,
                                  ULONG method,
                                  PULONG ibActual);

   APIRET _System  DosProtectSetFilePtr(HFILE hFile,
                                         long ib,
                                         ULONG method,
                                         PULONG ibActual,
                                         FHLOCK fhFileHandleLockID);
#line 1342
   APIRET _System  DosMove(PSZ pszOld,
                            PSZ pszNew);
#line 1351
   APIRET _System  DosCopy(PSZ pszOld,
                            PSZ pszNew,
                            ULONG option);
#line 1363
   APIRET _System  DosEditName(ULONG metalevel,
                                PSZ pszSource,
                                PSZ pszEdit,
                                PBYTE pszTarget,
                                ULONG cbTarget);
#line 1374
   APIRET _System  DosCreateDir(PSZ pszDirName,
                                 PEAOP2 peaop2);
#line 1381
   APIRET _System  DosDeleteDir(PSZ pszDir);
#line 1384
   APIRET _System  DosSetDefaultDisk(ULONG disknum);

   APIRET _System  DosQueryCurrentDisk(PULONG pdisknum,
                                        PULONG plogical);
#line 1392
   APIRET _System  DosSetCurrentDir(PSZ pszDir);
#line 1395
   APIRET _System  DosQueryCurrentDir(ULONG disknum,
                                       PBYTE pBuf,
                                       PULONG pcbBuf);

   APIRET _System  DosQueryFSInfo(ULONG disknum,
                                   ULONG infolevel,
                                   PVOID pBuf,
                                   ULONG cbBuf);

   APIRET _System  DosSetFSInfo(ULONG disknum,
                                 ULONG infolevel,
                                 PVOID pBuf,
                                 ULONG cbBuf);

   APIRET _System  DosQueryVerify(PBOOL pBool);

   APIRET _System  DosSetVerify(BOOL);

   APIRET _System  DosSetMaxFH(ULONG cFH);

   APIRET _System  DosSetRelMaxFH(PLONG pcbReqCount,
                                   PULONG pcbCurMaxFH);

   APIRET _System  DosQueryFileInfo(HFILE hf,
                                     ULONG ulInfoLevel,
                                     PVOID pInfo,
                                     ULONG cbInfoBuf);

   APIRET _System  DosProtectQueryFileInfo(HFILE hf,
                                            ULONG ulInfoLevel,
                                            PVOID pInfo,
                                            ULONG cbInfoBuf,
                                            FHLOCK fhFileHandleLockID);

   APIRET _System  DosSetFileInfo(HFILE hf,
                                   ULONG ulInfoLevel,
                                   PVOID pInfoBuf,
                                   ULONG cbInfoBuf);

   APIRET _System  DosProtectSetFileInfo(HFILE hf,
                                          ULONG ulInfoLevel,
                                          PVOID pInfoBuf,
                                          ULONG cbInfoBuf,
                                          FHLOCK fhFileHandleLockID);
#line 1446
   APIRET _System  DosQueryPathInfo(PSZ   pszPathName,
                                     ULONG ulInfoLevel,
                                     PVOID pInfoBuf,
                                     ULONG cbInfoBuf);
#line 1459
   APIRET _System  DosSetPathInfo(PSZ   pszPathName,
                                   ULONG ulInfoLevel,
                                   PVOID pInfoBuf,
                                   ULONG cbInfoBuf,
                                   ULONG flOptions);
#line 1469
   APIRET _System  DosShutdown(ULONG ulReserved);

   APIRET _System  DosEnumAttribute(ULONG  ulRefType,
                                     PVOID  pvFile,
                                     ULONG  ulEntry,
                                     PVOID  pvBuf,
                                     ULONG  cbBuf,
                                     PULONG pulCount,
                                     ULONG  ulInfoLevel);

   APIRET _System  DosProtectEnumAttribute(ULONG ulRefType,
                                            PVOID pvFile,
                                            ULONG ulEntry,
                                            PVOID pvBuf,
                                            ULONG cbBuf,
                                            PULONG pulCount,
                                            ULONG ulInfoLevel,
                                            FHLOCK fhFileHandleLockID );
#line 1489
   #pragma pack(1)
#line 1492
   typedef struct _DENA1  
   {
      UCHAR       reserved;        
      UCHAR       cbName;          
      USHORT      cbValue;         
      UCHAR       szName[1];       
   } DENA1;
   typedef DENA1 *PDENA1;

   typedef FEA2  DENA2;
   typedef PFEA2 PDENA2;
#line 1505
   #pragma pack()
#line 1519
   APIRET _System  DosAllocMem(PPVOID ppb,
                                ULONG cb,
                                ULONG flag);

   APIRET _System  DosFreeMem(PVOID pb);

   APIRET _System  DosSetMem(PVOID pb,
                              ULONG cb,
                              ULONG flag);

   APIRET _System  DosGiveSharedMem(PVOID pb,
                                     PID pid,
                                     ULONG flag);

   APIRET _System  DosGetSharedMem(PVOID pb,
                                    ULONG flag);
#line 1541
   APIRET _System  DosGetNamedSharedMem(PPVOID ppb,
                                         PSZ pszName,
                                         ULONG flag);
#line 1552
   APIRET _System  DosAllocSharedMem(PPVOID ppb,
                                      PSZ pszName,
                                      ULONG cb,
                                      ULONG flag);
#line 1558
   APIRET _System  DosQueryMem(PVOID pb,
                                PULONG pcb,
                                PULONG pFlag);
#line 1564
   APIRET _System  DosSubAllocMem(PVOID pbBase,
                                   PPVOID ppb,
                                   ULONG cb);
#line 1570
   APIRET _System  DosSubFreeMem(PVOID pbBase,
                                  PVOID pb,
                                  ULONG cb);
#line 1576
   APIRET _System  DosSubSetMem(PVOID pbBase,
                                 ULONG flag,
                                 ULONG cb);
#line 1582
   APIRET _System  DosSubUnsetMem(PVOID pbBase);
#line 14 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bsememf.h"
#pragma info( none )

      #pragma info( none )

#pragma info( restore )
#line 149
#pragma info( none )

      #pragma info( restore )

#pragma info( restore )
#line 1618 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bsedos.h"
   typedef struct _PSEMRECORD       
   {
      HSEM        hsemCur;
      ULONG       ulUser;
   } SEMRECORD;
   typedef SEMRECORD *PSEMRECORD;
#line 1637
   typedef  ULONG    HMTX;             
   typedef  HMTX     *PHMTX;
   typedef  ULONG    HMUX;             
   typedef  HMUX     *PHMUX;
#line 1648
   APIRET _System  DosCreateEventSem (PSZ pszName,
                                       PHEV phev,
                                       ULONG flAttr,
                                       BOOL fState);
#line 1658
   APIRET _System  DosOpenEventSem (PSZ pszName,
                                     PHEV phev);
#line 1662
   APIRET _System  DosCloseEventSem (HEV hev);

   APIRET _System  DosResetEventSem (HEV hev,
                                      PULONG pulPostCt);

   APIRET _System  DosPostEventSem (HEV hev);

   APIRET _System  DosWaitEventSem (HEV hev,
                                     ULONG ulTimeout);

   APIRET _System  DosQueryEventSem (HEV hev,
                                      PULONG pulPostCt);
#line 1681
   APIRET _System  DosCreateMutexSem (PSZ pszName,
                                       PHMTX phmtx,
                                       ULONG flAttr,
                                       BOOL fState);
#line 1691
   APIRET _System  DosOpenMutexSem (PSZ pszName,
                                     PHMTX phmtx);
#line 1695
   APIRET _System  DosCloseMutexSem (HMTX hmtx);

   APIRET _System  DosRequestMutexSem (HMTX hmtx,
                                        ULONG ulTimeout);

   APIRET _System  DosReleaseMutexSem (HMTX hmtx);

   APIRET _System  DosQueryMutexSem (HMTX hmtx,
                                      PID *ppid,
                                      TID *ptid,
                                      PULONG pulCount);
#line 1714
   APIRET _System  DosCreateMuxWaitSem (PSZ pszName,
                                         PHMUX phmux,
                                         ULONG cSemRec,
                                         PSEMRECORD pSemRec,
                                         ULONG flAttr);
#line 1725
   APIRET _System  DosOpenMuxWaitSem (PSZ pszName,
                                       PHMUX phmux);
#line 1729
   APIRET _System  DosCloseMuxWaitSem (HMUX hmux);

   APIRET _System  DosWaitMuxWaitSem (HMUX hmux,
                                       ULONG ulTimeout,
                                       PULONG pulUser);

   APIRET _System  DosAddMuxWaitSem (HMUX hmux,
                                      PSEMRECORD pSemRec);

   APIRET _System  DosDeleteMuxWaitSem (HMUX hmux,
                                         HSEM hSem);

   APIRET _System  DosQueryMuxWaitSem (HMUX hmux,
                                        PULONG pcSemRec,
                                        PSEMRECORD pSemRec,
                                        PULONG pflAttr);
#line 1754
   typedef struct _DATETIME       
   {
      UCHAR   hours;
      UCHAR   minutes;
      UCHAR   seconds;
      UCHAR   hundredths;
      UCHAR   day;
      UCHAR   month;
      USHORT  year;
      short   timezone;
      UCHAR   weekday;
   } DATETIME;
   typedef DATETIME *PDATETIME;

   APIRET _System   DosGetDateTime(PDATETIME pdt);

   APIRET _System   DosSetDateTime(PDATETIME pdt);
#line 1782
   typedef LHANDLE HTIMER;
   typedef HTIMER  *PHTIMER;

   APIRET _System   DosAsyncTimer(ULONG msec,
                                   HSEM hsem,
                                   PHTIMER phtimer);

   APIRET _System   DosStartTimer(ULONG msec,
                                   HSEM hsem,
                                   PHTIMER phtimer);

   APIRET _System   DosStopTimer(HTIMER htimer);
#line 1811
   APIRET _System  DosLoadModule(PSZ pszName,
                                  ULONG cbName,
                                  PSZ pszModname,
                                  PHMODULE phmod);
#line 1817
   APIRET _System  DosFreeModule(HMODULE hmod);
#line 1825
   APIRET _System  DosQueryProcAddr(HMODULE hmod,
                                     ULONG ordinal,
                                     PSZ pszName,
                                     PFN* ppfn);
#line 1835
   APIRET _System  DosQueryModuleHandle(PSZ pszModname,
                                         PHMODULE phmod);
#line 1839
   APIRET _System  DosQueryModuleName(HMODULE hmod,
                                       ULONG cbName,
                                       PCHAR pch);
#line 1852
   APIRET _System  DosQueryProcType(HMODULE hmod,
                                     ULONG ordinal,
                                     PSZ pszName,
                                     PULONG pulproctype);
#line 1907
   APIRET _System  DosGetResource(HMODULE hmod,
                                   ULONG idType,
                                   ULONG idName,
                                   PPVOID ppb);

   APIRET _System  DosFreeResource(PVOID pb);

   APIRET _System  DosQueryResourceSize(HMODULE hmod,
                                         ULONG idt,
                                         ULONG idn,
                                         PULONG pulsize);
#line 1928
   typedef struct _COUNTRYCODE    
   {
      ULONG       country;
      ULONG       codepage;
   } COUNTRYCODE;
   typedef COUNTRYCODE *PCOUNTRYCODE;

   typedef struct _COUNTRYINFO    
   {
      ULONG       country;
      ULONG       codepage;
      ULONG       fsDateFmt;
      char        szCurrency[5];
      char        szThousandsSeparator[2];
      char        szDecimal[2];
      char        szDateSeparator[2];
      char        szTimeSeparator[2];
      UCHAR       fsCurrencyFmt;
      UCHAR       cDecimalPlace;
      UCHAR       fsTimeFmt;
      USHORT      abReserved1[2];
      char        szDataSeparator[2];
      USHORT      abReserved2[5];
   } COUNTRYINFO, *PCOUNTRYINFO;
#line 1960
   APIRET _System  DosQueryCtryInfo(ULONG cb,
                                     PCOUNTRYCODE pcc,
                                     PCOUNTRYINFO pci,
                                     PULONG pcbActual);

   APIRET _System  DosQueryDBCSEnv(ULONG cb,
                                    PCOUNTRYCODE pcc,
                                    PCHAR pBuf);

   APIRET _System  DosMapCase(ULONG cb,
                               PCOUNTRYCODE pcc,
                               PCHAR pch);

   APIRET _System  DosQueryCollate(ULONG cb,
                                    PCOUNTRYCODE pcc,
                                    PCHAR pch,
                                    PULONG pcch);

   APIRET _System  DosQueryCp(ULONG cb,
                               PULONG arCP,
                               PULONG pcCP);

   APIRET _System  DosSetProcessCp(ULONG cp);
#line 20 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bsexcpt.h"
#pragma info( none )

      #pragma info( none )

#pragma info( restore )
#line 212
#pragma pack(1)

typedef struct  _fpreg       
   {
   ULONG losig;
   ULONG hisig;
   USHORT signexp;
   } FPREG , *PFPREG ;
#pragma pack()

struct _CONTEXT
   {
#line 240
   ULONG ContextFlags;
#line 247
   ULONG   ctx_env[7];
   FPREG   ctx_stack[8];
#line 255
   ULONG ctx_SegGs;
   ULONG ctx_SegFs;
   ULONG ctx_SegEs;
   ULONG ctx_SegDs;
#line 265
   ULONG ctx_RegEdi;
   ULONG ctx_RegEsi;
   ULONG ctx_RegEax;
   ULONG ctx_RegEbx;
   ULONG ctx_RegEcx;
   ULONG ctx_RegEdx;
#line 277
   ULONG ctx_RegEbp;
   ULONG ctx_RegEip;
   ULONG ctx_SegCs;
   ULONG ctx_EFlags;
   ULONG ctx_RegEsp;
   ULONG ctx_SegSs;

   };

typedef struct _CONTEXT CONTEXTRECORD;
typedef struct _CONTEXT *PCONTEXTRECORD;
#line 302
struct _EXCEPTIONREPORTRECORD
   {
   ULONG   ExceptionNum;                 
   ULONG   fHandlerFlags;
   struct  _EXCEPTIONREPORTRECORD    *NestedExceptionReportRecord;
   PVOID   ExceptionAddress;
   ULONG   cParameters;                  
   ULONG   ExceptionInfo[4];

   };

typedef struct _EXCEPTIONREPORTRECORD EXCEPTIONREPORTRECORD;
typedef struct _EXCEPTIONREPORTRECORD *PEXCEPTIONREPORTRECORD;
#line 324
struct _EXCEPTIONREGISTRATIONRECORD;

typedef ULONG _System _ERR(PEXCEPTIONREPORTRECORD,
                            struct _EXCEPTIONREGISTRATIONRECORD *,
                            PCONTEXTRECORD,
                            PVOID);

typedef _ERR  *ERR;

struct _EXCEPTIONREGISTRATIONRECORD
   {
   struct _EXCEPTIONREGISTRATIONRECORD * volatile prev_structure;
   _ERR * volatile ExceptionHandler;
   };

typedef struct _EXCEPTIONREGISTRATIONRECORD EXCEPTIONREGISTRATIONRECORD;
typedef struct _EXCEPTIONREGISTRATIONRECORD *PEXCEPTIONREGISTRATIONRECORD;
#line 345
#pragma pack()
#line 353
#pragma info( none )

      #pragma info( restore )

#pragma info( restore )
#line 2000 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bsedos.h"
   APIRET _System  DosSetExceptionHandler(PEXCEPTIONREGISTRATIONRECORD pERegRec);

   APIRET _System  DosUnsetExceptionHandler(PEXCEPTIONREGISTRATIONRECORD pERegRec);

   APIRET _System  DosRaiseException(PEXCEPTIONREPORTRECORD pexcept);

   APIRET _System  DosSendSignalException(PID pid,
                                           ULONG exception);

   APIRET _System  DosUnwindException(PEXCEPTIONREGISTRATIONRECORD phandler,
                                       PVOID pTargetIP,
                                       PEXCEPTIONREPORTRECORD pERepRec);

   APIRET _System  DosSetSignalExceptionFocus(BOOL flag,
                                               PULONG pulTimes);

   APIRET _System  DosEnterMustComplete(PULONG pulNesting);

   APIRET _System  DosExitMustComplete(PULONG pulNesting);

   APIRET _System  DosAcknowledgeSignalException(ULONG ulSignalNum);
#line 2030
      typedef LHANDLE HQUEUE;   
      typedef HQUEUE  *PHQUEUE;
      typedef struct _REQUESTDATA      
      {
         PID         pid;
         ULONG       ulData;
      } REQUESTDATA;
      typedef REQUESTDATA *PREQUESTDATA;
#line 2046
      APIRET _System  DosCreatePipe(PHFILE phfRead,
                                     PHFILE phfWrite,
                                     ULONG cb);

      APIRET _System  DosCloseQueue(HQUEUE hq);
#line 2057
      APIRET _System  DosCreateQueue(PHQUEUE phq,
                                      ULONG priority,
                                      PSZ pszName);
#line 2067
      APIRET _System  DosOpenQueue(PPID ppid,
                                    PHQUEUE phq,
                                    PSZ pszName);
#line 2072
      APIRET _System  DosPeekQueue(HQUEUE hq,
                                    PREQUESTDATA pRequest,
                                    PULONG pcbData,
                                    PPVOID ppbuf,
                                    PULONG element,
                                    BOOL nowait,
                                    PBYTE ppriority,
                                    HEV hsem);

      APIRET _System  DosPurgeQueue(HQUEUE hq);

      APIRET _System  DosQueryQueue(HQUEUE hq,
                                     PULONG pcbEntries);

      APIRET _System  DosReadQueue(HQUEUE hq,
                                    PREQUESTDATA pRequest,
                                    PULONG pcbData,
                                    PPVOID ppbuf,
                                    ULONG element,
                                    BOOL wait,
                                    PBYTE ppriority,
                                    HEV hsem);

      APIRET _System  DosWriteQueue(HQUEUE hq,
                                     ULONG request,
                                     ULONG cbData,
                                     PVOID pbData,
                                     ULONG priority);
#line 2162
   APIRET _System  DosError(ULONG error);
#line 2173
   APIRET _System  DosGetMessage(PCHAR* pTable,
                                  ULONG cTable,
                                  PCHAR pBuf,
                                  ULONG cbBuf,
                                  ULONG msgnumber,
                                  PSZ pszFile,
                                  PULONG pcbMsg);
#line 2182
   APIRET _System  DosErrClass(ULONG code,
                                PULONG pClass,
                                PULONG pAction,
                                PULONG pLocus);
#line 2196
   APIRET _System  DosInsertMessage(PCHAR* pTable,
                                     ULONG cTable,
                                     PSZ pszMsg,
                                     ULONG cbMsg,
                                     PCHAR pBuf,
                                     ULONG cbBuf,
                                     PULONG pcbMsg);
#line 2205
   APIRET _System  DosPutMessage(HFILE hfile,
                                  ULONG cbMsg,
                                  PCHAR pBuf);

   APIRET _System  DosQuerySysInfo(ULONG iStart,
                                    ULONG iLast,
                                    PVOID pBuf,
                                    ULONG cbBuf);
#line 2218
   APIRET _System  DosScanEnv(PSZ pszName,
                               PSZ *ppszValue);
#line 2229
   APIRET _System  DosSearchPath(ULONG flag,
                                  PSZ pszPathOrName,
                                  PSZ pszFilename,
                                  PBYTE pBuf,
                                  ULONG cbBuf);
#line 2242
   APIRET _System  DosQueryMessageCP(PCHAR pb,
                                      ULONG cb,
                                      PSZ pszFilename,
                                      PULONG cbBuf);
#line 2248
   APIRET _System  DosQueryRASInfo(ULONG Index,
                                    PPVOID Addr);
#line 2254
   APIRET  _System DosSetExtLIBPATH( PSZ pszExtLIBPATH, ULONG flags);
#line 2260
   APIRET  _System DosQueryExtLIBPATH( PSZ pszExtLIBPATH, ULONG flags);
#line 2270
   typedef struct _STARTDATA      
   {
      USHORT  Length;
      USHORT  Related;
      USHORT  FgBg;
      USHORT  TraceOpt;
      PSZ     PgmTitle;
      PSZ     PgmName;
      PBYTE   PgmInputs;
      PBYTE   TermQ;
      PBYTE   Environment;
      USHORT  InheritOpt;
      USHORT  SessionType;
      PSZ     IconFile;
      ULONG   PgmHandle;
      USHORT  PgmControl;
      USHORT  InitXPos;
      USHORT  InitYPos;
      USHORT  InitXSize;
      USHORT  InitYSize;
      USHORT  Reserved;
      PSZ     ObjectBuffer;
      ULONG   ObjectBuffLen;
   } STARTDATA;
   typedef STARTDATA *PSTARTDATA;
#line 2329
   typedef struct _STATUSDATA    
   {
      USHORT Length;
      USHORT SelectInd;
      USHORT BondInd;
   } STATUSDATA;
   typedef STATUSDATA *PSTATUSDATA;
#line 2353
   APIRET _System  DosStartSession(PSTARTDATA psd,
                                    PULONG pidSession,
                                    PPID ppid);

   APIRET _System  DosSetSession(ULONG idSession,
                                  PSTATUSDATA psd);

   APIRET _System  DosSelectSession(ULONG idSession);

   APIRET _System  DosStopSession(ULONG scope,
                                   ULONG idSession);
#line 2369
   APIRET _System DosQueryAppType(PSZ pszName,
                                   PULONG pFlags);
#line 2420
   APIRET _System  DosDevConfig(PVOID pdevinfo,
                                 ULONG item);
#line 2431
   APIRET _System  DosDevIOCtl(HFILE hDevice,
                                ULONG category,
                                ULONG function,
                                PVOID pParams,
                                ULONG cbParmLenMax,
                                PULONG pcbParmLen,
                                PVOID pData,
                                ULONG cbDataLenMax,
                                PULONG pcbDataLen);
#line 2442
   APIRET _System  DosPhysicalDisk(ULONG function,
                                    PVOID pBuf,
                                    ULONG cbBuf,
                                    PVOID pParams,
                                    ULONG cbParams);
#line 2461
   typedef LHANDLE HPIPE;      
   typedef HPIPE   *PHPIPE;

   typedef struct _AVAILDATA               
   {
      USHORT      cbpipe;             
      USHORT      cbmessage;          
   } AVAILDATA;
   typedef AVAILDATA *PAVAILDATA;

   typedef struct _PIPEINFO                
   {
      USHORT cbOut;                   
      USHORT cbIn;                    
      BYTE   cbMaxInst;               
      BYTE   cbCurInst;               
      BYTE   cbName;                  
      char   szName[1];               
   } PIPEINFO;
   typedef PIPEINFO  *PPIPEINFO;

   typedef struct _PIPESEMSTATE     
   {
      BYTE   fStatus;          

      BYTE   fFlag;            
      USHORT usKey;            
      USHORT usAvail;          
   } PIPESEMSTATE;
   typedef PIPESEMSTATE *PPIPESEMSTATE;
#line 2534
   APIRET _System  DosCallNPipe(PSZ pszName,
                                 PVOID pInbuf,
                                 ULONG cbIn,
                                 PVOID pOutbuf,
                                 ULONG cbOut,
                                 PULONG pcbActual,
                                 ULONG msec);
#line 2543
   APIRET _System  DosConnectNPipe(HPIPE hpipe);

   APIRET _System  DosDisConnectNPipe(HPIPE hpipe);
#line 2556
   APIRET _System  DosCreateNPipe(PSZ pszName,
                                   PHPIPE pHpipe,
                                   ULONG openmode,
                                   ULONG pipemode,
                                   ULONG cbInbuf,
                                   ULONG cbOutbuf,
                                   ULONG msec);
#line 2565
   APIRET _System  DosPeekNPipe(HPIPE hpipe,
                                 PVOID pBuf,
                                 ULONG cbBuf,
                                 PULONG pcbActual,
                                 PAVAILDATA pAvail,
                                 PULONG pState);

   APIRET _System  DosQueryNPHState(HPIPE hpipe,
                                     PULONG pState);

   APIRET _System  DosQueryNPipeInfo(HPIPE hpipe,
                                      ULONG infolevel,
                                      PVOID pBuf,
                                      ULONG cbBuf);

   APIRET _System  DosQueryNPipeSemState(HSEM hsem,
                                          PPIPESEMSTATE pnpss,
                                          ULONG cbBuf);
#line 2590
   APIRET _System  DosRawReadNPipe(PSZ pszName,
                                    ULONG cb,
                                    PULONG pLen,
                                    PVOID pBuf);
#line 2600
   APIRET _System  DosRawWriteNPipe(PSZ pszName,
                                     ULONG cb);
#line 2604
   APIRET _System  DosSetNPHState(HPIPE hpipe,
                                   ULONG state);

   APIRET _System  DosSetNPipeSem(HPIPE hpipe,
                                   HSEM hsem,
                                   ULONG key);

   APIRET _System  DosTransactNPipe(HPIPE hpipe,
                                     PVOID pOutbuf,
                                     ULONG cbOut,
                                     PVOID pInbuf,
                                     ULONG cbIn,
                                     PULONG pcbRead);
#line 2622
   APIRET _System  DosWaitNPipe(PSZ pszName,
                                 ULONG msec);
#line 2683
   APIRET _System DosTmrQueryFreq(PULONG pulTmrFreq);

   APIRET _System DosTmrQueryTime(PQWORD pqwTmrTime);

   APIRET _System DosRegisterPerfCtrs(PBYTE pbDataBlk,
                                       PBYTE pbTextBlk,
                                       ULONG flFlags);
#line 2732
   typedef LHANDLE   HVDD;      
   typedef HVDD     *PHVDD;     
#line 2739
   APIRET _System  DosOpenVDD(PSZ pszVDD,
                               PHVDD phvdd);
#line 2743
   APIRET _System  DosRequestVDD(HVDD hvdd,
                                  SGID sgid,
                                  ULONG cmd,
                                  ULONG cbInput,
                                  PVOID pInput,
                                  ULONG cbOutput,
                                  PVOID pOutput);

   APIRET _System  DosCloseVDD(HVDD hvdd);
#line 2759
   APIRET _System  DosQueryDOSProperty(SGID sgid,
                                        PSZ pszName,
                                        ULONG cb,
                                        PSZ pch);
#line 2771
   APIRET _System  DosSetDOSProperty(SGID sgid,
                                      PSZ pszName,
                                      ULONG cb,
                                      PSZ pch);
#line 2792
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 33 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bsesub.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 1092
#pragma pack()
#line 1101
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 69 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\bse.h"
#pragma info( none )

      #pragma info( restore )

#pragma info( restore )
#line 41 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pm.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 68 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwin.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 168
typedef void *MPARAM;     
typedef MPARAM *PMPARAM;    
typedef void *MRESULT;    
typedef MRESULT *PMRESULT;   
#line 226
typedef MRESULT (_System FNWP)(HWND, ULONG, MPARAM, MPARAM);
typedef FNWP *PFNWP;
#line 321
   BOOL    _System WinRegisterClass(HAB hab,
                                     PSZ pszClassName,
                                     PFNWP pfnWndProc,
                                     ULONG flStyle,
                                     ULONG cbWindowData);
#line 328
   MRESULT _System WinDefWindowProc(HWND hwnd,
                                     ULONG msg,
                                     MPARAM mp1,
                                     MPARAM mp2);

   BOOL    _System WinDestroyWindow(HWND hwnd);

   BOOL    _System WinShowWindow(HWND hwnd,
                                  BOOL fShow);

   BOOL    _System WinQueryWindowRect(HWND hwnd,
                                       PRECTL prclDest);

   HPS     _System WinGetPS(HWND hwnd);

   BOOL    _System WinReleasePS(HPS hps);

   BOOL    _System WinEndPaint(HPS hps);
#line 349
      HPS   _System WinGetClipPS(HWND hwnd,
                                  HWND hwndClip,
                                  ULONG fl);

      BOOL  _System WinIsWindowShowing(HWND hwnd);
#line 357
   HPS   _System WinBeginPaint(HWND hwnd,
                                HPS hps,
                                PRECTL prclPaint);
   HDC   _System WinOpenWindowDC(HWND hwnd);

   long _System WinScrollWindow(HWND hwnd,
                                 long dx,
                                 long dy,
                                 PRECTL prclScroll,
                                 PRECTL prclClip,
                                 HRGN hrgnUpdate,
                                 PRECTL prclUpdate,
                                 ULONG rgfsw);
#line 387
   BOOL  _System WinFillRect(HPS hps,
                              PRECTL prcl,
                              long lColor);
#line 393
   typedef struct _QVERSDATA     
   {
      USHORT   environment;
      USHORT   version;
   } QVERSDATA;
   typedef QVERSDATA *PQVERSDATA;
#line 407
   ULONG  _System WinQueryVersion(HAB hab);

   HAB    _System WinInitialize(ULONG flOptions);

   BOOL   _System WinTerminate(HAB hab);

   HAB    _System WinQueryAnchorBlock(HWND hwnd);
#line 437
HWND    _System WinCreateWindow(HWND hwndParent,
                                 PSZ pszClass,
                                 PSZ pszName,
                                 ULONG flStyle,
                                 long x,
                                 long y,
                                 long cx,
                                 long cy,
                                 HWND hwndOwner,
                                 HWND hwndInsertBehind,
                                 ULONG id,
                                 PVOID pCtlData,
                                 PVOID pPresParams);
#line 452
BOOL    _System WinEnableWindow(HWND hwnd,
                                 BOOL fEnable);

BOOL    _System WinIsWindowEnabled(HWND hwnd);

BOOL    _System WinEnableWindowUpdate(HWND hwnd,
                                       BOOL fEnable);

BOOL    _System WinIsWindowVisible(HWND hwnd);

long    _System WinQueryWindowText(HWND hwnd,
                                    long cchBufferMax,
                                    PCH pchBuffer);
#line 470
BOOL    _System WinSetWindowText(HWND hwnd,
                                  PSZ pszText);
#line 474
long    _System WinQueryWindowTextLength(HWND hwnd);

HWND    _System WinWindowFromID(HWND hwndParent,
                                 ULONG id);

BOOL    _System WinIsWindow(HAB hab,
                             HWND hwnd);

HWND    _System WinQueryWindow(HWND hwnd,
                                long cmd);

long    _System WinMultWindowFromIDs(HWND hwndParent,
                                      PHWND prghwnd,
                                      ULONG idFirst,
                                      ULONG idLast);
#line 502
BOOL   _System WinSetParent(HWND hwnd,
                             HWND hwndNewParent,
                             BOOL fRedraw);

BOOL   _System WinIsChild(HWND hwnd,
                           HWND hwndParent);
BOOL   _System WinSetOwner(HWND hwnd,
                            HWND hwndNewOwner);

   BOOL   _System WinQueryWindowProcess(HWND hwnd,
                                         PPID ppid,
                                         PTID ptid);
#line 516
HWND   _System WinQueryObjectWindow(HWND hwndDesktop);
HWND   _System WinQueryDesktopWindow(HAB hab,
                                      HDC hdc);
#line 524
typedef struct _SWP     
{
   ULONG   fl;
   long    cy;
   long    cx;
   long    y;
   long    x;
   HWND    hwndInsertBehind;
   HWND    hwnd;
   ULONG   ulReserved1;
   ULONG   ulReserved2;
} SWP;
typedef SWP *PSWP;

BOOL   _System WinSetWindowPos(HWND hwnd,
                                HWND hwndInsertBehind,
                                long x,
                                long y,
                                long cx,
                                long cy,
                                ULONG fl);
BOOL   _System WinSetMultWindowPos(HAB hab,
                                    PSWP pswp,
                                    ULONG cswp);
BOOL   _System WinQueryWindowPos(HWND hwnd,
                                  PSWP pswp);
#line 580
BOOL  _System WinUpdateWindow(HWND hwnd);

BOOL  _System WinInvalidateRect(HWND hwnd,
                                 PRECTL pwrc,
                                 BOOL fIncludeChildren);

BOOL  _System WinInvalidateRegion(HWND hwnd,
                                   HRGN hrgn,
                                   BOOL fIncludeChildren);
#line 593
BOOL  _System WinInvertRect(HPS hps,
                             PRECTL prcl);
BOOL  _System WinDrawBitmap(HPS hpsDst,
                             HBITMAP hbm,
                             PRECTL pwrcSrc,
                             PPOINTL pptlDst,
                             long clrFore,
                             long clrBack,
                             ULONG fl);
#line 613
long    _System WinDrawText(HPS hps,
                             long cchText,
                             PCH lpchText,
                             PRECTL prcl,
                             long clrFore,
                             long clrBack,
                             ULONG flCmd);
#line 645
BOOL _System WinDrawBorder(HPS hps,
                            PRECTL prcl,
                            long cx,
                            long cy,
                            long clrFore,
                            long clrBack,
                            ULONG flCmd);
#line 678
long    _System WinLoadString(HAB hab,
                               HMODULE hmod,
                               ULONG id,
                               long cchMax,
                               PSZ pchBuffer);
#line 692
   long    _System WinLoadMessage(HAB hab,
                                   HMODULE hmod,
                                   ULONG id,
                                   long cchMax,
                                   PSZ pchBuffer);
#line 706
   BOOL _System WinSetActiveWindow(HWND hwndDesktop,
                                    HWND hwnd);
#line 714
   typedef struct _CREATESTRUCT     
   {
      PVOID   pPresParams;
      PVOID   pCtlData;
      ULONG   id;
      HWND    hwndInsertBehind;
      HWND    hwndOwner;
      long    cy;
      long    cx;
      long    y;
      long    x;
      ULONG   flStyle;
      PSZ     pszText;
      PSZ     pszClass;
      HWND    hwndParent;
   } CREATESTRUCT;
   typedef CREATESTRUCT *PCREATESTRUCT;
#line 734
   typedef struct _CLASSINFO     
   {
      ULONG   flClassStyle;
      PFNWP   pfnWindowProc;
      ULONG   cbWindowData;
   } CLASSINFO;
   typedef CLASSINFO *PCLASSINFO;
#line 743
      PFNWP  _System WinSubclassWindow(HWND hwnd,
                                        PFNWP pfnwp);
#line 747
   long    _System WinQueryClassName(HWND hwnd,
                                      long cchMax,
                                      PCH pch);
#line 755
   BOOL   _System WinQueryClassInfo(HAB hab,
                                     PSZ pszClassName,
                                     PCLASSINFO pClassInfo);
#line 760
   HWND   _System WinQueryActiveWindow(HWND hwndDesktop);
#line 763
      BOOL   _System WinIsThreadActive(HAB hab);

   HWND   _System WinQuerySysModalWindow(HWND hwndDesktop);
#line 768
   BOOL   _System WinSetSysModalWindow(HWND hwndDesktop,
                                        HWND hwnd);
#line 773
      USHORT _System WinQueryWindowUShort(HWND hwnd,
                                           long index);
      BOOL   _System WinSetWindowUShort(HWND hwnd,
                                         long index,
                                         USHORT us);
      ULONG  _System WinQueryWindowULong(HWND hwnd,
                                          long index);
      BOOL   _System WinSetWindowULong(HWND hwnd,
                                        long index,
                                        ULONG ul);
      PVOID  _System WinQueryWindowPtr(HWND hwnd,
                                        long index);
      BOOL   _System WinSetWindowPtr(HWND hwnd,
                                      long index,
                                      PVOID p);
      BOOL   _System WinSetWindowBits(HWND hwnd,
                                       long index,
                                       ULONG flData,
                                       ULONG flMask);
#line 826
      typedef LHANDLE HENUM;   

      HENUM _System WinBeginEnumWindows(HWND hwnd);
      HWND  _System WinGetNextWindow(HENUM henum);
      BOOL  _System WinEndEnumWindows(HENUM henum);
#line 834
   HWND  _System WinWindowFromPoint(HWND hwnd,
                                     PPOINTL pptl,
                                     BOOL fChildren);

   BOOL  _System WinMapWindowPoints(HWND hwndFrom,
                                     HWND hwndTo,
                                     PPOINTL prgptl,
                                     long cwpt);
#line 846
   BOOL  _System WinValidateRect(HWND hwnd,
                                  PRECTL prcl,
                                  BOOL fIncludeChildren);

   BOOL  _System WinValidateRegion(HWND hwnd,
                                    HRGN hrgn,
                                    BOOL fIncludeChildren);
#line 855
      HWND  _System WinWindowFromDC(HDC hdc);

      HDC   _System WinQueryWindowDC(HWND hwnd);

      HPS   _System WinGetScreenPS(HWND hwndDesktop);

      BOOL  _System WinLockWindowUpdate(HWND hwndDesktop,
                                         HWND hwndLockUpdate);

      BOOL  _System WinLockVisRegions(HWND hwndDesktop,
                                       BOOL fLock);
#line 868
   BOOL  _System WinQueryUpdateRect(HWND hwnd,
                                     PRECTL prcl);

   long _System WinQueryUpdateRegion(HWND hwnd,
                                      HRGN hrgn);

   long _System WinExcludeUpdateRegion(HPS hps,
                                        HWND hwnd);
#line 882
   typedef struct _QMSG     
   {
      HWND    hwnd;
      ULONG   msg;
      MPARAM  mp1;
      MPARAM  mp2;
      ULONG   time;
      POINTL  ptl;
      ULONG   reserved;
   } QMSG;
   typedef QMSG *PQMSG;
#line 983
   #pragma pack(1)  
#line 989
   typedef struct _COMMANDMSG     
   {
      USHORT  cmd;               
      USHORT  unused;
      USHORT  source;            
      USHORT  fMouse;
   } CMDMSG;
   typedef CMDMSG *PCMDMSG;
#line 1001
   #pragma pack()   
#line 1004
   typedef struct _MQINFO     
   {
      ULONG   cb;
      PID     pid;
      TID     tid;
      ULONG   cmsgs;
      PVOID   pReserved;
   } MQINFO;
   typedef MQINFO *PMQINFO;

   MRESULT _System WinSendMsg(HWND hwnd,
                               ULONG msg,
                               MPARAM mp1,
                               MPARAM mp2);

   HMQ     _System WinCreateMsgQueue(HAB hab,
                                      long cmsg);

   BOOL    _System WinDestroyMsgQueue(HMQ hmq);

   BOOL    _System WinQueryQueueInfo(HMQ hmq,
                                      PMQINFO pmqi,
                                      ULONG cbCopy);
#line 1029
      BOOL    _System WinCancelShutdown(HMQ hmq,
                                         BOOL fCancelAlways);
#line 1033
   BOOL    _System WinGetMsg(HAB hab,
                              PQMSG pqmsg,
                              HWND hwndFilter,
                              ULONG msgFilterFirst,
                              ULONG msgFilterLast);

   BOOL    _System WinPeekMsg(HAB hab,
                               PQMSG pqmsg,
                               HWND hwndFilter,
                               ULONG msgFilterFirst,
                               ULONG msgFilterLast,
                               ULONG fl);

   MRESULT _System WinDispatchMsg(HAB hab,
                                   PQMSG pqmsg);

   BOOL    _System WinPostMsg(HWND hwnd,
                               ULONG msg,
                               MPARAM mp1,
                               MPARAM mp2);

   BOOL    _System WinRegisterUserMsg(HAB hab,
                                       ULONG msgid,
                                       long datatype1,
                                       long dir1,
                                       long datatype2,
                                       long dir2,
                                       long datatyper);

   BOOL    _System WinRegisterUserDatatype(HAB hab,
                                            long datatype,
                                            long count,
                                            PLONG types);
#line 1071
   BOOL    _System WinSetMsgMode(HAB hab,
                                  PSZ classname,
                                  long control);
#line 1076
   BOOL    _System WinSetSynchroMode(HAB hab,
                                      long mode);
#line 21 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmtypes.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 292
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 1120 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwin.h"
   typedef struct _WNDPARAMS     
   {
      ULONG   fsStatus;
      ULONG   cchText;
      PSZ     pszText;
      ULONG   cbPresParams;
      PVOID   pPresParams;
      ULONG   cbCtlData;
      PVOID   pCtlData;
   } WNDPARAMS;
   typedef WNDPARAMS *PWNDPARAMS;
#line 1140
      BOOL    _System WinInSendMsg(HAB hab);
#line 1143
   BOOL    _System WinBroadcastMsg(HWND hwnd,
                                    ULONG msg,
                                    MPARAM mp1,
                                    MPARAM mp2,
                                    ULONG rgf);
#line 1156
   BOOL  _System WinWaitMsg(HAB hab,
                             ULONG msgFirst,
                             ULONG msgLast);
#line 1161
      ULONG _System WinQueryQueueStatus(HWND hwndDesktop);
#line 1178
      BOOL  _System WinQueryMsgPos(HAB hab,
                                    PPOINTL pptl);

      ULONG _System WinQueryMsgTime(HAB hab);
#line 1192
      APIRET _System WinWaitEventSem(HEV hev,
                                      ULONG ulTimeout);

      APIRET _System WinRequestMutexSem(HMTX hmtx,
                                         ULONG ulTimeout);

      APIRET _System WinWaitMuxWaitSem(HMUX hmux,
                                        ULONG ulTimeout,
                                        PULONG pulUser);
#line 1205
   BOOL  _System WinPostQueueMsg(HMQ hmq,
                                  ULONG msg,
                                  MPARAM mp1,
                                  MPARAM mp2);
#line 1217
   BOOL  _System WinSetMsgInterest(HWND hwnd,
                                    ULONG msg_class,
                                    long control);
#line 1227
   BOOL  _System WinSetClassMsgInterest(HAB hab,
                                         PSZ pszClassName,
                                         ULONG msg_class,
                                         long control);
#line 1240
   BOOL  _System WinSetFocus(HWND hwndDesktop,
                              HWND hwndSetFocus);

   BOOL  _System WinFocusChange(HWND hwndDesktop,
                                 HWND hwndSetFocus,
                                 ULONG flFocusChange);

   BOOL  _System WinLockupSystem(HAB hab);

   BOOL  _System WinUnlockSystem(HAB hab, PSZ pszPassword);
#line 1275
BOOL _System WinSetVisibleRegionNotify( HWND hwnd,
                                        BOOL fEnable);

ULONG _System WinQueryVisibleRegion( HWND hwnd,
                                     HRGN hrgn);
#line 1284
      BOOL  _System WinSetCapture(HWND hwndDesktop,
                                   HWND hwnd);
#line 1288
   HWND  _System WinQueryCapture(HWND hwndDesktop);

   BOOL  _System WinCheckInput(HAB hab);
#line 1358
   HWND  _System WinQueryFocus(HWND hwndDesktop);
#line 1388
   #pragma pack(1)  
#line 1394
   typedef struct _MOUSEMSG     
   {
      short   x;              
      short   y;
      USHORT  codeHitTest;    
      USHORT  fsInp;          
   } MSEMSG;
   typedef MSEMSG *PMSEMSG;
#line 1406
   typedef struct _CHARMSG     
   {
      USHORT  fs;            
      UCHAR   cRepeat;
      UCHAR   scancode;
      USHORT  chr;           
      USHORT  vkey;
   } CHRMSG;
   typedef CHRMSG *PCHRMSG;
#line 1419
   #pragma pack()   
#line 1518
      long _System WinGetKeyState(HWND hwndDesktop,
                                   long vkey);
      long _System WinGetPhysKeyState(HWND hwndDesktop,
                                       long sc);
      BOOL  _System WinEnablePhysInput(HWND hwndDesktop,
                                        BOOL fEnable);
      BOOL  _System WinIsPhysInputEnabled(HWND hwndDesktop);
      BOOL  _System WinSetKeyboardStateTable(HWND hwndDesktop,
                                              PBYTE pKeyStateTable,
                                              BOOL fSet);
#line 1540
typedef LHANDLE HPOINTER;    
#line 1548
   BOOL    _System WinGetDlgMsg(HWND hwndDlg,
                                 PQMSG pqmsg);

   HWND    _System WinLoadDlg(HWND hwndParent,
                               HWND hwndOwner,
                               PFNWP pfnDlgProc,
                               HMODULE hmod,
                               ULONG idDlg,
                               PVOID pCreateParams);
   ULONG  _System WinDlgBox(HWND hwndParent,
                             HWND hwndOwner,
                             PFNWP pfnDlgProc,
                             HMODULE hmod,
                             ULONG idDlg,
                             PVOID pCreateParams);

   BOOL    _System WinDismissDlg(HWND hwndDlg,
                                  ULONG usResult);

   BOOL    _System WinQueryDlgItemShort(HWND hwndDlg,
                                         ULONG idItem,
                                         PSHORT pResult,
                                         BOOL fSigned);
   BOOL    _System WinSetDlgItemShort(HWND hwndDlg,
                                       ULONG idItem,
                                       USHORT usValue,
                                       BOOL fSigned);
#line 1580
   BOOL    _System WinSetDlgItemText(HWND hwndDlg,
                                      ULONG idItem,
                                      PSZ pszText);
#line 1590
   ULONG  _System WinQueryDlgItemText(HWND hwndDlg,
                                       ULONG idItem,
                                       long cchBufferMax,
                                       PSZ pchBuffer);

   long   _System WinQueryDlgItemTextLength(HWND hwndDlg,
                                             ULONG idItem);

   MRESULT _System WinDefDlgProc(HWND hwndDlg,
                                  ULONG msg,
                                  MPARAM mp1,
                                  MPARAM mp2);
#line 1611
   BOOL _System WinAlarm(HWND hwndDesktop,
                          ULONG rgfType);
#line 1630
   ULONG _System WinMessageBox(HWND hwndParent,
                                HWND hwndOwner,
                                PSZ pszText,
                                PSZ pszCaption,
                                ULONG idWindow,
                                ULONG flStyle);
#line 1644
   #pragma pack(4)

   typedef struct _MB2D
   {
      char   achText[70 + 1];  
      ULONG  idButton;                   

      long   flStyle;                    

   } MB2D;

   typedef MB2D * PMB2D;

   typedef struct _MB2INFO
   {
      ULONG    cb;                   
      HPOINTER hIcon;                
      ULONG    cButtons;             
      ULONG    flStyle;              
      HWND     hwndNotify;           
      MB2D     mb2d[1];              
   } MB2INFO;

   typedef MB2INFO * PMB2INFO;

   #pragma pack()
#line 1681
   ULONG  _System  WinMessageBox2(HWND     hwndParent,
   HWND     hwndOwner,
   PSZ      pszText,
   PSZ      pszCaption,
   ULONG    idWindow,
   PMB2INFO pmb2info);
#line 1798
   ULONG  _System WinProcessDlg(HWND hwndDlg);
   MRESULT _System WinSendDlgItemMsg(HWND hwndDlg,
                                      ULONG idItem,
                                      ULONG msg,
                                      MPARAM mp1,
                                      MPARAM mp2);
   BOOL    _System WinMapDlgPoints(HWND hwndDlg,
                                    PPOINTL prgwptl,
                                    ULONG cwpt,
                                    BOOL fCalcWindowCoords);
   HWND    _System WinEnumDlgItem(HWND hwndDlg,
                                   HWND hwnd,
                                   ULONG code);
#line 1817
   long   _System WinSubstituteStrings(HWND hwnd,
                                        PSZ pszSrc,
                                        long cchDstMax,
                                        PSZ pszDst);
#line 1839
   #pragma pack(2)  
#line 1854
   typedef struct _DLGTITEM     
   {
      USHORT  fsItemStatus;
      USHORT  cChildren;
      USHORT  cchClassName;
      USHORT  offClassName;
      USHORT  cchText;
      USHORT  offText;
      ULONG   flStyle;
      short   x;
      short   y;
      short   cx;
      short   cy;
      USHORT  id;
      USHORT  offPresParams;
      USHORT  offCtlData;
   } DLGTITEM;
   typedef DLGTITEM *PDLGTITEM;
#line 1879
   typedef struct _DLGTEMPLATE     
   {
      USHORT   cbTemplate;
      USHORT   type;
      USHORT   codepage;
      USHORT   offadlgti;
      USHORT   fsTemplateStatus;
      USHORT   iItemFocus;
      USHORT   coffPresParams;
      DLGTITEM adlgti[1];
   } DLGTEMPLATE;
   typedef DLGTEMPLATE *PDLGTEMPLATE;

   #pragma pack()   

   HWND   _System WinCreateDlg(HWND hwndParent,
                                HWND hwndOwner,
                                PFNWP pfnDlgProc,
                                PDLGTEMPLATE pdlgt,
                                PVOID pCreateParams);
#line 1979
      #pragma pack(2)  
#line 1985
      typedef struct _BTNCDATA     
      {
         USHORT  cb;
         USHORT  fsCheckState;
         USHORT  fsHiliteState;
         LHANDLE hImage;
      } BTNCDATA;
      typedef BTNCDATA *PBTNCDATA;

      #pragma pack()   
#line 2001
      typedef struct _USERBUTTON     
      {
         HWND    hwnd;
         HPS     hps;
         ULONG   fsState;
         ULONG   fsStateOld;
      } USERBUTTON;
      typedef USERBUTTON *PUSERBUTTON;
#line 2108
      #pragma pack(2)  
#line 2118
      typedef struct _COMBOCDATA           
      {
         ULONG   cbSize;              
         ULONG   reserved;            
         PVOID   pHWXCtlData;         
      } COMBOCDATA;
      typedef COMBOCDATA *PCOMBOCDATA;

      typedef struct _ENTRYFDATA     
      {
         USHORT  cb;
         USHORT  cchEditLimit;
         USHORT  ichMinSel;
         USHORT  ichMaxSel;
         PVOID   pHWXCtlData;     
      } ENTRYFDATA;
      typedef ENTRYFDATA *PENTRYFDATA;

      #pragma pack()   
#line 29 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmmle.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 57
   typedef long    IPT;         
   typedef PLONG   PIPT;        
   typedef long    PIX;         
   typedef ULONG   LINE;        

   typedef struct _FORMATRECT     
   {
      long cxFormat;            
      long cyFormat;            
   } MLEFORMATRECT;
   typedef MLEFORMATRECT *PFORMATRECT;

   typedef struct _MLECTLDATA     
   {
      USHORT   cbCtlData;       
      USHORT   afIEFormat;      
      ULONG    cchText;         
      IPT      iptAnchor;       
      IPT      iptCursor;       
      long     cxFormat;        
      long     cyFormat;        
      ULONG    afFormatFlags;   
      PVOID    pHWXCtlData;     
   } MLECTLDATA;
   typedef MLECTLDATA *PMLECTLDATA;
#line 102
   typedef struct _MLEOVERFLOW     
   {
      ULONG afErrInd;             
      long nBytesOver;            
      long pixHorzOver;           
      long pixVertOver;           
   }  MLEOVERFLOW;
   typedef MLEOVERFLOW *POVERFLOW;
#line 124
   typedef struct _MLEMARGSTRUCT     
   {
      USHORT afMargins;       
      USHORT usMouMsg;        
      IPT    iptNear;         
   } MLEMARGSTRUCT;
   typedef MLEMARGSTRUCT *PMARGSTRUCT;
#line 158
   typedef struct _SEARCH     
   {
      USHORT cb;             
      PCHAR  pchFind;        
      PCHAR  pchReplace;     
      short  cchFind;        
      short  cchReplace;     
      IPT    iptStart;       
#line 168
      IPT    iptStop;        

      USHORT cchFound;       
   } MLE_SEARCHDATA;
   typedef MLE_SEARCHDATA *PMLE_SEARCHDATA;
#line 274
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 2254 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwin.h"
   typedef struct _LBOXINFO          
   {
      long  lItemIndex;             
      ULONG ulItemCount;            
      ULONG reserved;               
      ULONG reserved2;              
   } LBOXINFO;

   typedef LBOXINFO * PLBOXINFO;
#line 2344
   HWND _System WinLoadMenu(HWND hwndFrame,
                             HMODULE hmod,
                             ULONG idMenu);
#line 2378
      typedef struct _mti      
      {
         USHORT afStyle;       
         USHORT pad;           
         USHORT idItem;        
         char   c[2];          
      } MTI;

      typedef struct _mt       
      {
         ULONG  len;           
         USHORT codepage;      
         USHORT reserved;      
         USHORT cMti;          
         MTI    rgMti[1];      
      } MT;
      typedef MT *LPMT;
#line 2398
   HWND _System WinCreateMenu(HWND hwndParent,
                               PVOID lpmt);
#line 2404
      typedef struct _OWNERITEM     
      {
         HWND    hwnd;
         HPS     hps;
         ULONG   fsState;
         ULONG   fsAttribute;
         ULONG   fsStateOld;
         ULONG   fsAttributeOld;
         RECTL   rclItem;
         long    idItem;  
         ULONG   hItem;
      } OWNERITEM;
      typedef OWNERITEM *POWNERITEM;
#line 2421
   #pragma pack(2)  
#line 2427
   typedef struct _MENUITEM     
   {
      short   iPosition;
      USHORT  afStyle;
      USHORT  afAttribute;
      USHORT  id;
      HWND    hwndSubMenu;
      ULONG   hItem;
   } MENUITEM;
   typedef MENUITEM *PMENUITEM;

   #pragma pack()   
#line 2482
   BOOL _System WinPopupMenu(HWND hwndParent,
                              HWND hwndOwner,
                              HWND hwndMenu,
                              long x,
                              long y,
                              long idItem,
                              ULONG fs);
#line 2610
      #pragma pack(2)  
#line 2616
      typedef struct _SBCDATA     
      {
         USHORT  cb;
         USHORT  sHilite;       
         short   posFirst;
         short   posLast;
         short   posThumb;
         short   cVisible;
         short   cTotal;
      } SBCDATA;
      typedef SBCDATA *PSBCDATA;

      #pragma pack()   
#line 2637
   #pragma pack(2)  
#line 2643
   typedef struct _FRAMECDATA     
   {
      USHORT  cb;
      ULONG   flCreateFlags;
      USHORT  hmodResources;
      USHORT  idResources;
   } FRAMECDATA;
   typedef FRAMECDATA *PFRAMECDATA;

   #pragma pack()   
#line 2740
   HWND  _System WinCreateStdWindow(HWND hwndParent,
                                     ULONG flStyle,
                                     PULONG pflCreateFlags,
                                     PSZ pszClientClass,
                                     PSZ pszTitle,
                                     ULONG styleClient,
                                     HMODULE hmod,
                                     ULONG idResources,
                                     PHWND phwndClient);
#line 2757
   BOOL  _System WinFlashWindow(HWND hwndFrame,
                                 BOOL fFlash);
#line 2811
   BOOL  _System WinCreateFrameControls(HWND hwndFrame,
                                         PFRAMECDATA pfcdata,
                                         PSZ pszTitle);
#line 2816
   BOOL  _System WinCalcFrameRect(HWND hwndFrame,
                                   PRECTL prcl,
                                   BOOL fClient);

   BOOL  _System WinGetMinPosition(HWND hwnd,
                                    PSWP pswp,
                                    PPOINTL pptl);

      BOOL  _System WinGetMaxPosition(HWND hwnd,
                                       PSWP pswp);
#line 2828
   typedef LHANDLE HSAVEWP;       

   BOOL _System WinSaveWindowPos(HSAVEWP hsvwp,
                                  PSWP pswp,
                                  ULONG cswp);
#line 2907
   BOOL _System WinCopyRect(HAB hab,
                             PRECTL prclDst,
                             PRECTL prclSrc);
#line 2912
      BOOL _System WinSetRect(HAB hab,
                               PRECTL prcl,
                               long xLeft,
                               long yBottom,
                               long xRight,
                               long yTop);
      BOOL _System WinIsRectEmpty(HAB hab,
                                   PRECTL prcl);
      BOOL _System WinEqualRect(HAB hab,
                                 PRECTL prcl1,
                                 PRECTL prcl2);
      BOOL _System WinSetRectEmpty(HAB hab,
                                    PRECTL prcl);
      BOOL _System WinOffsetRect(HAB hab,
                                  PRECTL prcl,
                                  long cx,
                                  long cy);
      BOOL _System WinInflateRect(HAB hab,
                                   PRECTL prcl,
                                   long cx,
                                   long cy);
      BOOL _System WinPtInRect(HAB hab,
                                PRECTL prcl,
                                PPOINTL pptl);
      BOOL _System WinIntersectRect(HAB hab,
                                     PRECTL prclDst,
                                     PRECTL prclSrc1,
                                     PRECTL prclSrc2);
      BOOL _System WinUnionRect(HAB hab,
                                 PRECTL prclDst,
                                 PRECTL prclSrc1,
                                 PRECTL prclSrc2);
      BOOL _System WinSubtractRect(HAB hab,
                                    PRECTL prclDst,
                                    PRECTL prclSrc1,
                                    PRECTL prclSrc2);
      BOOL _System WinMakeRect(HAB hab,
                                PRECTL pwrc);
      BOOL _System WinMakePoints(HAB hab,
                                  PPOINTL pwpt,
                                  ULONG cwpt);
#line 2962
   long _System WinQuerySysValue(HWND hwndDesktop,
                                  long iSysValue);
   BOOL  _System WinSetSysValue(HWND hwndDesktop,
                                 long iSysValue,
                                 long lValue);
#line 3102
   typedef struct _PARAM     
   {
      ULONG   id;
      ULONG   cb;
      BYTE    ab[1];
   } PARAM;
   typedef PARAM *NPPARAM;
   typedef PARAM *PPARAM;

   typedef struct _PRESPARAMS     
   {
      ULONG   cb;
      PARAM   aparam[1];
   } PRESPARAMS;
   typedef PRESPARAMS *NPPRESPARAMS;
   typedef PRESPARAMS *PPRESPARAMS;
#line 3122
   BOOL  _System WinSetPresParam(HWND hwnd,
                                  ULONG id,
                                  ULONG cbParam,
                                  PVOID pbParam);
   ULONG _System WinQueryPresParam(HWND hwnd,
                                    ULONG id1,
                                    ULONG id2,
                                    PULONG pulId,
                                    ULONG cbBuf,
                                    PVOID pbBuf,
                                    ULONG fs);
   BOOL  _System WinRemovePresParam(HWND hwnd,
                                     ULONG id);
#line 3210
   long _System WinQuerySysColor(HWND hwndDesktop,
                                  long clr,
                                  long lReserved);
   BOOL _System WinSetSysColors(HWND hwndDesktop,
                                 ULONG flOptions,
                                 ULONG flFormat,
                                 long clrFirst,
                                 ULONG cclr,
                                 PLONG pclr);
#line 3273
      ULONG _System WinStartTimer(HAB hab,
                                   HWND hwnd,
                                   ULONG idTimer,
                                   ULONG dtTimeout);
      BOOL   _System WinStopTimer(HAB hab,
                                   HWND hwnd,
                                   ULONG idTimer);
#line 3282
      ULONG  _System WinGetCurrentTime(HAB hab);
#line 3292
typedef LHANDLE HACCEL;  
#line 3314
   #pragma pack(2)  
#line 3320
   typedef struct _ACCEL     
   {
      USHORT  fs;
      USHORT  key;
      USHORT  cmd;
   } ACCEL;
   typedef ACCEL *PACCEL;
#line 3332
   typedef struct _ACCELTABLE     
   {
      USHORT  cAccel;
      USHORT  codepage;
      ACCEL   aaccel[1];
   } ACCELTABLE;
   typedef ACCELTABLE *PACCELTABLE;

   #pragma pack()   

   HACCEL _System WinLoadAccelTable(HAB hab,
                                     HMODULE hmod,
                                     ULONG idAccelTable);
   ULONG _System WinCopyAccelTable(HACCEL haccel,
                                    PACCELTABLE pAccelTable,
                                    ULONG cbCopyMax);
   HACCEL _System WinCreateAccelTable(HAB hab,
                                       PACCELTABLE pAccelTable);
   BOOL   _System WinDestroyAccelTable(HACCEL haccel);
   BOOL   _System WinTranslateAccel(HAB hab,
                                     HWND hwnd,
                                     HACCEL haccel,
                                     PQMSG pqmsg);
   BOOL   _System WinSetAccelTable(HAB hab,
                                    HACCEL haccel,
                                    HWND hwndFrame);
   HACCEL _System WinQueryAccelTable(HAB hab,
                                      HWND hwndFrame);
#line 3375
   typedef struct _TRACKINFO     
   {
      long    cxBorder;
      long    cyBorder;
      long    cxGrid;
      long    cyGrid;
      long    cxKeyboard;
      long    cyKeyboard;
      RECTL   rclTrack;
      RECTL   rclBoundary;
      POINTL  ptlMinTrackSize;
      POINTL  ptlMaxTrackSize;
      ULONG   fs;
   } TRACKINFO;
   typedef TRACKINFO *PTRACKINFO;
#line 3392
      BOOL _System WinTrackRect(HWND hwnd,
                                 HPS hps,
                                 PTRACKINFO pti);
      BOOL _System WinShowTrackRect(HWND hwnd,
                                     BOOL fShow);
#line 3470
      #pragma pack(2)  
#line 3476
      typedef struct _MFP     
      {
         POINTL sizeBounds;   
         POINTL sizeMM;       
         ULONG  cbLength;     
         USHORT mapMode;      
         USHORT reserved;
         BYTE   abData[1];    
      } MFP;
      typedef MFP *PMFP;
#line 3491
      typedef struct _CPTEXT     
      {
         USHORT idCountry;
         USHORT usCodepage;
         USHORT usLangID;
         USHORT usSubLangID;
         BYTE   abText[1];    
      } CPTEXT;
      typedef CPTEXT *PCPTEXT;

      #pragma pack()   
#line 3508
      BOOL   _System WinSetClipbrdOwner(HAB hab,
                                         HWND hwnd);
      BOOL   _System WinSetClipbrdData(HAB hab,
                                        ULONG ulData,
                                        ULONG fmt,
                                        ULONG rgfFmtInfo);
      ULONG  _System WinQueryClipbrdData(HAB hab,
                                          ULONG fmt);
      BOOL   _System WinQueryClipbrdFmtInfo(HAB hab,
                                             ULONG fmt,
                                             PULONG prgfFmtInfo);
      BOOL   _System WinSetClipbrdViewer(HAB hab,
                                          HWND hwndNewClipViewer);
#line 3531
   ULONG _System WinEnumClipbrdFmts(HAB hab,
                                     ULONG fmt);
   BOOL   _System WinEmptyClipbrd(HAB hab);
   BOOL   _System WinOpenClipbrd(HAB hab);
   BOOL   _System WinCloseClipbrd(HAB hab);

   HWND   _System WinQueryClipbrdOwner(HAB hab);
   HWND   _System WinQueryClipbrdViewer(HAB hab);
#line 3546
   BOOL _System WinDestroyCursor(HWND hwnd);
   BOOL _System WinShowCursor(HWND hwnd,
                               BOOL fShow);
   BOOL _System WinCreateCursor(HWND hwnd,
                                 long x,
                                 long y,
                                 long cx,
                                 long cy,
                                 ULONG fs,
                                 PRECTL prclClip);
#line 3576
   typedef struct _CURSORINFO     
   {
      HWND    hwnd;
      long    x;
      long    y;
      long    cx;
      long    cy;
      ULONG   fs;
      RECTL   rclClip;
   } CURSORINFO;
   typedef CURSORINFO *PCURSORINFO;

   BOOL _System WinQueryCursorInfo(HWND hwndDesktop,
                                    PCURSORINFO pCursorInfo);
#line 3597
   BOOL     _System WinSetPointer(HWND hwndDesktop,
                                   HPOINTER hptrNew);
   BOOL     _System WinSetPointerOwner(HPOINTER hptr,
                                        PID pid,
                                        BOOL fDestroy);
   BOOL     _System WinShowPointer(HWND hwndDesktop,
                                    BOOL fShow);
   BOOL     _System WinLockPointerUpdate(HWND hwndDesktop,
                                          HPOINTER hptrNew,
                                          ULONG ulTimeInterval);
   HPOINTER _System WinQuerySysPointer(HWND hwndDesktop,
                                        long iptr,
                                        BOOL fLoad);

   BOOL _System WinQuerySysPointerData(HWND hwndDesktop,
                                        ULONG iptr,
                                        PICONINFO pIconInfo);
   BOOL _System WinSetSysPointerData(HWND hwndDesktop,
                                      ULONG iptr,
                                      PICONINFO pIconInfo);
#line 3653
   HPOINTER _System WinLoadPointer(HWND hwndDesktop,
                                    HMODULE hmod,
                                    ULONG idres);
   HPOINTER _System WinCreatePointer(HWND hwndDesktop,
                                      HBITMAP hbmPointer,
                                      BOOL fPointer,
                                      long xHotspot,
                                      long yHotspot);
   BOOL     _System WinSetPointerPos(HWND hwndDesktop,
                                      long x,
                                      long y);
   BOOL     _System WinDestroyPointer(HPOINTER hptr);

   HPOINTER _System WinQueryPointer(HWND hwndDesktop);
   BOOL     _System WinQueryPointerPos(HWND hwndDesktop,
                                        PPOINTL pptl);

   typedef struct _POINTERINFO     
   {
      ULONG   fPointer;
      long    xHotspot;
      long    yHotspot;
      HBITMAP hbmPointer;
      HBITMAP hbmColor;
      HBITMAP hbmMiniPointer;
      HBITMAP hbmMiniColor;
   } POINTERINFO;
   typedef POINTERINFO *PPOINTERINFO;

   HPOINTER _System WinCreatePointerIndirect(HWND hwndDesktop,
                                              PPOINTERINFO pptri);
   BOOL     _System WinQueryPointerInfo(HPOINTER hptr,
                                         PPOINTERINFO pPointerInfo);
   BOOL     _System WinDrawPointer(HPS hps,
                                    long x,
                                    long y,
                                    HPOINTER hptr,
                                    ULONG fs);
#line 3702
   HBITMAP _System WinGetSysBitmap(HWND hwndDesktop,
                                    ULONG ibm);
#line 3761
      BOOL _System WinSetHook(HAB hab,
                               HMQ hmq,
                               long iHook,
                               PFN pfnHook,
                               HMODULE hmod);
      BOOL _System WinReleaseHook(HAB hab,
                                   HMQ hmq,
                                   long iHook,
                                   PFN pfnHook,
                                   HMODULE hmod);
      BOOL _System WinCallMsgFilter(HAB hab,
                                     PQMSG pqmsg,
                                     ULONG msgf);
#line 3911
      typedef struct _SMHSTRUCT       
      {
         MPARAM mp2;
         MPARAM mp1;
         ULONG  msg;
         HWND   hwnd;
         ULONG  model;
      } SMHSTRUCT;
      typedef SMHSTRUCT *PSMHSTRUCT;
#line 3951
   BOOL    _System WinSetClassThunkProc(PSZ pszClassname,
                                         PFN pfnThunkProc);
#line 3957
   PFN     _System WinQueryClassThunkProc(PSZ pszClassname);

   BOOL    _System WinSetWindowThunkProc(HWND hwnd,
                                          PFN pfnThunkProc);
   PFN     _System WinQueryWindowThunkProc(HWND hwnd);
   long   _System WinQueryWindowModel(HWND hwnd);
#line 31 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmshl.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 60
   typedef LHANDLE HPROGRAM;        
   typedef HPROGRAM *PHPROGRAM;
   typedef LHANDLE HAPP;
#line 66
   typedef LHANDLE HINI;            
   typedef HINI *PHINI;
#line 77
   typedef struct _PRFPROFILE     
   {
      ULONG  cchUserName;
      PSZ    pszUserName;
      ULONG  cchSysName;
      PSZ    pszSysName;
   } PRFPROFILE;
   typedef PRFPROFILE *PPRFPROFILE;
#line 98
      typedef struct _HPROGARRAY        
      {
         HPROGRAM ahprog[1];
      } HPROGARRAY;
      typedef HPROGARRAY *PHPROGARRAY;
#line 106
   typedef ULONG PROGCATEGORY;        

   typedef PROGCATEGORY *PPROGCATEGORY;
#line 140
      typedef struct _PROGTYPE          
      {
         PROGCATEGORY progc;
         ULONG        fbVisible;
      } PROGTYPE;
      typedef PROGTYPE *PPROGTYPE;
#line 160
      typedef struct _PROGDETAILS     
      {
         ULONG     Length;          
         PROGTYPE  progt;
         PSZ       pszTitle;        
         PSZ       pszExecutable;
         PSZ       pszParameters;
         PSZ       pszStartupDir;
         PSZ       pszIcon;
         PSZ       pszEnvironment;  
         SWP       swpInitial;      
      } PROGDETAILS;
      typedef  PROGDETAILS *PPROGDETAILS;

      typedef struct _PROGTITLE              
      {
         HPROGRAM hprog;
         PROGTYPE progt;
         PSZ      pszTitle;
      } PROGTITLE;
      typedef PROGTITLE *PPROGTITLE;
#line 187
      ULONG _System PrfQueryProgramTitles(HINI hini,
                                           HPROGRAM hprogGroup,
                                           PPROGTITLE pTitles,
                                           ULONG cchBufferMax,
                                           PULONG pulCount);
#line 212
      HPROGRAM _System PrfAddProgram(HINI hini,
                                      PPROGDETAILS pDetails,
                                      HPROGRAM hprogGroup);

      BOOL     _System PrfChangeProgram(HINI hini,
                                         HPROGRAM hprog,
                                         PPROGDETAILS pDetails);

      ULONG    _System PrfQueryDefinition(HINI hini,
                                           HPROGRAM hprog,
                                           PPROGDETAILS pDetails,
                                           ULONG cchBufferMax);
#line 243
      BOOL     _System PrfRemoveProgram(HINI hini,
                                         HPROGRAM hprog);
#line 253
      ULONG    _System PrfQueryProgramHandle(HINI hini,
                                              PSZ pszExe,
                                              PHPROGARRAY phprogArray,
                                              ULONG cchBufferMax,
                                              PULONG pulCount);
#line 265
      HPROGRAM _System PrfCreateGroup(HINI hini,
                                       PSZ pszTitle,
                                       UCHAR chVisibility);
#line 270
      BOOL     _System PrfDestroyGroup(HINI hini,
                                        HPROGRAM hprogGroup);
#line 277
      PROGCATEGORY  _System PrfQueryProgramCategory(HINI hini,
                                                     PSZ pszExe);
#line 288
      HAPP _System WinStartApp(HWND hwndNotify,
                                PPROGDETAILS pDetails,
                                PSZ pszParams,
                                PVOID Reserved,
                                ULONG fbOptions);
#line 305
      BOOL _System WinTerminateApp(HAPP happ);
#line 313
typedef LHANDLE HSWITCH;         
typedef HSWITCH *PHSWITCH;
#line 319
      typedef struct _SWCNTRL           
      {
         HWND     hwnd;
         HWND     hwndIcon;
         HPROGRAM hprog;
         PID      idProcess;
         ULONG    idSession;
         ULONG    uchVisibility;
         ULONG    fbJump;
         char     szSwtitle[60+4];
         ULONG    bProgType;
      } SWCNTRL;

      typedef SWCNTRL *PSWCNTRL;
#line 345
      HSWITCH _System WinAddSwitchEntry(PSWCNTRL);
      ULONG   _System WinRemoveSwitchEntry(HSWITCH);
#line 352
      typedef struct _SWENTRY           
      {
         HSWITCH hswitch;
         SWCNTRL swctl;
      } SWENTRY;
      typedef SWENTRY *PSWENTRY;

      typedef struct _SWBLOCK           
      {
         ULONG    cswentry;
         SWENTRY aswentry[1];
      } SWBLOCK;
      typedef SWBLOCK *PSWBLOCK;
#line 368
      ULONG   _System WinChangeSwitchEntry(HSWITCH hswitchSwitch,
                                            PSWCNTRL pswctlSwitchData);

      HSWITCH  _System WinCreateSwitchEntry(HAB hab,
                                             PSWCNTRL pswctlSwitchData);
#line 380
      ULONG   _System WinQuerySessionTitle(HAB hab,
                                            ULONG usSession,
                                            PSZ pszTitle,
                                            ULONG usTitlelen);
#line 386
      ULONG   _System WinQuerySwitchEntry(HSWITCH hswitchSwitch,
                                           PSWCNTRL pswctlSwitchData);

      HSWITCH  _System WinQuerySwitchHandle(HWND hwnd,
                                             PID pidProcess);
      ULONG   _System WinQuerySwitchList(HAB hab,
                                          PSWBLOCK pswblkSwitchEntries,
                                          ULONG usDataLength);

      ULONG   _System WinQueryTaskSizePos(HAB hab,
                                           ULONG usScreenGroup,
                                           PSWP pswpPositionData);
#line 404
      ULONG   _System WinQueryTaskTitle(ULONG usSession,
                                         PSZ pszTitle,
                                         ULONG usTitlelen);
#line 409
      ULONG   _System WinSwitchToProgram(HSWITCH hswitchSwHandle);
#line 424
      long   _System PrfQueryProfileInt(HINI hini,
                                         PSZ pszApp,
                                         PSZ pszKey,
                                         long  sDefault);
#line 438
      ULONG  _System PrfQueryProfileString(HINI hini,
                                            PSZ pszApp,
                                            PSZ pszKey,
                                            PSZ pszDefault,
                                            PVOID pBuffer,
                                            ULONG cchBufferMax);
#line 452
      BOOL   _System PrfWriteProfileString(HINI hini,
                                            PSZ pszApp,
                                            PSZ pszKey,
                                            PSZ pszData);
#line 464
      BOOL   _System PrfQueryProfileSize(HINI hini,
                                          PSZ pszApp,
                                          PSZ pszKey,
                                          PULONG pulReqLen);
#line 477
      BOOL   _System PrfQueryProfileData(HINI hini,
                                          PSZ pszApp,
                                          PSZ pszKey,
                                          PVOID pBuffer,
                                          PULONG pulBuffLen);
#line 491
      BOOL   _System PrfWriteProfileData(HINI hini,
                                          PSZ pszApp,
                                          PSZ pszKey,
                                          PVOID pData,
                                          ULONG cchDataLen);
#line 502
      HINI   _System PrfOpenProfile(HAB hab,
                                     PSZ pszFileName);
#line 506
      BOOL   _System PrfCloseProfile(HINI hini);

      BOOL   _System PrfReset(HAB hab,
                               PPRFPROFILE pPrfProfile);

      BOOL   _System PrfQueryProfile(HAB hab,
                                      PPRFPROFILE pPrfProfile);
#line 530
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 3975 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwin.h"
   ULONG  _System WinQueryCp(HMQ hmq);
#line 3978
      BOOL    _System WinSetCp(HMQ hmq,
                                ULONG idCodePage);

      ULONG  _System WinQueryCpList(HAB hab,
                                     ULONG ccpMax,
                                     PULONG prgcp);
#line 3993
      BOOL    _System WinCpTranslateString(HAB hab,
                                            ULONG cpSrc,
                                            PSZ pszSrc,
                                            ULONG cpDst,
                                            ULONG cchDestMax,
                                            PSZ pchDest);
#line 4001
      UCHAR   _System WinCpTranslateChar(HAB hab,
                                          ULONG cpSrc,
                                          UCHAR chSrc,
                                          ULONG cpDst);
#line 4012
      ULONG  _System WinUpper(HAB hab,
                               ULONG idcp,
                               ULONG idcc,
                               PSZ psz);
#line 4018
      ULONG  _System WinUpperChar(HAB hab,
                                   ULONG idcp,
                                   ULONG idcc,
                                   ULONG c);
#line 4029
      PSZ     _System WinNextChar(HAB hab,
                                   ULONG idcp,
                                   ULONG idcc,
                                   PSZ psz);
#line 4042
      PSZ     _System WinPrevChar(HAB hab,
                                   ULONG idcp,
                                   ULONG idcc,
                                   PSZ pszStart,
                                   PSZ psz);
#line 4057
      ULONG  _System WinCompareStrings(HAB hab,
                                        ULONG idcp,
                                        ULONG idcc,
                                        PSZ psz1,
                                        PSZ psz2,
                                        ULONG reserved);
#line 4089
      typedef LHANDLE  HATOMTBL;
      typedef ULONG   ATOM;

      HATOMTBL _System WinQuerySystemAtomTable(void);
      HATOMTBL _System WinCreateAtomTable(ULONG cbInitial,
                                           ULONG cBuckets);
      HATOMTBL _System WinDestroyAtomTable(HATOMTBL hAtomTbl);
#line 4100
      ATOM     _System WinAddAtom(HATOMTBL hAtomTbl,
                                   PSZ pszAtomName);
#line 4107
      ATOM     _System WinFindAtom(HATOMTBL hAtomTbl,
                                    PSZ pszAtomName);

      ATOM     _System WinDeleteAtom(HATOMTBL hAtomTbl,
                                      ATOM atom);
      ULONG   _System WinQueryAtomUsage(HATOMTBL hAtomTbl,
                                         ATOM atom);
      ULONG   _System WinQueryAtomLength(HATOMTBL hAtomTbl,
                                          ATOM atom);
#line 4122
      ULONG   _System WinQueryAtomName(HATOMTBL hAtomTbl,
                                        ATOM atom,
                                        PSZ pchBuffer,
                                        ULONG cchBufferMax);
#line 24 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmerr.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 901
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 4162 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwin.h"
   typedef struct _ERRINFO     
   {
      ULONG   cbFixedErrInfo;
      ERRORID idError;
      ULONG   cDetailLevel;
      ULONG   offaoffszMsg;
      ULONG   offBinaryData;
   } ERRINFO;
   typedef ERRINFO *PERRINFO;

   ERRORID     _System    WinGetLastError(HAB hab);
   PERRINFO    _System    WinGetErrorInfo(HAB hab);
   BOOL        _System    WinFreeErrorInfo(PERRINFO perrinfo);
#line 25 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmsei.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 38
ERRORID _System WinSetErrorInfo(ERRORID,
                                 ULONG,
                                 ...);
#line 71
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 4209 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwin.h"
      typedef struct _CONVCONTEXT     
      {
         ULONG  cb;           
         ULONG fsContext;
         ULONG idCountry;
         ULONG usCodepage;
         ULONG usLangID;
         ULONG usSubLangID;
      } CONVCONTEXT;
      typedef CONVCONTEXT *PCONVCONTEXT;
#line 4222
      typedef struct _DDEINIT     
      {
         ULONG   cb;          
         PSZ     pszAppName;
         PSZ     pszTopic;
         ULONG   offConvContext;
      } DDEINIT;
      typedef DDEINIT *PDDEINIT;

      typedef struct _DDESTRUCT     
      {
         ULONG   cbData;
         USHORT  fsStatus;
         USHORT  usFormat;
         USHORT  offszItemName;
         USHORT  offabData;
      } DDESTRUCT;
      typedef DDESTRUCT *PDDESTRUCT;
#line 4263
      BOOL    _System WinDdeInitiate(HWND hwndClient,
                                      PSZ pszAppName,
                                      PSZ pszTopicName,
                                      PCONVCONTEXT pcctxt);
#line 4276
      MRESULT _System WinDdeRespond(HWND hwndClient,
                                     HWND hwndServer,
                                     PSZ pszAppName,
                                     PSZ pszTopicName,
                                     PCONVCONTEXT pcctxt);
#line 4283
      BOOL    _System WinDdePostMsg(HWND hwndTo,
                                     HWND hwndFrom,
                                     ULONG wm,
                                     PDDESTRUCT pddest,
                                     ULONG flOptions);
#line 31 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmhelp.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 52
   typedef USHORT HELPSUBTABLE;
   typedef HELPSUBTABLE *PHELPSUBTABLE;
#line 64
   #pragma pack(2)    
#line 67
   typedef struct _HELPTABLE        
   {
      USHORT          idAppWindow;
      PHELPSUBTABLE   phstHelpSubTable;
      USHORT          idExtPanel;
   } HELPTABLE;
   typedef HELPTABLE *PHELPTABLE;
#line 76
   #pragma pack()     
#line 85
   typedef struct _HELPINIT       
   {
      ULONG        cb;
      ULONG        ulReturnCode;
      PSZ          pszTutorialName;
      PHELPTABLE   phtHelpTable;
      HMODULE      hmodHelpTableModule;
      HMODULE      hmodAccelActionBarModule;
      ULONG        idAccelTable;
      ULONG        idActionBar;
      PSZ          pszHelpWindowTitle;
      ULONG        fShowPanelId;
      PSZ          pszHelpLibraryName;
   } HELPINIT;
   typedef HELPINIT *PHELPINIT;
#line 128
   BOOL _System  WinDestroyHelpInstance(HWND hwndHelpInstance);

   HWND _System  WinCreateHelpInstance(HAB hab,
                                        PHELPINIT phinitHMInitStructure);

   BOOL _System  WinAssociateHelpInstance(HWND hwndHelpInstance,
                                           HWND hwndApp);

   HWND _System  WinQueryHelpInstance(HWND hwndApp);

   BOOL _System  WinLoadHelpTable(HWND hwndHelpInstance,
                                   ULONG idHelpTable,
                                   HMODULE Module);

   BOOL _System  WinCreateHelpTable(HWND hwndHelpInstance,
                                     PHELPTABLE phtHelpTable);
#line 372
   typedef struct _ACVP         
   {
      ULONG  cb;
      HAB    hAB;
      HMQ    hmq;
      ULONG  ObjectID;             
      HWND   hWndParent;           
      HWND   hWndOwner;            
      HWND   hWndACVP;             
   } ACVP, *PACVP;
#line 541
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 4337 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwin.h"
typedef HMODULE HLIB;
typedef PHMODULE PHLIB;
#line 4341
   BOOL    _System WinDeleteProcedure(HAB hab,
                                       PFNWP wndproc);
   BOOL    _System WinDeleteLibrary(HAB hab,
                                     HLIB libhandle);
#line 4350
   PFNWP   _System WinLoadProcedure(HAB hab,
                                     HLIB libhandle,
                                     PSZ procname);
#line 4358
   HLIB    _System WinLoadLibrary(HAB hab,
                                   PSZ libname);
#line 4368
      typedef struct _DESKTOP           
      {
         ULONG    cbSize;
         HBITMAP  hbm;
         long     x;
         long     y;
         ULONG    fl;
         long     lTileCount;
         char     szFile[260];
      } DESKTOP;
      typedef DESKTOP *PDESKTOP;   

      HBITMAP _System WinSetDesktopBkgnd(HWND hwndDesktop,
                                          PDESKTOP pdskNew);
      BOOL    _System WinQueryDesktopBkgnd(HWND hwndDesktop,
                                            PDESKTOP pdsk);
#line 4402
      long _System WinRealizePalette(HWND hwnd,
                                      HPS hps,
                                      PULONG pcclr);
#line 4426
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 52 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmgpi.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 125
typedef  long FIXED;      
typedef  FIXED *PFIXED;
#line 129
typedef  USHORT FIXED88;   
#line 135
typedef  USHORT FIXED114;  
#line 145
typedef struct _SIZEL             
{
   long cx;
   long cy;
} SIZEL;
typedef SIZEL *PSIZEL;
#line 192
   HPS   _System GpiCreatePS(HAB hab,
                              HDC hdc,
                              PSIZEL psizlSize,
                              ULONG flOptions);

   BOOL  _System GpiDestroyPS(HPS hps);

   BOOL  _System GpiAssociate(HPS hps,
                               HDC hdc);

   BOOL  _System GpiRestorePS(HPS hps,
                               long lPSid);

   long  _System GpiSavePS(HPS hps);

   BOOL  _System GpiErase(HPS hps);
#line 211
      HDC  _System GpiQueryDevice(HPS);
#line 998
      BOOL  _System GpiSetColor(HPS hps,
                                 long lColor);

      long  _System GpiQueryColor(HPS hps);
#line 1005
      long  _System GpiBox(HPS hps,
                            long lControl,
                            PPOINTL pptlPoint,
                            long lHRound,
                            long lVRound);

      BOOL  _System GpiMove(HPS hps,
                             PPOINTL pptlPoint);

      long  _System GpiLine(HPS hps,
                             PPOINTL pptlEndPoint);

      long  _System GpiPolyLine(HPS hps,
                                 long lCount,
                                 PPOINTL aptlPoints);

      long  _System GpiPolyLineDisjoint(HPS hps,
                                         long lCount,
                                         PPOINTL aptlPoints);
#line 1026
      BOOL  _System GpiSetPattern(HPS hps,
                                   long lPatternSymbol);

      long  _System GpiQueryPattern(HPS hps);

      BOOL  _System GpiBeginArea(HPS hps,
                                  ULONG flOptions);

      long  _System GpiEndArea(HPS hps);
#line 1037
      long  _System GpiCharString(HPS hps,
                                   long lCount,
                                   PCH pchString);

      long  _System GpiCharStringAt(HPS hps,
                                     PPOINTL pptlPoint,
                                     long lCount,
                                     PCH pchString);
#line 1898
      long     _System GpiBitBlt(HPS hpsTarget,
                                  HPS hpsSource,
                                  long lCount,
                                  PPOINTL aptlPoints,
                                  long lRop,
                                  ULONG flOptions);

      BOOL     _System GpiDeleteBitmap(HBITMAP hbm);

      HBITMAP  _System GpiLoadBitmap(HPS hps,
                                      HMODULE Resource,
                                      ULONG idBitmap,
                                      long lWidth,
                                      long lHeight);

      HBITMAP  _System GpiSetBitmap(HPS hps,
                                     HBITMAP hbm);

      long     _System GpiWCBitBlt(HPS hpsTarget,
                                    HBITMAP hbmSource,
                                    long lCount,
                                    PPOINTL aptlPoints,
                                    long lRop,
                                    ULONG flOptions);
#line 2337
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 38 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmdev.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 211
      HDC  _System DevOpenDC(HAB hab,
                              long lType,
                              PSZ pszToken,
                              long lCount,
                              PDEVOPENDATA pdopData,
                              HDC hdcComp);
#line 219
      HMF  _System DevCloseDC(HDC hdc);

      BOOL  _System DevQueryCaps(HDC hdc,
                                  long lStart,
                                  long lCount,
                                  PLONG alArray);
#line 406
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 29 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwp.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 50
   typedef LHANDLE HOBJECT;
#line 73
      typedef struct _OBJECTIMAGE      
      {
         HPOINTER hptrObject;
      } OBJECTIMAGE;
      typedef OBJECTIMAGE *POBJECTIMAGE;
#line 80
      typedef struct _OBJCLASS          
      {
         struct _OBJCLASS *pNext;          
         PSZ               pszClassName;   
         PSZ               pszModName;     
      } OBJCLASS;
      typedef OBJCLASS *POBJCLASS;
#line 95
      BOOL _System WinRegisterObjectClass(PSZ pszClassName,
                                           PSZ pszModName);
#line 102
      BOOL _System WinDeregisterObjectClass(PSZ pszClassName);
#line 110
      BOOL _System WinReplaceObjectClass(PSZ pszOldClassName,
                                          PSZ pszNewClassName,
                                          BOOL fReplace);
#line 115
      BOOL _System WinEnumObjectClasses(POBJCLASS pObjClass,
                                         PULONG pulSize);
#line 125
      HOBJECT _System WinCreateObject(PSZ pszClassName,
                                       PSZ pszTitle,
                                       PSZ pszSetupString,
                                       PSZ pszLocation,
                                       ULONG ulFlags );
#line 139
      BOOL _System WinSetObjectData(HOBJECT hObject,
                                     PSZ pszSetupString);
#line 143
      BOOL _System WinDestroyObject(HOBJECT hObject);
#line 148
      HOBJECT _System WinQueryObject(PSZ pszObjectID);
#line 151
      BOOL _System WinSaveObject(HOBJECT hObject,
                                  BOOL    fAsync);

      BOOL _System WinOpenObject(HOBJECT hObject,
                                  ULONG   ulView,
                                  BOOL    Flag);

      HOBJECT _System WinMoveObject(HOBJECT hObjectofObject,
                                     HOBJECT hObjectofDest,
                                     ULONG   ulReserved);

      HOBJECT _System WinCopyObject(HOBJECT hObjectofObject,
                                     HOBJECT hObjectofDest,
                                     ULONG   ulReserved);

      HOBJECT _System WinCreateShadow(HOBJECT hObjectofObject,
                                       HOBJECT hObjectofDest,
                                       ULONG   ulReserved);
#line 173
      BOOL _System WinQueryActiveDesktopPathname(PSZ pszPathName,
                                                  ULONG ulSize);
#line 181
      BOOL _System WinQueryObjectPath(HOBJECT hobject,
                                       PSZ pszPathName,
                                       ULONG ulSize);
#line 186
      APIRET  _System WinRestartWPDServer( BOOL fState );
      BOOL    _System WinIsWPDServerReady( void );
      APIRET  _System WinRestartSOMDD( BOOL fState );
      BOOL    _System WinIsSOMDDReady( void );
#line 24 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmerr.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 901
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 199 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmwp.h"
   typedef struct _PAGEINFO      
   {
      ULONG   cb;
      HWND    hwndPage;
      PFNWP   pfnwp;
      ULONG   resid;
      PVOID   pCreateParams;
      USHORT  dlgid;
      USHORT  usPageStyleFlags;
      USHORT  usPageInsertFlags;
      USHORT  usSettingsFlags;
      PSZ     pszName;
      USHORT  idDefaultHelpPanel;
      USHORT  usReserved2;
      PSZ     pszHelpLibraryName;
      PUSHORT pHelpSubtable;    
      HMODULE hmodHelpSubtable;
      ULONG   ulPageInsertId;
   } PAGEINFO;
   typedef PAGEINFO *PPAGEINFO;
#line 225
      typedef struct _ICONPOS      
      {
         POINTL  ptlIcon;                     
         char    szIdentity[1];               
      } ICONPOS;
      typedef ICONPOS *PICONPOS;
#line 238
         BOOL _System WinSetFileIcon(PSZ pszFileName,
                                      PICONINFO pIcnInfo);
#line 247
         BOOL _System WinSetFileIconN(PSZ pszFileName,
                                       PICONINFO pIcnInfo,
                                       ULONG ulIconIndex);
#line 252
      BOOL _System WinFreeFileIcon(HPOINTER hptr);
#line 258
      HPOINTER _System WinLoadFileIcon(PSZ pszFileName,
                                        BOOL fPrivate);
#line 267
      HPOINTER _System WinLoadFileIconN(PSZ pszFileName,
                                         BOOL fPrivate,
                                         ULONG ulIconIndex);
#line 277
      BOOL _System WinStoreWindowPos(PSZ pszAppName,
                                      PSZ pszKeyName,
                                      HWND hwnd);
#line 287
      BOOL _System WinRestoreWindowPos(PSZ pszAppName,
                                        PSZ pszKeyName,
                                        HWND hwnd);
#line 292
      BOOL _System WinShutdownSystem(HAB hab,
                                      HMQ hmq);
#line 304
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 37 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pmstddlg.h"
   #pragma info( none )

      #pragma info( none )

   #pragma info( restore )
#line 133
   typedef  PSZ       APSZ[1];
   typedef  APSZ *PAPSZ;           
#line 139
   typedef struct _FILEDLG      
   {
      ULONG    cbSize;             
      ULONG    fl;                 
      ULONG    ulUser;             
      long     lReturn;            
      long     lSRC;               
      PSZ      pszTitle;           
      PSZ      pszOKButton;        
      PFNWP    pfnDlgProc;         
      PSZ      pszIType;           
#line 152
      PAPSZ    papszITypeList;     
#line 156
      PSZ      pszIDrive;          
#line 159
      PAPSZ    papszIDriveList;    
#line 163
      HMODULE  hMod;               
      char     szFullFile[260];  

      PAPSZ    papszFQFilename;    
#line 170
      ULONG    ulFQFCount;         
      USHORT   usDlgId;            
      short    x;                  
      short    y;                  
      short    sEAType;            
   } FILEDLG;
   typedef FILEDLG *PFILEDLG;
#line 181
   HWND    _System WinFileDlg(HWND hwndP,
                               HWND hwndO,
                               PFILEDLG pfild);
   MRESULT _System WinDefFileDlgProc(HWND hwnd,
                                      ULONG msg,
                                      MPARAM mp1,
                                      MPARAM mp2);

   BOOL    _System WinFreeFileDlgList(PAPSZ papszFQFilename);
#line 274
   typedef struct _FONTDLG      
   {
      ULONG   cbSize;                 
      HPS     hpsScreen;              
      HPS     hpsPrinter;             
      PSZ     pszTitle;               
      PSZ     pszPreview;             
      PSZ     pszPtSizeList;          
      PFNWP   pfnDlgProc;             
      PSZ     pszFamilyname;          
      FIXED   fxPointSize;            
      ULONG   fl;                     
      ULONG   flFlags;                
      ULONG   flType;                 
      ULONG   flTypeMask;             
      ULONG   flStyle;                
      ULONG   flStyleMask;            
      long    clrFore;                
      long    clrBack;                
      ULONG   ulUser;                 
      long    lReturn;                
      long    lSRC;                   
      long    lEmHeight;              
      long    lXHeight;               
      long    lExternalLeading;       
      HMODULE hMod;                   
      FATTRS  fAttrs;                 
      short   sNominalPointSize;      
      USHORT  usWeight;               
      USHORT  usWidth;                
      short   x;                      
      short   y;                      
      USHORT  usDlgId;                
      USHORT  usFamilyBufLen;         
      USHORT  usReserved;             
   } FONTDLG;
   typedef FONTDLG *PFONTDLG;
#line 386
   typedef struct _STYLECHANGE      
   {
      USHORT      usWeight;
      USHORT      usWeightOld;
      USHORT      usWidth;
      USHORT      usWidthOld;
      ULONG       flType;
      ULONG       flTypeOld;
      ULONG       flTypeMask;
      ULONG       flTypeMaskOld;
      ULONG       flStyle;
      ULONG       flStyleOld;
      ULONG       flStyleMask;
      ULONG       flStyleMaskOld;
   } STYLECHANGE;
   typedef STYLECHANGE *PSTYLECHANGE;
#line 406
   HWND    _System WinFontDlg(HWND hwndP,
                               HWND hwndO,
                               PFONTDLG pfntd);
   MRESULT _System WinDefFontDlgProc(HWND hwnd,
                                      ULONG msg,
                                      MPARAM mp1,
                                      MPARAM mp2);
#line 577
   typedef struct _SPBCDATA      
   {
      ULONG   cbSize;                 
      ULONG   ulTextLimit;            
      long    lLowerLimit;            
      long    lUpperLimit;            
      ULONG   idMasterSpb;            
      PVOID   pHWXCtlData;            
   } SPBCDATA;
   typedef SPBCDATA *PSPBCDATA;
#line 707
   typedef LHANDLE HSTR;   

   typedef struct _DRAGITEM      
   {
      HWND    hwndItem;                   
      ULONG   ulItemID;                   
      HSTR    hstrType;                   
      HSTR    hstrRMF;                    
      HSTR    hstrContainerName;          
      HSTR    hstrSourceName;             
      HSTR    hstrTargetName;             
      short   cxOffset;                   

      short   cyOffset;                   

      USHORT  fsControl;                  
      USHORT  fsSupportedOps;             
   } DRAGITEM;
   typedef DRAGITEM *PDRAGITEM;

   typedef struct _DRAGINFO      
   {
      ULONG    cbDraginfo;                
      USHORT   cbDragitem;                
      USHORT   usOperation;               
      HWND     hwndSource;                
      short    xDrop;                     
      short    yDrop;                     
      USHORT   cditem;                    
      USHORT   usReserved;                
   } DRAGINFO;
   typedef DRAGINFO *PDRAGINFO;

   typedef struct _DRAGIMAGE      
   {
      USHORT  cb;                         
      USHORT  cptl;                       
      LHANDLE hImage;                     
      SIZEL   sizlStretch;                
      ULONG   fl;                         
      short   cxOffset;                   

      short   cyOffset;                   

   } DRAGIMAGE;
   typedef DRAGIMAGE *PDRAGIMAGE;

   typedef struct _DRAGTRANSFER      
   {
      ULONG      cb;                      
      HWND       hwndClient;              
      PDRAGITEM  pditem;                  
      HSTR       hstrSelectedRMF;         
      HSTR       hstrRenderToName;        
      ULONG      ulTargetInfo;            
      USHORT     usOperation;             
      USHORT     fsReply;                 
   } DRAGTRANSFER;
   typedef DRAGTRANSFER *PDRAGTRANSFER;

   typedef struct _RENDERFILE      
   {
      HWND   hwndDragFiles;               
      HSTR   hstrSource;                  
      HSTR   hstrTarget;                  
      USHORT fMove;                       
      USHORT usRsvd;                      
   } RENDERFILE;
   typedef RENDERFILE *PRENDERFILE;
#line 784
   BOOL      _System DrgAcceptDroppedFiles(HWND hwnd,
                                            PSZ pszPath,
                                            PSZ pszTypes,
                                            ULONG ulDefaultOp,
                                            ULONG ulRsvd);
#line 791
   PDRAGINFO _System DrgAllocDraginfo(ULONG cditem);

   PDRAGTRANSFER _System DrgAllocDragtransfer(ULONG cdxfer);

   HWND      _System DrgDrag(HWND hwndSource,
                              PDRAGINFO pdinfo,
                              PDRAGIMAGE pdimg,
                              ULONG cdimg,
                              long vkTerminate,
                              PVOID pRsvd);
#line 813
   BOOL      _System DrgDragFiles(HWND hwnd,
                                   PSZ *apszFiles,
                                   PSZ *apszTypes,
                                   PSZ *apszTargets,
                                   ULONG cFiles,
                                   HPOINTER hptrDrag,
                                   ULONG vkTerm,
                                   BOOL fSourceRender,
                                   ULONG ulRsvd);
#line 824
   BOOL      _System DrgPostTransferMsg(HWND hwnd,
                                         ULONG msg,
                                         PDRAGTRANSFER pdxfer,
                                         ULONG fl,
                                         ULONG ulRsvd,
                                         BOOL fRetry);

   BOOL      _System DrgQueryDragitem(PDRAGINFO pdinfo,
                                       ULONG cbBuffer,
                                       PDRAGITEM pditem,
                                       ULONG iItem);

   ULONG     _System DrgQueryDragitemCount(PDRAGINFO pdinfo);

   PDRAGITEM _System DrgQueryDragitemPtr(PDRAGINFO pdinfo,
                                          ULONG i);

   BOOL      _System DrgQueryNativeRMF(PDRAGITEM pditem,
                                        ULONG cbBuffer,
                                        PCHAR pBuffer);

   ULONG     _System DrgQueryNativeRMFLen(PDRAGITEM pditem);
#line 852
   ULONG     _System DrgQueryStrName(HSTR hstr,
                                      ULONG cbBuffer,
                                      PSZ pBuffer);
#line 857
   ULONG     _System DrgQueryStrNameLen(HSTR hstr);
#line 864
   BOOL      _System DrgQueryTrueType(PDRAGITEM pditem,
                                       ULONG cbBuffer,
                                       PSZ pBuffer);
#line 869
   ULONG     _System DrgQueryTrueTypeLen(PDRAGITEM pditem);

   MRESULT   _System DrgSendTransferMsg(HWND hwnd,
                                         ULONG msg,
                                         MPARAM mp1,
                                         MPARAM mp2);

   BOOL      _System DrgSetDragitem(PDRAGINFO pdinfo,
                                     PDRAGITEM pditem,
                                     ULONG cbBuffer,
                                     ULONG iItem);

   BOOL      _System DrgSetDragImage(PDRAGINFO pdinfo,
                                      PDRAGIMAGE pdimg,
                                      ULONG cdimg,
                                      PVOID pRsvd);
#line 892
   BOOL      _System DrgVerifyTypeSet(PDRAGITEM pditem,
                                       PSZ pszType,
                                       ULONG cbMatch,
                                       PSZ pszMatch);
#line 898
   BOOL      _System DrgAccessDraginfo(PDRAGINFO pdinfo);
#line 903
   HSTR      _System DrgAddStrHandle(PSZ psz);
#line 906
   BOOL      _System DrgDeleteDraginfoStrHandles(PDRAGINFO pdinfo);

   BOOL      _System DrgDeleteStrHandle(HSTR hstr);

   BOOL      _System DrgFreeDraginfo(PDRAGINFO pdinfo);

   BOOL      _System DrgFreeDragtransfer(PDRAGTRANSFER pdxfer);

   HPS       _System DrgGetPS(HWND hwnd);

   BOOL      _System DrgPushDraginfo(PDRAGINFO pdinfo,
                                      HWND hwndDest);

   BOOL      _System DrgReleasePS(HPS hps);

   BOOL      _System DrgSetDragPointer(PDRAGINFO pdinfo,
                                        HPOINTER hptr);
#line 928
   BOOL      _System DrgVerifyNativeRMF(PDRAGITEM pditem,
                                         PSZ pszRMF);
#line 937
   BOOL      _System DrgVerifyRMF(PDRAGITEM pditem,
                                   PSZ pszMech,
                                   PSZ pszFmt);
#line 946
   BOOL      _System DrgVerifyTrueType(PDRAGITEM pditem,
                                        PSZ pszType);
#line 954
   BOOL      _System DrgVerifyType(PDRAGITEM pditem,
                                    PSZ pszType);
#line 961
   BOOL _System DrgLazyDrag( HWND hwndSource,
                             PDRAGINFO pdinfo,
                             PDRAGIMAGE pdimg,
                             ULONG cdimg,
                             PVOID pRsvd );

   BOOL _System DrgCancelLazyDrag( void );

   BOOL _System DrgLazyDrop( HWND hwndTarget,
                             ULONG ulOperation,
                             PPOINTL pptlDrop );

   PDRAGINFO _System DrgQueryDraginfoPtr( PDRAGINFO pRsvd );

   PDRAGINFO _System DrgQueryDraginfoPtrFromHwnd( HWND hwndSource );

   PDRAGINFO _System DrgQueryDraginfoPtrFromDragitem( PDRAGITEM pditem );

   ULONG _System DrgQueryDragStatus(void);

   PDRAGINFO _System DrgReallocDraginfo (PDRAGINFO pdinfoOld,
                                          ULONG cditem);
#line 1085
   typedef struct _TREEITEMDESC      
   {
      HBITMAP       hbmExpanded;
      HBITMAP       hbmCollapsed;
      HPOINTER      hptrExpanded;
      HPOINTER      hptrCollapsed;
   } TREEITEMDESC;
   typedef TREEITEMDESC *PTREEITEMDESC;
#line 1097
   typedef struct _FIELDINFO       
   {
      ULONG      cb;                   
      ULONG      flData;               
      ULONG      flTitle;              
      PVOID      pTitleData;           

      ULONG      offStruct;            
      PVOID      pUserData;            
      struct _FIELDINFO *pNextFieldInfo;  

      ULONG      cxWidth;              
   } FIELDINFO;
   typedef FIELDINFO *PFIELDINFO;
#line 1115
   typedef struct _RECORDCORE      
   {
      ULONG       cb;
      ULONG       flRecordAttr;         
      POINTL      ptlIcon;              
      struct _RECORDCORE *preccNextRecord;    
      PSZ         pszIcon;              
      HPOINTER    hptrIcon;             
      HPOINTER    hptrMiniIcon;         
      HBITMAP     hbmBitmap;            
      HBITMAP     hbmMiniBitmap;        
      PTREEITEMDESC pTreeItemDesc;      
      PSZ         pszText;              
      PSZ         pszName;              
      PSZ         pszTree;              
   } RECORDCORE;
   typedef RECORDCORE *PRECORDCORE;
#line 1136
   typedef struct _MINIRECORDCORE      
   {
      ULONG       cb;
      ULONG       flRecordAttr;         
      POINTL      ptlIcon;              
      struct _MINIRECORDCORE *preccNextRecord;  
      PSZ         pszIcon;              
      HPOINTER    hptrIcon;             
   } MINIRECORDCORE;
   typedef MINIRECORDCORE *PMINIRECORDCORE;
#line 1150
   typedef struct _TREEMOVE           
   {
      PRECORDCORE preccMove;          
      PRECORDCORE preccNewParent;     
      PRECORDCORE pRecordOrder;       
      BOOL        flMoveSiblings;     

   } TREEMOVE;
   typedef TREEMOVE *PTREEMOVE;
#line 1163
   typedef struct _CNRINFO      
   {
      ULONG       cb;                   
      PVOID       pSortRecord;          

      PFIELDINFO  pFieldInfoLast;       

      PFIELDINFO  pFieldInfoObject;     
#line 1174
      PSZ         pszCnrTitle;          
#line 1177
      ULONG       flWindowAttr;         
      POINTL      ptlOrigin;            

      ULONG       cDelta;               
#line 1183
      ULONG       cRecords;             
      SIZEL       slBitmapOrIcon;       
      SIZEL       slTreeBitmapOrIcon;   
      HBITMAP     hbmExpanded;          
      HBITMAP     hbmCollapsed;         
      HPOINTER    hptrExpanded;         
      HPOINTER    hptrCollapsed;        
      long        cyLineSpacing;        
      long        cxTreeIndent;         
      long        cxTreeLine;           
      ULONG       cFields;              
      long        xVertSplitbar;        
#line 1197
   } CNRINFO;
   typedef CNRINFO *PCNRINFO;

   typedef struct _CDATE      
   {
      UCHAR   day;                          
      UCHAR   month;                        
      USHORT  year;                         
   } CDATE;
   typedef CDATE *PCDATE;

   typedef struct _CTIME      
   {
      UCHAR   hours;                        
      UCHAR   minutes;                      
      UCHAR   seconds;                      
      UCHAR   ucReserved;                   
   } CTIME;
   typedef CTIME *PCTIME;
#line 1335
   typedef struct _CNRDRAGINIT      
   {
      HWND        hwndCnr;                  
      PRECORDCORE pRecord;                  
      long        x;                        
      long        y;                        
      long        cx;                       
      long        cy;                       
   } CNRDRAGINIT;
   typedef CNRDRAGINIT *PCNRDRAGINIT;
#line 1351
   typedef struct _FIELDINFOINSERT      
   {
      ULONG       cb;                   
      PFIELDINFO  pFieldInfoOrder;      

      ULONG       fInvalidateFieldInfo; 
      ULONG       cFieldInfoInsert;     

   } FIELDINFOINSERT;
   typedef FIELDINFOINSERT *PFIELDINFOINSERT;
#line 1365
   typedef struct _RECORDINSERT      
   {
      ULONG       cb;
      PRECORDCORE pRecordOrder;
      PRECORDCORE pRecordParent;
      ULONG       fInvalidateRecord;
      ULONG       zOrder;
      ULONG       cRecordsInsert;
   } RECORDINSERT;
   typedef RECORDINSERT *PRECORDINSERT;
#line 1379
   typedef struct _QUERYRECFROMRECT      
   {
      ULONG   cb;
      RECTL   rect;
      ULONG   fsSearch;
   } QUERYRECFROMRECT;
   typedef QUERYRECFROMRECT *PQUERYRECFROMRECT;
#line 1390
   typedef struct _QUERYRECORDRECT      
   {
      ULONG        cb;
      PRECORDCORE  pRecord;
      ULONG        fRightSplitWindow;
      ULONG        fsExtent;
   } QUERYRECORDRECT;
   typedef QUERYRECORDRECT *PQUERYRECORDRECT;
#line 1402
   typedef struct _SEARCHSTRING      
   {
      ULONG  cb;
      PSZ    pszSearch;
      ULONG  fsPrefix;
      ULONG  fsCaseSensitive;
      ULONG  usView;
   } SEARCHSTRING;
   typedef SEARCHSTRING *PSEARCHSTRING;
#line 1416
      typedef struct _CNRDRAGINFO      
      {
         PDRAGINFO   pDragInfo;
         PRECORDCORE pRecord;
      } CNRDRAGINFO;
      typedef CNRDRAGINFO *PCNRDRAGINFO;
#line 1426
      typedef struct _CNRLAZYDRAGINFO      
      {
         PDRAGINFO pDragInfo;
         PRECORDCORE pRecord;
         HWND hwndTarget;
      } CNRLAZYDRAGINFO;
      typedef CNRLAZYDRAGINFO *PCNRLAZYDRAGINFO;
#line 1439
   typedef struct _NOTIFYRECORDEMPHASIS      
   {
      HWND        hwndCnr;
      PRECORDCORE pRecord;
      ULONG       fEmphasisMask;
   } NOTIFYRECORDEMPHASIS;
   typedef NOTIFYRECORDEMPHASIS *PNOTIFYRECORDEMPHASIS;
#line 1450
   typedef struct _NOTIFYRECORDENTER      
   {
      HWND        hwndCnr;
      ULONG       fKey;
      PRECORDCORE pRecord;
   } NOTIFYRECORDENTER;
   typedef NOTIFYRECORDENTER *PNOTIFYRECORDENTER;
#line 1461
   typedef struct _NOTIFYDELTA      
   {
      HWND        hwndCnr;
      ULONG       fDelta;
   } NOTIFYDELTA;
   typedef NOTIFYDELTA *PNOTIFYDELTA;
#line 1471
   typedef struct _NOTIFYSCROLL      
   {
      HWND        hwndCnr;
      long        lScrollInc;
      ULONG       fScroll;
   } NOTIFYSCROLL;
   typedef NOTIFYSCROLL *PNOTIFYSCROLL;
#line 1482
   typedef struct _CNREDITDATA      
   {
      ULONG        cb;
      HWND         hwndCnr;
      PRECORDCORE  pRecord;
      PFIELDINFO   pFieldInfo;
      PSZ *ppszText;                    
      ULONG        cbText;                      
      ULONG        id;
   } CNREDITDATA;
   typedef CNREDITDATA *PCNREDITDATA;
#line 1497
   typedef struct _OWNERBACKGROUND      
   {
      HWND    hwnd;
      HPS     hps;
      RECTL   rclBackground;
      long    idWindow;
   } OWNERBACKGROUND;
   typedef OWNERBACKGROUND *POWNERBACKGROUND;
#line 1509
   typedef struct _CNRDRAWITEMINFO      
   {
      PRECORDCORE  pRecord;
      PFIELDINFO   pFieldInfo;
   } CNRDRAWITEMINFO;
   typedef CNRDRAWITEMINFO *PCNRDRAWITEMINFO;
#line 1611
   typedef struct _SLDCDATA      
   {
      ULONG   cbSize;                 
      USHORT  usScale1Increments;     
      USHORT  usScale1Spacing;        
      USHORT  usScale2Increments;     
      USHORT  usScale2Spacing;        
   } SLDCDATA;
   typedef SLDCDATA *PSLDCDATA;
#line 1707
   typedef struct _CSBITMAPDATA    
   {
      HBITMAP hbmLeftUp;
      HBITMAP hbmLeftDown;
      HBITMAP hbmRightUp;
      HBITMAP hbmRightDown;
   } CSBITMAPDATA;
   typedef CSBITMAPDATA *PCSBITMAPDATA;
#line 1765
   typedef struct _VSCDATA      
   {
      ULONG   cbSize;                 
      USHORT  usRowCount;             
      USHORT  usColumnCount;          
   } VSCDATA;
   typedef VSCDATA *PVSCDATA;
#line 1776
   typedef struct _VSDRAGINIT      
   {
      HWND    hwnd;                   
      long    x;                      
      long    y;                      
      long    cx;                     
      long    cy;                     
      USHORT  usRow;                  
      USHORT  usColumn;               
   } VSDRAGINIT;
   typedef VSDRAGINIT *PVSDRAGINIT;
#line 1792
      typedef struct _VSDRAGINFO      
      {
         PDRAGINFO pDragInfo;          
         USHORT    usRow;              
         USHORT    usColumn;           
      } VSDRAGINFO;
      typedef VSDRAGINFO *PVSDRAGINFO;
#line 1804
   typedef struct _VSTEXT      
   {
      PSZ       pszItemText;       
      ULONG     ulBufLen;          
   } VSTEXT;
   typedef VSTEXT *PVSTEXT;
#line 2023
   typedef struct _BOOKPAGEINFO      
   {
      ULONG     cb;                          
      ULONG     fl;                          
      BOOL      bLoadDlg;                    

      ULONG     ulPageData;                  
      HWND      hwndPage;                    
      PFN       pfnPageDlgProc;              
      ULONG     idPageDlg;                   
      HMODULE   hmodPageDlg;                 
      PVOID     pPageDlgCreateParams;
      PDLGTEMPLATE pdlgtPage;
      ULONG     cbStatusLine;                
      PSZ       pszStatusLine;               
      HBITMAP   hbmMajorTab;                 
      HBITMAP   hbmMinorTab;                 
      ULONG     cbMajorTab;                  
      PSZ       pszMajorTab;                 
      ULONG     cbMinorTab;                  
      PSZ       pszMinorTab;                 
      PVOID     pBidiInfo;                   

   } BOOKPAGEINFO;
   typedef BOOKPAGEINFO *PBOOKPAGEINFO;
#line 2052
   typedef struct _BOOKTEXT      
   {
      PSZ    pString;                         
      ULONG  textLen;                         
   } BOOKTEXT;
   typedef BOOKTEXT *PBOOKTEXT;
#line 2062
   typedef struct _DELETENOTIFY      
   {
      HWND    hwndBook;                       
      HWND    hwndPage;                       
      ULONG   ulAppPageData;                  
      HBITMAP hbmTab;                         
   } DELETENOTIFY;
   typedef DELETENOTIFY *PDELETENOTIFY;
#line 2074
   typedef struct _PAGESELECTNOTIFY      
   {
      HWND    hwndBook;                       
      ULONG   ulPageIdCur;                    
      ULONG   ulPageIdNew;                    
   } PAGESELECTNOTIFY;
   typedef PAGESELECTNOTIFY *PPAGESELECTNOTIFY;
#line 2095
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 104 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\pm.h"
   #pragma info( none )

      #pragma info( restore )

   #pragma info( restore )
#line 51 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\os2.h"
#pragma info( none )

      #pragma info( restore )

#pragma info( restore )
#line 26 "globals.h"
typedef struct _NICERP		// request packet
{
	PID			pid;
	TID			tid;
	ULONG		ulClass;
	long		lDelta;
	HEV			hevDone;	
	APIRET  	rc;

} NICERP, * PNICERP;
#line 14 "e:\\dev\\vacpp\\ibmcpp\\include\\os2\\os2.h"
#pragma info( none )

      #pragma info( none )

#pragma info( restore )
#line 51
#pragma info( none )

      #pragma info( restore )

#pragma info( restore )
#line 22 "util.h"
APIRET swlPidToHwnd( PID, HWND * );
APIRET swlNameToPid( PSZ, PID * );
APIRET qssPmShellPid( PID, PID * );
long   my_strlen( char * );
long   my_strcmp( char *, char * );
char * my_strchr( char *, char );
char * my_strrchr( char *, char );
#line 33
long   my_vsprintf( char *, const char *, PVOID * );
#line 36 "engine.c"
HMODULE  gHmEngine;		        // exported
TID		 gTidEngine;            //
HWND	 gHwndTlwCntr;  		//
PFNWP    gOriginalTlwWinProc;	// 			

HQUEUE   gHq;         	        // globals to ease cleanup
HAB	     gHab;                  //
HMQ      gHmq;                  //
HEV		 gHevHookDone;          //

HFILE	 gHfConsole;            // console
ULONG    gEngineState;          // engine state

void     ReportRC( PNICERP, APIRET );
BOOL    _System InputHook( HAB hab, PQMSG pqmsg, ULONG fs );
void    _System HookCleanup( void );
void    _System EngineCleanup( void );
#line 116
void _System Engine( ULONG arg )
{
	APIRET		rc;
	HAB			hab;            // WinInitialize ...
	HMQ			hmq;

	HQUEUE      hq; 			// DosCreateQueue
    PID			pidEngine;

	REQUESTDATA	rd;    			// DosReadQueue
	ULONG		cbData;
	BYTE		bPriority;

	HEV			hevHookDone;    // handle request packet
	HEV			hevRP;
	ULONG		ulPostCount;
	PNICERP		pNiceRP;
	HWND	    hwnd;
	PID			pid;
	PID			pidPmShell;

    ULONG		ulAction;		// console

	PTIB		ptib;			// to get my PID
	PPIB		ppib;
#line 143
	if( ( ULONG ) arg & 0x00000002 )
	{
		rc = DosOpen( "\\PIPE\\NICE\\CONSOLE.P",
			          &gHfConsole,	
				      &ulAction,
				      0,
				      0,
				      0x0001,
				      0x0010 |
				  	      0x0001 |
				  	      0x1000,
				      0 );
		if( rc )
		{
		    ;
		    DosExit( 0, 1 );			
		};

		gEngineState = 11;
		;
	};

	gEngineState = 12;	
	;

	DosGetInfoBlocks( &ptib, &ppib );
	pidEngine = ppib->pib_ulpid;
	;
#line 177
	rc = DosExitList( 1, ( PFNEXITLIST ) EngineCleanup );
	if( rc )
	{
		;
		;
		;

		DosClose( gHfConsole );
		DosExit( 0, 1 );
	};

	gEngineState = 13;
	;
#line 196
    rc = DosCreateQueue( &hq,
    					 0L,
    					 "\\QUEUES\\NICE\\ENGINE.QUE" );
	gHq = hq;		
	if( rc )
	{
		;
		;
		;
		DosExit( 0, 1 );
	};

	gEngineState = 14;	
	;
#line 217
	rc = DosCreateEventSem( ((void *)0), &hevHookDone, 0x01, 0 );
	gHevHookDone = hevHookDone;	
	if( rc )
	{
		;
		;
		;
		DosExit( 0, 1 );
	};

	gEngineState = 15;
	;
#line 238
	hab = WinInitialize( 0 );
	gHab = hab;
	if( hab == 0 )
	{
		;
		;
		;
		DosExit( 0, 1 );
	};

	gEngineState = 16;
	;

	gEngineState = 17;
	rc = qssPmShellPid( pidEngine, &pidPmShell );
	if( rc )
	{
		;
		;
		;
	}	
	else
		;

	while( 1 )
	{
		gEngineState = 18;
		;
#line 272
		rc = DosReadQueue( hq,
						   &rd,
						   &cbData,
						   ( PPVOID ) &pNiceRP,
						   0,
						   0,
						   &bPriority,
						   0 );	
		if( rc )
		{
			;
			;
			;
			break;
		};

		gEngineState = 19;
#line 297
;

		if( rd.ulData == 0x0000D00F // stop the engine )
		{
			gEngineState = 60;
			;
#line 310
			rc = DosGetSharedMem( ( PVOID ) pNiceRP, 0x00000001U | 0x00000002U );
			if( rc )
			{
				;
				;
				;
				break;
			};
#line 325
			gEngineState = 61;
			;
			break; // exit the engine loop
		}
		else if( rd.ulData == 0x0000FF01 // set process priority )
		{
			gEngineState = 30;
			;

			rc = DosGetSharedMem( ( PVOID ) pNiceRP, 0x00000001U | 0x00000002U );
			if( rc )
			{
				;
				;
				;
				continue;
			};
#line 350
;

			rc = DosSetPriority( 0,
			 				     pNiceRP->ulClass,
								 pNiceRP->lDelta,
								 pNiceRP->pid );

			;								

			ReportRC( pNiceRP, rc );
			rc = DosFreeMem( pNiceRP );

			gEngineState = 31;
			;			
		}
		else if( rd.ulData == 0x0000FF02 // set thread priority )
		{
			gEngineState = 40;
            ;			

			rc = DosGetSharedMem( ( PVOID ) pNiceRP, 0x00000001U | 0x00000002U );
			if( rc )
			{
				;
				;
				;
				continue;
			};
#line 390
			hmq = WinCreateMsgQueue( hab, 0 );		
			gHmq = hmq;	
			if( !hmq )
			{
				;
				;
				;

				rc = WinGetLastError( hab );
				ReportRC( pNiceRP, rc );
				DosFreeMem( pNiceRP );
				continue;
			};

			gEngineState = 41;	
			;

			gEngineState = 42;
			;

			rc = swlPidToHwnd( pNiceRP->pid, &hwnd );

			if( rc )
			{	
				;
#line 417
;
				;

				WinDestroyMsgQueue( hmq );
				gHmq = 0;

				ReportRC( pNiceRP, -7 );
				rc = DosFreeMem( pNiceRP );

				continue;
			};

			;

			rc = DosExitList( 1, ( PFNEXITLIST ) HookCleanup );			
			if( rc )
			{
				;
				;
				;

				WinDestroyMsgQueue( hmq );
				gHmq = 0;

				ReportRC( pNiceRP, rc );
				rc = DosFreeMem( pNiceRP );

				continue;
			};

			gEngineState = 43;
			;
#line 455
  			rc = WinSetHook( hab,
  							 ( (LHANDLE) 0),
  							 1,
                          	 ( PFN ) InputHook,
                          	 gHmEngine );
            if( !rc )
            {
            	rc = WinGetLastError( hab );
				;
#line 466
;
				;

            	WinDestroyMsgQueue( hmq );
            	gHmq = 0;

            	ReportRC( pNiceRP, -5 );
            	rc = DosFreeMem( pNiceRP );

            	continue;
            };

            gEngineState = 44;
            ;              	

            hevRP = pNiceRP->hevDone;
            pNiceRP->hevDone = hevHookDone;              	
#line 490
			gEngineState = 45;
			;
#line 499
;

  			WinPostMsg( hwnd,
  			            0x0000,
  			            ((MPARAM)(ULONG)(0x0000FF02 // set thread priority)),
  			            ((MPARAM)(ULONG)(pNiceRP)) );

			gEngineState = 46;
			;
#line 516
			gEngineState = 47;
			;

  			rc = DosWaitEventSem( hevHookDone, 6000 // max time to wait for the engine hook to process a request );
  			DosResetEventSem( hevHookDone, &ulPostCount );

  			gEngineState = 48;
  			;

  			pNiceRP->hevDone = hevRP;
#line 532
			;

            WinReleaseHook( gHab,
              				( (LHANDLE) 0),
              				1,
              				( PFN ) InputHook,
              				gHmEngine );

            WinBroadcastMsg( (HWND)1,
                             0x0000,
                             0,
                             0,
                             0x0008 | 0x0000 );

			gEngineState = 49;
			;

			DosExitList( 2, ( PFNEXITLIST ) HookCleanup );
			gEngineState = 50;
			;

			WinDestroyMsgQueue( hmq );
			gHmq = 0;
			gEngineState = 51;
			;
#line 563
			if( rc == 640 ) // request never completed
			{
				;
				ReportRC( pNiceRP, rc );
			}
			else if( pNiceRP->rc )  // if the DosSetPriority failed inside the hook
  			{
  				;
  				ReportRC( pNiceRP, pNiceRP->rc );	
			}
			else
			    ReportRC( pNiceRP, 0 );

			rc = DosFreeMem( pNiceRP );

			gEngineState = 52;
			;			
		}
		else if( rd.ulData == 0x0000FF03 // command from TLW )
		{
			PMINIRECORDCORE	 pRec;
			PSZ				 pszName;
			ULONG			 ulClass;
			long			 lDelta;
#line 589
		    gEngineState = 70;
		    ;

			pRec = ( PMINIRECORDCORE ) pNiceRP;

            gEngineState = 74;
            ;
#line 605
;
#line 612
            pszName = my_strchr( pRec->pszIcon, '-' );
            if( pszName )
            {
                pszName++;
                ;
            }
            else
                pszName = pRec->pszIcon;

            gEngineState = 72;
            ;

            rc = swlNameToPid( pszName, &pid );

            if( rc )
            {
                ;
#line 631
;
                ;

		   		WinDestroyMsgQueue( hmq );
				gHmq = 0;
				gEngineState = 51;
				;

                continue;
            };

            gEngineState = 75;
            ;

            if( pid > pidEngine &&
                pid != pidPmShell )
            {
                gEngineState = 73;
                switch( cbData )
                {
                    case 16385:
                        ulClass = 0;
                        lDelta  = +1;
                        break;

                    case 16386:
                        ulClass = 0;
                        lDelta  = -1;
                        break;

                    case 16391:
                        ulClass = 1;
                        lDelta  = 0;
                        break;

                    case 16392:
                        ulClass = 1;
                        lDelta  = 15;
                        break;

                    case 16393:
                        ulClass = 1;
                        lDelta  = 31;
                        break;

                    case 16401:
                        ulClass = 2;
                        lDelta  = 0;
                        break;

                    case 16402:
                        ulClass = 2;
                        lDelta  = 15;
                        break;

                    case 16403:
                        ulClass = 2;
                        lDelta  = 31;
                        break;

                    case 16411:
                        ulClass = 4;
                        lDelta  = 0;
                        break;

                    case 16412:
                        ulClass = 4;
                        lDelta  = 15;
                        break;

                    case 16413:
                        ulClass = 4;
                        lDelta  = 31;
                        break;
                };
#line 714
;

                rc = DosSetPriority( 0,
                                     ulClass,
                                     lDelta,
                                     pid );

                ;

            }; // pidEngine and pidPmShell

			gEngineState = 79;
		    ;			
		};
	};

	gEngineState = 20;
	;

	rc = WinDestroyMsgQueue( hmq );
	rc = WinTerminate( hab );

	rc = DosCloseEventSem( hevHookDone );	
	rc = DosCloseQueue( hq );

    if( rd.ulData = 0x0000D00F // stop the engine )
    {
		ReportRC( pNiceRP, 0 );
		DosFreeMem( pNiceRP );
	};

    if( gHfConsole )
        DosClose( gHfConsole );

	rc = DosExitList( 2, ( PFNEXITLIST ) EngineCleanup );
	DosExit( 0, 1 );
};
#line 753
void ReportRC( PNICERP pNiceRP, APIRET rc )
{
	;
	pNiceRP->rc = rc;
	DosOpenEventSem( ((void *)0), &( pNiceRP->hevDone ) );
	DosPostEventSem( pNiceRP->hevDone );
	DosCloseEventSem( pNiceRP->hevDone );
};
#line 769
BOOL _System InputHook( HAB hab, PQMSG pqmsg, ULONG fs )
{
	APIRET 		rc;
	HFILE		hf;
	ULONG		ulAction;

    if( pqmsg->msg == 0x0000 &&
    	((ULONG)(pqmsg->mp1)) == 0x0000FF02 // set thread priority )
    {
    	if( gHfConsole )
			rc = DosOpen( "\\PIPE\\NICE\\CONSOLE.P",
			          	  &hf,	
				      	  &ulAction,
				          0,
				          0,
				          0x0001,
				             0x0010 |
				  	         0x0001 |
				  	         0x1000,
				          0 );

    	;
#line 797
		rc = DosGetSharedMem( ( PVOID ) ( PNICERP ) pqmsg->mp2, 0x00000001U | 0x00000002U );
		if( rc )
		{
			;
			;
			;

        	if( gHfConsole )
        		DosClose( hf );

			return 1;
		};

		;

		rc = DosSetPriority( 2,
							 ( ( PNICERP ) pqmsg->mp2 )->ulClass,
							 ( ( PNICERP ) pqmsg->mp2 )->lDelta,
							 ( ( PNICERP ) pqmsg->mp2 )->tid );

		;							

		ReportRC( ( PNICERP ) pqmsg->mp2, rc );					
    	DosFreeMem( ( PNICERP ) pqmsg->mp2 );

        ;
        if( gHfConsole )
        	DosClose( hf );

    	return 1; // don't pass on the message
    };

	return 0;
};
#line 833
void _System HookCleanup( void )
{
	gEngineState = 101;
	;

    WinReleaseHook( gHab,
       				( (LHANDLE) 0),
       				1,
       				( PFN ) InputHook,
       				gHmEngine );

    WinBroadcastMsg( (HWND)1,
                     0x0000,
                     0,
                     0,
                     0x0008 | 0x0000 );

	WinDestroyMsgQueue( gHmq );

	DosExitList( 3, ( PFNEXITLIST ) ((void *)0) );
};
#line 856
void _System EngineCleanup( void )
{
	gEngineState = 102;
	;

	WinTerminate( gHab );
	DosCloseEventSem( gHevHookDone );
	DosCloseQueue( gHq );
    if( gHfConsole )
        DosClose( gHfConsole );

	DosExitList( 3, ( PFNEXITLIST ) ((void *)0) );
};
#line 876
MRESULT _System TlwWinProc( HWND hwnd, ULONG msg, MPARAM mp1, MPARAM mp2 )
{
	APIRET		    rc;
    MRESULT 	    result;
    MENUITEM 	    mi;
    MENUITEM 	    miSep;
    PMINIRECORDCORE pRec;
    BOOL			fInsertPriorityMenu;

    static HWND	           hwndCntxMenu;
    static HWND	           hwndPriorityMenu = 0;
	static PMINIRECORDCORE pRecSrc = 0;

	switch( msg )
	{
		case 0x0030:
			if( ((USHORT)((ULONG)mp1 >> 16)) == 119 )
			{
				pRecSrc = ( PMINIRECORDCORE ) mp2; // the source record
#line 901
				pRec = WinSendMsg( gHwndTlwCntr,
		    				   	   0x0341,
		    				       ((MPARAM)(ULONG)(0x0010)),
		    				       ((MPARAM)(ULONG)(0x00000001L)) );		    	

				if( pRec <= 0 )                       // nothing else selected
					fInsertPriorityMenu = 1;
				else
				{
					if( pRec->flRecordAttr & 0x00000010L )
						do                            // find first sleceted none-filtered
						{
							pRec = WinSendMsg( gHwndTlwCntr,
		    					   	   		   0x0341,
		    				    	           ((MPARAM)(ULONG)(pRec)),
		    		 		        	       ((MPARAM)(ULONG)(0x00000001L)) );		    	

			    		} while( pRec > 0 && pRec->flRecordAttr & 0x00000010L );	

					if( pRec != pRecSrc )             // something else selected
						fInsertPriorityMenu = 0;
					else                              // source is selected see if there are others
					{
						do                            // find first sleceted none-filtered
						{
							pRec = WinSendMsg( gHwndTlwCntr,
			    				   	   		   0x0341,
		    					               ((MPARAM)(ULONG)(pRec)),
		    			 		               ((MPARAM)(ULONG)(0x00000001L)) );		    	

		    			} while( pRec > 0 && pRec->flRecordAttr & 0x00000010L );	

			        	fInsertPriorityMenu = pRec > 0 ? 0 : 1;
					};			
			    };

				if( fInsertPriorityMenu )
				{
					PSZ		pszFolder;

					pszFolder = my_strchr( pRecSrc->pszIcon, '-' );
					if( pszFolder )
					{
						pszFolder++;

						if( !my_strcmp( pszFolder, "Icon View" ) )
							fInsertPriorityMenu = 0;
						else if( !my_strcmp( pszFolder, "Tree View" ) )
							fInsertPriorityMenu = 0;
						else if( !my_strcmp( pszFolder, "Details View" ) )
							fInsertPriorityMenu = 0;
					}
					else if( !my_strcmp( pRecSrc->pszIcon, "WarpCenter" ) )
						fInsertPriorityMenu = 0;
			    };

				if( fInsertPriorityMenu )
				{
                    miSep.iPosition = (-1);
                    miSep.afStyle = 0x0004;
                    miSep.afAttribute = 0;
                    miSep.id = -1;
                    miSep.hwndSubMenu = 0;
                    miSep.hItem = 0;

                    hwndPriorityMenu = WinLoadMenu( (HWND)1,
                                                    gHmEngine,
                                                    16384 );

                    mi.iPosition = (-1);
                    mi.afStyle = 0x0010;
                    mi.afAttribute = 0;
                    mi.id = 16384;
                    mi.hwndSubMenu = hwndPriorityMenu;
                    mi.hItem = 0;
                };

				result = ( MRESULT ) gOriginalTlwWinProc( hwnd, msg, mp1, mp2 );

				if( fInsertPriorityMenu )
				{
					hwndCntxMenu = WinWindowFromID( (HWND)1, 0x038D // dynamicaly built context menu id );

					WinSendMsg( hwndCntxMenu,
			        	    	0x0180,
			            		( MPARAM ) &miSep,
			            		( MPARAM ) "" );

					WinSendMsg( hwndCntxMenu,
								0x0180,
								( MPARAM ) &mi,
								( MPARAM ) "~Priority" );			
				};

				return result;
            };

            break; // 0x0030

		case 0x0020:
			if( ( ULONG ) mp1 == 16385 ||
			    ( ULONG ) mp1 == 16386 ||
			    ( ULONG ) mp1 == 16391 ||
			    ( ULONG ) mp1 == 16392 ||
			    ( ULONG ) mp1 == 16393 ||
			    ( ULONG ) mp1 == 16401 ||
			    ( ULONG ) mp1 == 16402 ||
			    ( ULONG ) mp1 == 16403 ||
			    ( ULONG ) mp1 == 16411 ||
			    ( ULONG ) mp1 == 16412 ||
			    ( ULONG ) mp1 == 16413 )
		        {
		        	;

					rc = DosWriteQueue( gHq,
				                    	0x0000FF03 // command from TLW,
				                    	( ULONG ) mp1,
				                    	( PVOID ) pRecSrc,
				                    	0 );
				    if( rc )
				    {
						;
						;
				        ;
				    }
				    else
						;
				};

			break; // 0x0020

		default:
			break;
	};			

	return ( MRESULT ) gOriginalTlwWinProc( hwnd, msg, mp1, mp2 );
};	
