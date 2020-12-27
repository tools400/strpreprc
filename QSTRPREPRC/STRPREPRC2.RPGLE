      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : STRPREPRC                                          *
      *  Objekt  . . . : STRPREPRC2                                         *
      *  Beschreibung  : Start Pre-Processor - Services                     *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 21.11.2000                                         *
      *                                                                     *
      * =================================================================== *
      *                                                                     *
      *  This software is free software, you can redistribute it and/or     *
      *  modify it under the terms of the GNU General Public License (GPL)  *
      *  as published by the Free Software Foundation.                      *
      *                                                                     *
      *  See GNU General Public License for details.                        *
      *          http://www.opensource.org                                  *
      *          http://www.opensource.org/licenses/gpl-license.html        *
      *                                                                     *
      *=====================================================================*
      *  History:                                                           *
      *                                                                     *
      *  Datum       Name          Änderung                                 *
      *  ----------  ------------  ---------------------------------------  *
      *  21.05.2002  Th.Raddatz    Removed special characters from src mbr  *
      *                                                                     *
      *  23.01.2007  Th.Raddatz    Added parameter TAGSREQ(...) to command. *
      *                                                                     *
      *  20.02.2009  Th.Raddatz    Added Pre-Compiler tag "WIDTH".          *
      *                            Moved H-Specs into member H_SPEC.        *
      *                                                                     *
      *  09.04.2015  Hildebrandt   Added parameter EXICMDEXC to command.    *
      *                                                                     *
      *  16.05.2015  Th.Raddatz    Added parameter EVENTF to command.       *
      *                                                                     *
      *  18.05.2015  Th.Raddatz    Converted to /free.                      *
      *                                                                     *
      *  18.06.2015  Th.Raddatz    Renamed parameter EVENTF to OPTION.      *
      *                                                                     *
      *  23.07.2015  Th.Raddatz    Fixed problem that the EVFEVENT file     *
      *                            was not created when the creation        *
      *                            command had been executed implicitly.    *
      *                                                                     *
      *  17.12.2015  Th.Raddatz    Fixed executeCmd(), which must           *
      *                            pass 'executeCmd' case sensitive         *
      *                            to getMsgInf();                          *
      *                                                                     *
      *  18.02.2016  Th.Raddatz    Added the >IMPORTANT< parameter tag.     *
      *                                                                     *
      *  10.03.2016  Th.Raddatz    Added message PRZ0028.                   *
      *                                                                     *
      *  20.10.2016  Th.Raddatz    Now calling prepareEventFile() right at  *
      *                            beginning of the program to capture      *
      *                            early STRPREPRC errors.                  *
      *                                                                     *
      *  09.01.2017  Th.Raddatz    Now logging the complete command, when   *
      *                            it could not be executed.                *
      *                                                                     *
      *  17.01.2017  Th.Raddatz    Added option *ADDJOBLOG to append the    *
      *                            job log to event files create by IBM     *
      *                            object creation commands.                *
      *                                                                     *
      *  28.01.2017  Th.Raddatz    Fixed problem, that event file entries   *
      *                            created by an IBM object creation command*
      *                            were lost, when the object name was      *
      *                            overridden in the STRPREPRC section.     *
      *                                                                     *
      *  06.02.2017  Th.Raddatz    Changed interface of exit program.       *
      *                                                                     *
      *  15.09.2017  Th.Raddatz    Added parameter LIBL to STRPREPRC        *
      *                            command.                                 *
      *                            Added header tags 'LIBL' and 'CURLIB'    *
      *                            to STRPREPRC command.                    *
      *                            Added replacement variables &LL, &CL,    *
      *                            &LX and &CX to STRPREPRC utility.        *
      *                                                                     *
      *  16.09.2017  Th.Raddatz    Changed length of parameter CMD from     *
      *                            2048 to 8192.                            *
      *                                                                     *
      *  18.09.2017  Th.Raddatz    Fixed problem that 'cmdLongLength'       *
      *                            was not properly filled.                 *
      *                                                                     *
      *  20.09.2017  Th.Raddatz    Added parameter USELIBL to let STRPREPRC *
      *                            run the XCRTSQLOBJ command of CMOne      *
      *                            for source members without a STRPREPRC   *
      *                            header.                                  *
      *                            Renamed a couple of procedures for       *
      *                            better names.                            *
      *                                                                     *
      *  21.09.2017  Th.Raddatz    Fixed parameter length of replaceVar().  *
      *                                                                     *
      *  22.09.2017  Th.Raddatz    Added parameter USRDEFVAR to STRPREPRC   *
      *                            command.                                 *
      *                                                                     *
      *  19.11.2017  Th.Raddatz    Fixed bug in restoreLibraryList() to     *
      *                            restore the library list.                *
      *                                                                     *
      *  11.02.2019  Th.Raddatz    Replaced OVRDBF of module STRPREPRC1     *
      *                            with EXTFILE and EXTMBR in STRPREPRC2.   *
      *                            Moved checking of object existence to    *
      *                            STRPREPRC2.                              *
      *                            Moved handling the *DFT special value to *
      *                            STRPREPRC2.                              *
      *                                                                     *
      *  08.05.2019  Th.Raddatz    Added procedure readLine().              *
      *                                                                     *
      *  17.05.2019  Th.Raddatz    Added new tags for monitoring messages   *
      *                            of 'CMD' tags. The new tags are:         *
      *                              'CMD'  CHKOBJ FOO/BAR *FILE;           *
      *                              'MONMSG'                               *
      *                                'MSGID' CPF9801; // Object not found *
      *                              'END-MONMSG'                           *
      *                                                                     *
      *  26.04.2020  Th.Raddatz    Added 'INCLUDE' tag.                     *
      *                                                                     *
      *  23.12.2020  Th.Raddatz    Fixed content auf g_srcFile.* variables. *
      *                            Fixed error message when attempting to   *
      *                            execute an empty command.                *
      *                            Fixed decision when to append the job    *
      *                            log messages to the EVFEVENT file.       *
      *                            Added iRPGUnit test suite STRPREPRCT.    *
      *                                                                     *
      * =================================================================== *
      * >>PRE-COMPILER<<                                                    *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
      *                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
      *   >>IMPORTANT<<                                                     *
      *     >>PARM<< TRUNCNBR(*NO);                                         *
      *     >>PARM<< DBGVIEW(*LIST);                                        *
      *     >>PARM<< OPTION(*EVENTF);                                       *
      *   >>END-IMPORTANT<<                                                 *
      *   >>EXECUTE<<                                                       *
      * >>END-PRE-COMPILER<<                                                *
      * =================================================================== *
     H NOMAIN BNDDIR('QC2LE')
      /COPY QSTRPREPRC,H_SPEC
      /COPY QSTRPREPRC,COPYRIGHT
      * =================================================================== *
      *
      * -------------------------------------------------------------
      *  Verwendete Dateien
      * -------------------------------------------------------------
     FSRCFILE   IF   F  256        DISK    usropn
     F                                     extfile(g_useSrcFile.name)
     F                                     extmbr(g_useSrcFile.member)
     F                                     infds(f1)
     FINCLUDE   IF   F  256        DISK    usropn
     F                                     extfile(g_include.name)
     F                                     extmbr(g_include.member)
     F                                     infds(f3)
      *
     FSTRPRE1   IF   E           K DISK    usropn
     F                                     prefix(P1)
     F                                     extfile(g_strpre1.name)
     F                                     extmbr(g_strpre1.member)
     F                                     infds(f2)
      *
     D g_useSrcFile    ds                  qualified inz
     D  name                         21a   varying
     D  member                       10a   varying
      *
     D g_strpre1       ds                  qualified inz
     D  name                         21a   varying
     D  member                       10a   varying
      *
     D g_include       ds                  qualified inz
     D  name                         21a   varying
     D  member                       10a   varying
      *
     D cMaxRcdLen      c                   256
      *
     D ds_srcFile_t    ds                  qualified based(pDummy)
     D  srcSeq                             like(srcSeq_t)
     D  srcDat                             like(srcDat_t)
     D  srcDta                             like(srcDta_t)
      *
     D f1              ds                  qualified
     D  status                11     15S 0
     D  file                  83     92A
     D  lib                   93    102A
     D  rcdLen               125    126B 0
     D  mbr                  129    138A
     D  nbrOfKey             387    388B 0
     D  rcdNbr               397    400B 0
      *
     D f1_line_number  s             10i 0 inz(-1)
      *
     D f2              ds                  likeds(f1)
      *
     D f3              ds                  qualified
     D  status                11     15S 0
     D  file                  83     92A
     D  lib                   93    102A
     D  rcdLen               125    126B 0
     D  mbr                  129    138A
     D  nbrOfKey             387    388B 0
     D  rcdNbr               397    400B 0
      *
     D f3_line_number  s             10i 0 inz(-1)
      *
      * -------------------------------------------------------------
      *  Globale Referenzfelder
      * -------------------------------------------------------------
     D int4_t          s             10i 0 based(pDummy)
     D srcSeq_t        s              6s 2 based(pDummy)
     D srcDat_t        s              6s 0 based(pDummy)
     D srcDta_t        s            244a   based(pDummy)
     D srcFile_t       s             10a   based(pDummy)
     D srcLib_t        s             10a   based(pDummy)
     D srcMbr_t        s             10a   based(pDummy)
     D cmd_t           s           8192a   based(pDummy)
     D cmdLong_t       s          32702a   based(pDummy) varying
     D cmdLongFixLen_t...
     D                 s          32702a   based(pDummy)
     D bool_t          s               n   based(pDummy)
     D mode_t          s             30a   based(pDummy)
     D module_t        s             10a   based(pDummy)
     D pgm_t           s             10a   based(pDummy)
     D proc_t          s             64a   based(pDummy)
     D tag_t           s             30a   based(pDummy)
     D continue_t      s              1a   based(pDummy)
     D keyData_t       s           4096a   based(pDummy) varying
     D file_t          s             10a   based(pDummy)
     D lib_t           s             10a   based(pDummy)
     D mbr_t           s             10a   based(pDummy)
     D obj_t           s             10a   based(pDummy)
     D tgtRls_t        s             10a   based(pDummy)
     D typeCode_t      s              6a   based(pDummy)
     D userParm_t      s             50a   based(pDummy)
     D chgObjD_t       s              4a   based(pDummy)
     D objType_t       s             10a   based(pDummy)
      *
     D DIM_OPTIONS     c                   5
      *
     D option_t        ds                  based(pDummy) qualified
     D  numE                          5i 0
     D  option                       10a   dim(DIM_OPTIONS)
      *
     D DIM_USRDEFVARS  c                   20
      *
     D inpUsrDefVars_t...
     D                 ds          2282    qualified based(pDummy)
     D  numElem                       5i 0
     D  offsItems                     5i 0 dim(DIM_USRDEFVARS)
      *
     D inpUsrDefVar_t...
     D                 ds                  qualified based(pDummy)
     D  numE                          5i 0
     D  name                         10a
     D  value                       100a
      *
     D DIM_EXECOPTS    c                   3
      *
     D execOpt_t       ds                  qualified based(pDummy)
     D  numElem                       5i 0
     D  execOpt                      10a   dim(DIM_EXECOPTS)
      *
     D DIM_LIBLIST     c                   250
      *
     D inpLibList_t    ds                  qualified based(pDummy)
     D  numElem                       5i 0
     D  curLib                       10a
     D  offsUsrLibl                   5i 0
     D  numUsrLiblE                   5i 0
     D  lib                          10a   dim(DIM_LIBLIST)
      *
     D libl_t          ds                  qualified based(pDummy)
     D  numE                          5i 0
     D  name                               like(lib_t) dim(DIM_LIBLIST)
      *
     D liblList_t      ds                  qualified based(pDummy)
     D  curLib                             like(lib_t)
     D  usrLibl                            likeds(libl_t)
      *
     D usrDefVars_t    ds                  qualified based(pDummy)
     D  numE                          5i 0
     D  var                                likeds(usrDefVar_t)
     D                                     dim(DIM_USRDEFVARS)
      *
     D usrDefVar_t     ds                  qualified based(pDummy)
     D  name                         10a
     D  value                       100a
      *
     D lineData_t      ds                  qualified based(pDummy)
     D  continue                           like(continue_t)
     D  keyData                            like(keyData_t)
      *
     D monMsgIds_t     ds                  qualified based(pDummy)
     D  item                               like(msgId_t) dim(50)
      *
     D variables_t     ds                  qualified based(pDummy)
     D  lib                                like(lib_t)
     D  obj                                like(obj_t)
     D  typeCode                           like(typeCode_t)
     D  srcLib                             like(srcLib_t)
     D  srcFile                            like(srcFile_t)
     D  srcMbr                             like(srcMbr_t)
     D  testLib                            like(lib_t)
     D  testObj                            like(obj_t)
     D  tgtRls                             like(tgtRls_t)
     D  frmSrcLib                          like(srcLib_t)
     D  frmSrcFile                         like(srcFile_t)
     D  frmSrcMbr                          like(srcMbr_t)
     D  user0                              like(userParm_t)
     D  user1                              like(userParm_t)
     D  user2                              like(userParm_t)
     D  user3                              like(userParm_t)
     D  user4                              like(userParm_t)
     D  user5                              like(userParm_t)
     D  user6                              like(userParm_t)
     D  user7                              like(userParm_t)
     D  user8                              like(userParm_t)
     D  user9                              like(userParm_t)
     D  libl                               likeds(liblList_t)
     D  usrDefVars                         likeds(usrDefVars_t)
     D  useLibl                            like(bool_t)
     D  prvLibl                            likeds(liblList_t)
      *
      * -------------------------------------------------------------
      *  Globale Konstanten
      * -------------------------------------------------------------
     D cNone           c                   '*NONE'
      *
      *  Nachrichtenkonstanten
     D cTYPE_DIAG      c                   '*DIAG'
     D cTYPE_ESCAPE    c                   '*ESCAPE'
      *
      *  Pre-Prozessor Tags
     D cTAG_PREPRZ     c                   '>>PRE-COMPILER<<'
     D cTAG_ENDPREPRZ  c                   '>>END-PRE-COMPILER<<'
      *
     D cTAG_LINK       c                   '>>LINK<<'
     D cTAG_ENDLINK    c                   '>>END-LINK<<'
      *
     D cTAG_COMPILE    c                   '>>COMPILE<<'
     D cTAG_ENDCOMPILE...
     D                 c                   '>>END-COMPILE<<'
      *
     D cTAG_IMPORTANT  c                   '>>IMPORTANT<<'
     D cTAG_ENDIMPORTANT...
     D                 c                   '>>END-IMPORTANT<<'
      *
     D cTAG_MONMSG     c                   '>>MONMSG<<'
     D cTAG_MSGID      c                   '>>MSGID<<'
     D cTAG_ENDMONMSG...
     D                 c                   '>>END-MONMSG<<'
      *
     D cTAG_WIDTH      c                   '>>WIDTH<<'
     D cTAG_CRTCMD     c                   '>>CRTCMD<<'
     D cTAG_PARM       c                   '>>PARM<<'
     D cTAG_EXECUTE    c                   '>>EXECUTE<<'
     D cTAG_CMD        c                   '>>CMD<<'
     D cTAG_INCLUDE    c                   '>>INCLUDE<<'
     D cTAG_LIBL       c                   '>>LIBL<<'
     D cTAG_CURLIB     c                   '>>CURLIB<<'
      *
      *  Pre-Prozessor Modi
     D cMODE_SCAN      c                   '*SCAN'
     D cMODE_PREPRZ    c                   '>>PRE-COMPILER<<'
     D cMODE_ENDPREPRZ...
     D                 c                   '*EXIT'
      *
     D cMODE_LINK      c                   '>>LINK<<'
     D cMODE_ENDLINK   c                   '>>END-LINK<<'
      *
     D cMODE_COMPILE   c                   '>>COMPILE<<'
     D cMODE_ENDCOMPILE...
     D                 c                   '>>END-COMPILE<<'
      *
     D cMODE_IMPORTANT...
     D                 c                   '>>IMPORTANT<<'
     D cMODE_ENDIMPORTANT...
     D                 c                   '>>END-IMPORTANT<<'
      *
     D cMODE_MONMSG    c                   '>>MONMSG<<'
     D cMODE_MSGID     c                   '>>MSGID<<'
     D cMODE_ENDMONMSG...
     D                 c                   '>>END-MONMSG<<'
      *
     D cMODE_WIDTH     c                   '>>WIDTH<<'
     D cMODE_CRTCMD    c                   '>>CRTCMD<<'
     D cMODE_PARM      c                   '>>PARM<<'
     D cMODE_EXECUTE   c                   '>>EXECUTE<<'
     D cMODE_CMD       c                   '>>CMD<<'
     D cMODE_INCLUDE   c                   '>>INCLUDE<<'
     D cMODE_LIBL      c                   '>>LIBL<<'
     D cMODE_CURLIB    c                   '>>CURLIB<<'
      *
      *  Zeilenendemarkierungen
     D cNEW_LINE       c                   ' '
     D cTRUNC_CONT     c                   '+'
     D cCONT           c                   '-'
     D cEND_OF_LINE    c                   ';'
      *
     D cEVENTF_NO      c                   '*NOEVENTF'
     D cEVENTF_YES     c                   '*EVENTF'
      *
     D cJOBLOG_NO      c                   '*NOJOBLOG'
     D cJOBLOG_YES     c                   '*ADDJOBLOG'
      *
     D EXEC_ALL        c                   '*ALL'
     D EXEC_PRECMDS    c                   '*PRECMDS'
     D EXEC_CRTCMD     c                   '*CRTCMD'
     D EXEC_POSTCMDS   c                   '*POSTCMDS'
      *
     D CURLIB_CRTDFT   c                   '*CRTDFT'
      * -------------------------------------------------------------
      *  Globale Variablen
      * -------------------------------------------------------------
     D g_msgFile       s                   like(msg_t.file) inz
     D g_mode          s                   like(mode_t) dim(10) inz
     D g_modeCnt       s                   like(int4_t) inz
     D g_pgmCmdExc...
     D                 s                   like(pgm_t) inz
     D g_libPgmCmdExc  s                   like(lib_t) inz
     D g_width         s             10i 0 inz(-1)
      *
     D g_eventf        ds                  qualified
     D  isOpen                         n   inz(cFalse)
     D  mbr                          10a   inz
     D  lib                          10a   inz('*N')
      *
     D g_option        ds                  qualified inz
     D  isEventf                       n   inz(cFalse)
     D  doAppendJobLog...
     D                                 n   inz(cFalse)
      *
     D g_enforceJobLogOnError...
     D                 s               n
      *
     D g_execOpt...
     D                 ds                  likeds(execOpt_t)
      *
     D g_srcFile       ds                  qualified
     D  name                         10a
     D  lib                          10a
     D  mbr                          10a
      *
      * Known creation commands and their object name keywords
     D g_crtCmds       ds                  qualified based(g_pCrtCmds) dim(22)
     D  cmd                          10a
     D  reserved_1                    2a
     D  keyword                      10a
     D  reserved_2                    2a
     D  text                         50a
      *
     D g_crtCmdsDta    s             74a   dim(22) ctdata
     D g_pCrtCmds      s               *   inz(%addr(g_crtCmdsDta))
      *
     D g_startUpLiblList...
     D                 ds                  likeds(liblList_t) inz
      *
     D g_prePostCmdsMode...
     D                 s             10i 0
      *
     D MODE_PRECMDS    c                   1
     D MODE_EXECUTE    c                   2
     D MODE_POSTCMDS   c                   3
      *
      /copy QSTRPREPRC,SDS
      *
      * -------------------------------------------------------------
      *  Importierte Prototypen
      * -------------------------------------------------------------
      /copy QSTRPREPRC,QMHRCVPM
      /copy QSTRPREPRC,QMHRMVPM
      /copy QBASICS1,PBASICS1
      /copy QSTRPREPRC,PROTO_H
      /copy QSTRPREPRC,QCAPCMD
      /copy QSTRPREPRC,QWCRTVCA
      /copy QEVENTF,PEVENTF
      *
      * -------------------------------------------------------------
      *  Prototypen
      * -------------------------------------------------------------
     D STRPREPRC...
     D                 pr
     D  i_useSrcFile                              like(srcFile_t)
     D  i_useSrcLib                               like(srcLib_t)
     D  i_useSrcMbr                               like(srcMbr_t)
     D  i_cmd                                     like(cmd_t)
     D  i_chgObjD                                 like(chgObjD_t)
     D  i_objType                                 like(objType_t)
     D  i_objSrcFile                              like(file_t)
     D  i_objSrcLib                               like(lib_t)
     D  i_objSrcMbr                               like(mbr_t)
     D  i_lib                                     like(lib_t)
     D  i_obj                                     like(obj_t)
     D  i_typeCode                                like(typeCode_t)
     D  i_srcLib                                  like(lib_t)
     D  i_srcFile                                 like(file_t)
     D  i_srcMbr                                  like(mbr_t)
     D  i_testLib                                 like(lib_t)
     D  i_testObj                                 like(obj_t)
     D  i_tgtRls                                  like(tgtRls_t)
     D  i_frmSrcLib                               like(lib_t)
     D  i_frmSrcFile                              like(file_t)
     D  i_frmSrcMbr                               like(mbr_t)
     D  i_user0                                   like(userParm_t)
     D  i_user1                                   like(userParm_t)
     D  i_user2                                   like(userParm_t)
     D  i_user3                                   like(userParm_t)
     D  i_user4                                   like(userParm_t)
     D  i_user5                                   like(userParm_t)
     D  i_user6                                   like(userParm_t)
     D  i_user7                                   like(userParm_t)
     D  i_user8                                   like(userParm_t)
     D  i_user9                                   like(userParm_t)
     D  i_tagsReq                                 like(bool_t)
     D  i_msgFile                                 like(msg_t.file)
     D  i_msgFileLib                              like(msg_t.lib)
     D  i_pgmCmdExc...
     D                                            like(pgm_t)
     D  i_libPgmCmdExc...
     D                                            like(lib_t)
     D  i_option                                  likeds(option_t)
     D  i_libl                                    likeds(inpLibList_t)
     D  i_useLibl                                 like(bool_t)
     D  i_usrDefVars                              likeds(inpUsrDefVars_t)
     D  i_execOpt                                 likeds(execOpt_t)
      *
     D readLine...
     D                 pr              n
     D                                     extproc('readLine')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      *
     D readPrvLine...
     D                 pr              n
     D                                     extproc('readPrvLine')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      *
     D getSpcValDft...
     D                 pr                  like(keyData_t)
     D                                     extproc('getValue')
     D  i_actual                           const like(keyData_t)
     D                                     options(*varsize)
     D  i_default                          const like(keyData_t)
     D                                     options(*varsize)
      *
     D restoreLibraryList...
     D                 pr
     D                                     extproc('restoreLibraryList')
      *
     D resetLineData...
     D                 pr
     D                                     extproc('resetLineData')
     D  io_lineData                        likeds(lineData_t)
      *
     D replaceVars...
     D                 pr                  like(cmdLong_t)
     D                                     extproc('replaceVars')
     D  i_cmd                              value  like(cmdLong_t)
     D  i_variables                        value  likeds(variables_t)
      *
     D libListToStr...
     D                 pr                  like(cmdLong_t)
     D                                     extproc('libListToStr')
     D  i_libl                             value  likeds(libl_t)
      *
     D performExecute...
     D                 PR
     D                                     extproc('performExecute')
     D  i_cmd                              value  like(cmdLong_t)
     D  i_cmdChgObjD                       value  like(cmdLong_t)
      *
     D performCmd...
     D                 PR
     D                                     extproc('performCmd')
     D  i_cmd                              value  like(cmdLong_t)
      *
     D performInclude...
     D                 PR
     D                                     extproc('performInclude')
     D  i_include                          value  like(cmdLong_t)
      *
     D performSetLibraryList...
     D                 pr
     D                                     extproc('performSetLibraryList')
     D  i_libl                             value  like(cmdLong_t)
     D  io_variables                              likeds(variables_t)
      *
     D performSetCurrentLibrary...
     D                 pr
     D                                     extproc('performSetCurrentLibrary')
     D  i_libl                             value  like(cmdLong_t)
     D  io_variables                              likeds(variables_t)
      *
     D loadMonitoredMessageIDs...
     D                 pr                  likeds(monMsgIds_t)
     D                                     extproc('loadMonitoredMessageIDs')
      *
     D isMonitoredMessageID...
     D                 pr              n
     D                                     extproc('isMonitoredMessageID')
     D  i_errMsgId                         value like(msgId_t)
     D  i_monMsgIds                        value likeds(monMsgIds_t)
      *
     D isExecOpt...
     D                 pr              n
     D                                     extproc('isExecOpt')
     D  i_execOpt                          value like(execOpt_t.execOpt)
      *
     D retrieveLibraryList...
     D                 pr                  likeds(liblList_t)
     D                                     extproc('retrieveLibraryList')
      *
     D retrieveEventFile...
     D                 pr                  likeds(qObj_t)
     D                                     extproc('retrieveEventFile')
     D  i_cmd                              value  like(cmdLong_t)
      *
     D addData...
     D                 PR                  like(keyData_t)
     D                                     extproc('addData')
     D  i_tag                              value  like(tag_t)
     D  i_keyData                          value  like(keyData_t)
     D  i_srcDta                           value  like(srcDta_t)
     D  io_continue                               like(continue_t)
      *
     D getWidthValue...
     D                 PR            10i 0
     D                                     extproc('getWidthValue')
     D  i_srcDta                           value  like(srcDta_t)
     D  i_length                     10i 0 value
      *
     D replaceCmdKeyWord...
     D                 PR                         like(cmdLong_t)
     D                                     extproc('replaceCmdKeyWord')
     D  i_cmd                              value  like(cmdLong_t)
     D  i_keyData                          value  like(keyData_t)
      *
     D getSrcDataLength...
     D                 PR                         like(int4_t)
     D                                     extproc('getSrcDataLength')
      *
     D getStartPos...
     D                 PR                         like(int4_t)
     D                                     extproc('getStartPos')
     D  i_tag                              value  like(tag_t)
     D  i_srcDta                                  like(srcDta_t)
      *
     D isTag...
     D                 PR                         like(bool_t)
     D                                     extproc('isTag')
     D  i_srcDta                           value  like(srcDta_t)
     D  o_tag                                     like(tag_t)
      *
     D retrieveTag...
     D                 PR                         like(bool_t)
     D                                     extproc('retrieveTag')
     D  i_tagToTest                        value  like(tag_t)
     D  i_srcDta                           value  like(srcDta_t)
     D  o_tag                                     like(tag_t)
      *
     D tagToMode...
     D                 PR                         like(mode_t)
     D                                     extproc('tagToMode')
     D  i_tag                              value  like(tag_t)
      *
     D checkMode...
     D                 PR              n
     D                                     extproc('checkMode')
     D  i_mode                             value  like(mode_t)
     D  i_newMode                          value  like(mode_t)
      *
     D pushMode...
     D                 PR
     D                                     extproc('pushMode')
     D  i_mode                             value  like(mode_t)
      *
     D popMode...
     D                 PR                         like(mode_t)
     D                                     extproc('popMode')
      *
     D sendMsg...
     D                 PR
     D                                     extproc('sendMsg')
     D  i_msg                              value  likeds(msg_t)
      *
     D validateCmd...
     D                 PR                         like(bool_t)
     D                                     extproc('validateCmd')
     D  i_cmd                              value  like(cmdLong_t)
      *
     D executeCmd...
     D                 PR                         like(bool_t)
     D                                     extproc('executeCmd')
     D  i_monErr                           value  like(bool_t)
     D  i_cmd                              value  like(cmdLong_t)
     D  o_errMsgId                                like(msgId_t) options(*nopass)
      *
     D appendToJobLog...
     D                 PR
     D                                     extproc('appendToJobLog')
     D  i_message                          value  like(cmdLong_t)
      *
     D formatCmd...
     D                 PR                         like(cmdLong_t)
     D                                     extproc('formatCmd')
     D  i_cmd                              value  like(cmdLong_t)
      *
     D endAbnormal...
     D                 PR
     D                                     extproc('endAbnormal')
     D  i_qEventf                          const  likeds(qObj_t)
     D                                     options(*nopass)
      *
     D endOK...
     D                 PR
     D                                     extproc('endOK')
     D  i_qEventf                          const  likeds(qObj_t)
     D                                     options(*nopass)
      *
     D writeJobLogToEventf...
     D                 PR
     D                                     extproc('writeJobLogToEventf')
     D  i_qEventf                          const  likeds(qObj_t)
     D  i_isAbnEnd                     n   const
      *
     D replaceVar...
     D                 PR
     D                                     extproc('replaceVar')
     D  i_var                        10a   value
     D  i_value                            value  like(cmdLong_t)
     D  io_string                                 like(cmdLong_t)
      *
     D chkMbr...
     D                 PR                  extproc('chkMbr')
     D  i_file                       10a   const
     D  i_lib                        10a   const
     D  i_mbr                        10a   const
      *
     D removeFileOpenmessage...
     D                 pr                  extproc('removeFileOpenmessage')
      *
     D getMsgInf...
     D                 PR
     D                                     extproc('getMsgInf')
     D  i_pgm                              value  like(pgm_t)
     D  i_module                           value  like(module_t)
     D  i_proc                             value  like(proc_t)
     D  i_msgId                            value  like(msgID_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msg_t.data)
     D  o_msgFile                                 like(msg_t.file)
     D  o_msgLib                                  like(msg_t.lib)
      *
      *
      *  Register Call Stack Entry Termination User Exit Procedure (CEERTX)
     d CEERTX...
     d                 pr                         extproc('CEERTX')
     d  i_procPtr                      *   const  procptr
     d  i_rtxToken                     *   const  options(*omit)
     d  o_fc                         12a          options(*omit)
      *
     d abnormalEndHandler...
     d                 pr                         extproc('abnormalEndHandler')
     d  i_rtxToken                     *   const
      *
      *  Unregister Call Stack Entry Termination User Exit Procedure (CEEUTX)
     d CEEUTX...
     d                 pr                         extproc('CEEUTX')
     d  i_procPtr                      *   const  procptr
     d  o_fc                         12a          options(*omit)
      *
      * =============================================================
      *  Ausführen Pre-Prozessor
      * =============================================================
     P STRPREPRC...
     P                 B                   export
     D                 PI
     D  i_useSrcFile                              like(srcFile_t)
     D  i_useSrcLib                               like(srcLib_t)
     D  i_useSrcMbr                               like(srcMbr_t)
     D  i_cmd                                     like(cmd_t)
     D  i_chgObjD                                 like(chgObjD_t)
     D  i_objType                                 like(objType_t)
     D  i_objSrcFile                              like(file_t)
     D  i_objSrcLib                               like(lib_t)
     D  i_objSrcMbr                               like(mbr_t)
     D  i_lib                                     like(lib_t)
     D  i_obj                                     like(obj_t)
     D  i_typeCode                                like(typeCode_t)
     D  i_srcLib                                  like(lib_t)
     D  i_srcFile                                 like(file_t)
     D  i_srcMbr                                  like(mbr_t)
     D  i_testLib                                 like(lib_t)
     D  i_testObj                                 like(obj_t)
     D  i_tgtRls                                  like(tgtRls_t)
     D  i_frmSrcLib                               like(lib_t)
     D  i_frmSrcFile                              like(file_t)
     D  i_frmSrcMbr                               like(mbr_t)
     D  i_user0                                   like(userParm_t)
     D  i_user1                                   like(userParm_t)
     D  i_user2                                   like(userParm_t)
     D  i_user3                                   like(userParm_t)
     D  i_user4                                   like(userParm_t)
     D  i_user5                                   like(userParm_t)
     D  i_user6                                   like(userParm_t)
     D  i_user7                                   like(userParm_t)
     D  i_user8                                   like(userParm_t)
     D  i_user9                                   like(userParm_t)
     D  i_tagsReq                                 like(bool_t)
     D  i_msgFile                                 like(msg_t.file)
     D  i_msgFileLib                              like(msg_t.lib)
     D  i_pgmCmdExc...
     D                                            like(pgm_t)
     D  i_libPgmCmdExc...
     D                                            like(lib_t)
     D  i_option                                  likeds(option_t)
     D  i_libl                                    likeds(inpLibList_t)
     D  i_useLibl                                 like(bool_t)
     D  i_usrDefVars                              likeds(inpUsrDefVars_t)
     D  i_execOpt                                 likeds(execOpt_t)
      *
      *  Nachrichten
      *  ... Falsche Reihenfolge im Betriebsmodus.
      /COPY QSTRPREPRC,PRZ0001
      *  ... Die Datensatzlänge der Eingabedatei ist zu lang.
      /COPY QSTRPREPRC,PRZ0011
      *  ... Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.
      /COPY QSTRPREPRC,PRZ0012
      *  ... Fehler beim Öffnen der Steuerdatei &2/&1, Teildatei &3.
      /COPY QSTRPREPRC,PRZ0013
      *  ... Auszuführender Befehl fehlt. Weitere Verarbeitung nich . . .
      /COPY QSTRPREPRC,PRZ0014
      *  ... Keine Pre-Compiler Anweisungen in Quellendatei &2/&1, Teildatei &3 gefunden.
      /COPY QSTRPREPRC,PRZ0024
      *  ... EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konnte nicht geöffnet
      /COPY QSTRPREPRC,PRZ0025
      *  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
      /COPY QSTRPREPRC,PRZ0026
      *  ... Erstellungsbefehl nicht gefunden in Quellendatei &2/&1, Teildatei &3.
      /COPY QSTRPREPRC,PRZ0028
      *  ... Die Option *ADDJOBLOG ist nur in Verbindung mit *EVENTF zulässig.
      /COPY QSTRPREPRC,PRZ0030
      *
      *  Arbeitsfelder
     D i               S             10i 0 inz
     D srcDta          S                   like(ds_srcFile_t.srcDta)
     D tag             S                   like(tag_t) inz
     D mode            S                   like(mode_t) inz
     D newMode         S                   like(mode_t) inz
     D cmdString       S                   like(cmdLong_t) inz
     D execCmdImplizit...
     D                 S                   like(bool_t)  inz(cTrue)
     D foundPrePrcTags...
     D                 S                   like(bool_t)  inz(cFalse)
     D cmdChgObjD      S                   like(cmdLong_t)
     D cmd             S                   like(cmdLong_t)
     D isCmdMissingError...
     D                 S               n   inz(cFalse)
     D isMonMsgAllowed...
     D                 S               n   inz(cFalse)
      *
     D lineData        ds                  likeds(lineData_t) inz
     D variables       ds                  likeds(variables_t) inz
     D inpUsrDefVar    ds                  likeds(inpUsrDefVar_t)
     D                                     based(pInpUsrDefVar)
     D objSrcFile      s                   like(i_objSrcFile)
     D objSrcLib       s                   like(i_objSrcLib)
     D objSrcMbr       s                   like(i_objSrcMbr)
      /free

         ceertx(%paddr('abnormalEndHandler'): *omit: *omit);

         p_setAppMsgFile(i_msgFile: i_msgFileLib);

         g_startUpLiblList = retrieveLibraryList();

         g_prePostCmdsMode = MODE_PRECMDS;

         // Initialisieren globaler Variablen
         reset g_msgFile;
         reset g_mode;
         reset g_modeCnt;
         reset g_pgmCmdExc;
         reset g_libPgmCmdExc;
         reset g_eventf;
         reset g_option;
         reset g_execOpt;
         g_msgFile = i_msgFile;
         g_pgmCmdExc = i_pgmCmdExc;
         g_libPgmCmdExc = i_libPgmCmdExc;

         g_srcFile.name = getSpcValDft(i_srcFile: i_useSrcFile);
         g_srcFile.lib = getSpcValDft(i_srcLib: i_useSrcLib);
         g_srcFile.mbr = getSpcValDft(i_srcMbr: i_useSrcMbr);

         g_enforceJobLogOnError = *on;

         if (%parms() >= 36 and i_option.numE > 0);
            for i = 1 to i_option.numE;
               select;
               when (i_option.option(i) = cEVENTF_YES);
                  g_option.isEventf = cTrue;
                  g_eventf.mbr = i_obj;
                  g_eventf.lib = i_lib;
               when (i_option.option(i) = cEVENTF_NO);
                  g_option.isEventf = cFalse;
               when (i_option.option(i) = cJOBLOG_YES);
                  g_option.doAppendJobLog = cTrue;
               when (i_option.option(i) = cJOBLOG_NO);
                  g_option.doAppendJobLog = cFalse;
               endsl;
            endfor;
         endif;

         if (g_option.doAppendJobLog and not g_option.isEventf);
            clear PRZ0030;
            sendMsg(f_newMsg('PRZ0030': PRZ0030: cTYPE_DIAG));
            endAbnormal();
         endif;

         if (g_option.isEventf);
            monitor;
               enableEventFile();
               clearEventFile(g_eventf.mbr: g_eventf.lib);
               prepareEventFile();
            on-error;
               clear PRZ0026;
               sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_ESCAPE));
               endAbnormal();
            endmon;
         endif;

         g_execOpt = i_execOpt;

         clear variables;
         variables.lib = i_lib;
         variables.obj =
            getSpcValDft(getSpcValDft(i_obj: i_srcMbr): i_useSrcMbr);
         variables.typeCode = i_typeCode;
         variables.srcLib = getSpcValDft(i_srcLib: i_useSrcLib);
         variables.srcFile = getSpcValDft(i_srcFile: i_useSrcFile);
         variables.srcMbr = getSpcValDft(i_srcMbr: i_useSrcMbr);
         variables.testLib = i_testLib;
         variables.testObj = i_testObj;
         variables.tgtRls = i_tgtRls;
         variables.frmSrcLib = i_frmSrcLib;
         variables.frmSrcFile = i_frmSrcFile;
         variables.frmSrcMbr = i_frmSrcMbr;
         variables.user0 = i_user0;
         variables.user1 = i_user1;
         variables.user2 = i_user2;
         variables.user3 = i_user3;
         variables.user4 = i_user4;
         variables.user5 = i_user5;
         variables.user6 = i_user6;
         variables.user7 = i_user7;
         variables.user8 = i_user8;
         variables.user9 = i_user9;
         variables.libl = i_libl;
         variables.useLibl = i_useLibl;

         variables.libl.curLib = i_libl.curLib;
         variables.libl.usrLibl.numE = 0;
         for i = 1 to i_libl.numUsrLiblE;
            variables.libl.usrLibl.numE += 1;
            variables.libl.usrLibl.name(variables.libl.usrLibl.numE) =
               i_libl.lib(i);
         endfor;

         variables.prvLibl = i_libl.curLib;
         variables.prvLibl.usrLibl.numE = 0;

         for i = 1 to i_usrDefVars.numElem;
            pInpUsrDefVar = %addr(i_usrDefVars) + i_usrDefVars.offsItems(i);
            variables.usrDefVars.numE += 1;
            variables.usrDefVars.var(variables.usrDefVars.numE).name =
               inpUsrDefVar.name;
            variables.usrDefVars.var(variables.usrDefVars.numE).value =
               inpUsrDefVar.value;
         endfor;

         if (i_chgObjD = '*YES');

            objSrcFile = getSpcValDft(i_objSrcFile: i_srcFile);
            objSrcLib = getSpcValDft(i_objSrcLib: i_srcLib);
            objSrcMbr = getSpcValDft(i_objSrcMbr: i_srcMbr);

            cmdChgObjD =
               'CHGOBJDA +
                   OBJ(' + %trim(i_lib) + '/' + %trim(i_obj) + ') +
                   OBJTYPE(' + %trim(i_objType) + ') +
                   SRCF(' + %trim(objSrcFile) + ') +
                   SRCFLIB(' + %trim(objSrcLib) + ') +
                   SRCMBR(' + %trim(objSrcMbr) + ') +
                   SRCDATE(' + %trim('*SRCMBR') + ') +
                   SRCTIME(' + %trim('*SRCMBR') + ')';
         else;
            cmdChgObjD = '';
         endif;

         chkMbr(i_useSrcFile: i_useSrcLib: i_useSrcMbr);

         g_useSrcFile.name = %trim(i_useSrcLib) + '/' + %trim(i_useSrcFile);
         g_useSrcFile.member = %trim(i_useSrcMbr);

         open(E) SRCFILE;
         if (%error());
            clear PRZ0012;
            PRZ00121 = i_useSrcFile;
            PRZ00122 = i_useSrcLib;
            PRZ00123 = i_useSrcMbr;
            sendMsg(f_newMsg('PRZ0012': PRZ0012: cTYPE_DIAG));
            endAbnormal();
         endif;

         g_strpre1.name = %trim(sds.pgmLib) + '/' + 'STRPRE1';
         g_strpre1.member = '*FIRST';

         open(E) STRPRE1;
         if (%error());
            clear PRZ0013;
            PRZ00131 = 'STRPRE1';
            PRZ00132 = '*LIBL';
            PRZ00133 = '*FIRST';
            sendMsg(f_newMsg('PRZ0013': PRZ0013: cTYPE_DIAG));
            endAbnormal();
         endif;

         // Entfernen der "Öffnen" Nachrichten
         p_rmvPgmMsg(cMsg_Rmv_All);

         // Prüfen der Datensatzlänge
         if (f1.rcdLen > cMaxRcdLen);
            clear PRZ0011;
            PRZ00111 = f1.rcdLen;
            PRZ00112 = cMaxRcdLen;
            PRZ00113 = f1.lib;
            PRZ00114 = f1.file;
            sendMsg(f_newMsg('PRZ0011': PRZ0011: cTYPE_DIAG));
            endAbnormal();
         endif;

         // Formatieren Befehl
         cmd = formatCmd(%trim(i_cmd));

         // Initialisieren Modus
         mode = cMODE_SCAN;
         pushMode(mode);

         // Initialisieren "Ausführen Befehl implizit"
         // Der Erstellungsbefehl wird ohne Pre-Prozessor
         // Abschnitt ausgeführt
         execCmdImplizit = cTrue;

         // Initialisieren "STRPREPRC" Anweisungen gefunden
         foundPrePrcTags = cFalse;

         // Initialisieren Fortsetzungszeile
         resetLineData(lineData);

         // Lesen der Quellenteildatei
         f1_line_number = 0;

         dow readLine(srcDta);

            // Wenn sich in der Programmzeile ein Tag befindet, ...
            if (isTag(srcDta: tag));

               // ermitteln neue Betriebsart
               newMode = tagToMode(tag);

               // prüfen Betriebsartenwechsel
               if (not checkMode(mode: newMode));
                  endAbnormal();
               endif;

               if (newMode = cMODE_MONMSG);
                  if (not isMonMsgAllowed);
                     clear PRZ0001;
                     PRZ00011 = mode;
                     PRZ00012 = newMode;
                     sendMsg(f_newMsg('PRZ0001': PRZ0001: cTYPE_DIAG));
                     endAbnormal();
                  endif;
               endif;

               if (newMode = cMODE_CMD);
                  isMonMsgAllowed = cTrue;
               else;
                  isMonMsgAllowed = cFalse;
               endif;

               // umschalten Betriebsartenwechsel
               mode = newMode;

               // Betriebsart merken
               pushMode(mode);
            else;
               // ... Standardverarbeitung
            endif;

            // Anfang der Pre-Prozessoranweisungen
            if (mode = cMODE_PREPRZ);
               foundPrePrcTags = cTrue;
               execCmdImplizit = cFalse;
               iter;
            endif;

            // Ende der Pre-Prozessoranweisungen
            if (mode = cMODE_ENDPREPRZ);
               mode = popMode;
               mode = popMode;
               leave;
            endif;

            // Ende der Link Parameter
            if (mode = cMODE_ENDLINK);
               mode = popMode;
               mode = popMode;
               iter;
            endif;

            // Ende der Compile Parameter
            if (mode = cMODE_ENDCOMPILE);
               mode = popMode();
               mode = popMode();
               iter;
            endif;

            // Ende der Important Parameter
            if (mode = cMODE_ENDIMPORTANT);
               mode = popMode();
               mode = popMode();
               iter;
            endif;

            // Ende MONMSG
            if (mode = cMODE_ENDMONMSG);
               mode = popMode();
               mode = popMode();
               iter;
            endif;

            // Breite der Quellenangaben >>WIDTH<<
            if (mode  = cMODE_WIDTH);
               g_width = getWidthValue(srcDta: getSrcDataLength());
               mode = popMode();
            endif;

            // Erstellungsbefehl   >>CRTCMD<<
            if (mode  = cMODE_CRTCMD);
               // eintragen Erstellungsbefehl
               lineData.keyData = addData(cTAG_CRTCMD
                                          : lineData.keyData
                                          : srcDta
                                          : lineData.continue);

               // prüfen auf Fortsetzungszeile
               if (lineData.continue <> cEND_OF_LINE);
                  iter;
               else;
                  if (cmd = '');
                     cmd = lineData.keyData;
                  endif;
                  resetLineData(lineData);
                  mode = popMode();
                  iter;
               endif;
            endif;

            // MsgID-Anweisung     >>MSGID<<
            if (mode = cMODE_MSGID);
               // Ignore >>MSGID<< tags not related to >>CMD<<
               mode = popMode();
               iter;
            endif;

            // Parm-Anweisung      >>PARM<<
            if (mode = cMODE_PARM);
               if (cmd = '');
                  clear PRZ0014;
                  sendMsg(f_newMsg('PRZ0014': PRZ0014: cTYPE_DIAG));
                  endAbnormal();
               endif;

               // zufügen Schlüsselwortdaten
               lineData.keyData = addData(cTAG_PARM
                                          : lineData.keyData
                                          : srcDta
                                          : lineData.continue );

               // prüfen auf Fortsetzungszeile
               if (lineData.continue <> cEND_OF_LINE);
                  iter;
               else;
                  cmd = replaceCmdKeyWord(cmd: lineData.keyData);
                  resetLineData(lineData);
                  mode = popMode();
                  iter;
               endif;
            endif;

            // Execute-Anweisung   >>EXECUTE<<
            if (mode = cMODE_EXECUTE);
               performExecute(replaceVars(cmd: variables): cmdChgObjD);
               mode = popMode();
               iter;
            endif;

            // Befehl-Anweisung    >>CMD<<
            if (mode = cMODE_CMD);
               // zufügen Schlüsselwortdaten
               lineData.keyData = addData(cTAG_CMD
                                          : lineData.keyData
                                          : srcDta
                                          : lineData.continue);

               // prüfen auf Fortsetzungszeile
               if (lineData.continue <> cEND_OF_LINE);
                  iter;
               else;
                  performCmd(replaceVars(lineData.keyData: variables));
                  resetLineData(lineData);
                  mode = popMode();
                  iter;
               endif;
            endif;

            // Befehl-Anweisung    >>INCLUDE<<
            if (mode = cMODE_INCLUDE);
               // zufügen Schlüsselwortdaten
               lineData.keyData = addData(cTAG_INCLUDE
                                          : lineData.keyData
                                          : srcDta
                                          : lineData.continue);

               // prüfen auf Fortsetzungszeile
               if (lineData.continue <> cEND_OF_LINE);
                  iter;
               else;
                  performInclude(lineData.keyData);
                  resetLineData(lineData);
                  mode = popMode();
                  iter;
               endif;
            endif;

            // Befehl-Anweisung    >>LIBL<<
            if (mode = cMODE_LIBL);
               // zufügen Schlüsselwortdaten
               lineData.keyData = addData(cTAG_LIBL
                                          : lineData.keyData
                                          : srcDta
                                          : lineData.continue);

               // prüfen auf Fortsetzungszeile
               if (lineData.continue <> cEND_OF_LINE);
                  iter;
               else;
                  cmdString = 'CHGLIBL LIBL(' + lineData.keyData + ')';
                  performSetLibraryList(
                     replaceVars(cmdString: variables): variables);
                  resetLineData(lineData);
                  mode = popMode();
                  iter;
               endif;
            endif;

            // Befehl-Anweisung    >>CURLIB<<
            if (mode = cMODE_CURLIB);
               // zufügen Schlüsselwortdaten
               lineData.keyData = addData(cTAG_CURLIB
                                          : lineData.keyData
                                          : srcDta
                                          : lineData.continue);

               // prüfen auf Fortsetzungszeile
               if (lineData.continue <> cEND_OF_LINE);
                  iter;
               else;
                  cmdString = 'CHGLIBL CURLIB(' + lineData.keyData + ')';
                  performSetCurrentLibrary(
                     replaceVars(cmdString: variables): variables);
                  resetLineData(lineData);
                  mode = popMode();
                  iter;
               endif;
            endif;

         enddo;

         if (%open(SRCFILE));
            close SRCFILE;
         endif;

         if (%open(STRPRE1));
            close STRPRE1;
         endif;

         if (%open(INCLUDE));
            close INCLUDE;
         endif;

         // Ausführen >>EXECUTE<< implizit, weil
         // kein Pre-Prozessor Abschnitt gefunden werden konnte
         isCmdMissingError = cFalse;
         if (execCmdImplizit = cTrue);
            if (cmd = '');
               isCmdMissingError = cTrue;
            else;

               if (i_useLibl);
                  // Set library list
                  if (variables.libl.usrLibl.numE >= 1);
                     cmdString = 'CHGLIBL LIBL(&LL)';
                     performSetLibraryList(
                        replaceVars(cmdString: variables): variables);
                  endif;

                  // Set current library
                  if (variables.libl.curLib <> cNone);
                     cmdString = 'CHGLIBL CURLIB(&CL)';
                     performSetCurrentLibrary(
                        replaceVars(cmdString: variables): variables);
                  endif;
               endif;

               // Execute command
               cmdString = cmd;
               performExecute(replaceVars(cmdString: variables): cmdChgObjD);
            endif;
         endif;

         // Close event file, if left open.
         if (g_eventf.isOpen);
            closeEventFile();
            g_eventf.isOpen = cFalse;
         endif;

         // Restore library list to startup value
         restoreLibraryList();

         ceeutx(%paddr('abnormalEndHandler'): *omit);

         // Senden Abbruchnachricht, weil keine STRPREPRC Anweisungen
         // gefunden worden sind
         if (not foundPrePrcTags and i_tagsReq);
            clear PRZ0024;
            PRZ00241 = f1.file;
            PRZ00242 = f1.lib;
            PRZ00243 = f1.mbr;
            sendMsg(f_newMsg('PRZ0024': PRZ0024: cTYPE_ESCAPE));
         endif;

         if (isCmdMissingError);
            clear PRZ0028;
            PRZ00281 = f1.file;
            PRZ00282 = f1.lib;
            PRZ00283 = f1.mbr;
            sendMsg(f_newMsg('PRZ0028': PRZ0028: cTYPE_ESCAPE));
         endif;

      /end-free
     P                 E

      * =============================================================
      *  Reads a line from the source input file.
      * =============================================================
     P readLine...
     P                 b
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      *
     D ds_srcFile      ds                  likeds(ds_srcFile_t) inz
      /free

         if (%open(INCLUDE));

            read INCLUDE ds_srcFile;
            if (%eof());
               close INCLUDE;
               clear g_include;
               return readLine(io_srcDta);
            endif;

            f3_line_number = f3_line_number + 1;

         else;

            read SRCFILE ds_srcFile;
            if (%eof());
               io_srcDta = '';
               return cFalse;
            endif;

            f1_line_number = f1_line_number + 1;

         endif;

         io_srcDta = %subst(ds_srcFile.srcDta: 1: getSrcDataLength());

         return cTrue;

      /end-free
     P                 E

      * =============================================================
      *  Read the previous line from the source input file.
      * =============================================================
     P readPrvLine...
     P                 b
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      *
     D ds_srcFile      ds                  likeds(ds_srcFile_t) inz
      /free

         if (%open(INCLUDE));

            read INCLUDE ds_srcFile;
            if (%eof());
               close INCLUDE;
               clear g_include;
               return readPrvLine(io_srcDta);
            endif;

            f3_line_number = f3_line_number - 1;

         else;

            readp SRCFILE ds_srcFile;
            if (%eof());
               io_srcDta = '';
               return cFalse;
            endif;

            f1_line_number = f1_line_number - 1;

         endif;

         io_srcDta = %subst(ds_srcFile.srcDta: 1: getSrcDataLength());

         return cTrue;

      /end-free
     P                 E

      * =============================================================
      *  Abnormal end handler.
      * =============================================================
     P abnormalEndHandler...
     P                 b
     D                 pi
     D  i_pRtxToken                    *   const
      /free

         // Restore library list to startup value
         restoreLibraryList();

      /end-free
     P                 E

      * =============================================================
      *  Returns the actual value or the default value if the
      *  actual value is specified as *DFT.
      * =============================================================
     P getSpcValDft...
     P                 b
     D                 pi                  like(keyData_t)
     D  i_actual                           const like(keyData_t)
     D                                     options(*varsize)
     D  i_default                          const like(keyData_t)
     D                                     options(*varsize)
      /free

         if (i_actual = '*DFT');
            return i_default;
         endif;

         return i_actual;

      /end-free
     P                 E

      * =============================================================
      *  Restores the library list to what it was at the
      *  start of the STRPREPRC utility.
      * =============================================================
     P restoreLibraryList...
     P                 b
     D                 pi
      *
     D currentLiblList...
     D                 ds                  likeds(liblList_t) inz
     D liblStr         s                   like(cmdLong_t)
     D cmdString       s                   like(cmdLong_t) inz
      /free

         currentLiblList = retrieveLibraryList();
         if (g_startUpLiblList <> currentLiblList);
            liblStr = libListToStr(g_startUpLiblList.usrLibl);
            cmdString = 'CHGLIBL +
                         LIBL(' + liblStr + ') +
                         CURLIB(' + g_startUpLiblList.curLib + ')';
            executeCmd(cFalse: cmdString);
         endif;

      /end-free
     P                 E

      * =============================================================
      *  Reset.
      * =============================================================
     P resetLineData...
     P                 b
     D                 pi
     D  io_lineData                        likeds(lineData_t)
      /free

         io_lineData.continue  = cNEW_LINE;
         io_lineData.keyData   = '';

      /end-free
     P                 E

      * =============================================================
      *  Replaces the replacement variables.
      * =============================================================
     P replaceVars...
     P                 b
     D                 pi                  like(cmdLong_t)
     D  i_cmd                              value  like(cmdLong_t)
     D  i_variables                        value  likeds(variables_t)
      *
     D cmdString       s                   like(i_cmd)
     D posOfVar        s                   like(int4_t) inz
     D i               s              5i 0
      *
      *  ... Fehlender Wert für Variable an Position &1 des auszuführenden Befehls.
      /COPY QSTRPREPRC,PRZ0023
      /free

         cmdString = i_cmd;

         // --------------------------------
         //  Replace user-defined variables
         // --------------------------------

         for i = 1 to i_variables.usrDefVars.numE;
            replaceVar(i_variables.usrDefVars.var(i).name
                       : i_variables.usrDefVars.var(i).value: cmdString);
         endfor;

         // --------------------------------
         //  Replace STRPREPRC variables
         // --------------------------------

         // Ersetzen Lib         (&LI)
         if (i_variables.lib <> cNone);
            replaceVar('&LI': i_variables.lib: cmdString);
         endif;

         // Ersetzen Objekt      (&OB)
         if (i_variables.obj <> cNone);
            replaceVar('&OB': i_variables.obj: cmdString);
         endif;

         // Ersetzen Type Code   (&TY)
         if (i_variables.typeCode <> cNone);
            replaceVar('&TY': i_variables.typeCode: cmdString);
         endif;

         // Ersetzen Source Lib  (&SL)
         if (i_variables.srcLib <> cNone);
            replaceVar('&SL': i_variables.srcLib: cmdString);
         endif;

         // Ersetzen Source File (&SF)
         if (i_variables.srcFile <> cNone);
            replaceVar('&SF': i_variables.srcFile: cmdString);
         endif;

         // Ersetzen Source Mbr  (&SM)
         if (i_variables.srcMbr <> cNone);
            replaceVar('&SM': i_variables.srcMbr: cmdString);
         endif;

         // Ersetzen Test Lib    (&TL)
         if (i_variables.testLib <> cNone);
            replaceVar('&TL': i_variables.testLib: cmdString);
         endif;

         // Ersetzen Test Object (&TO)
         if (i_variables.testObj <> cNone);
            replaceVar('&TO': i_variables.testObj: cmdString);
         endif;

         // Ersetzen Taget Rel.  (&TO)
         if (i_variables.tgtRls <> cNone);
            replaceVar('&TR': i_variables.tgtRls: cmdString);
         endif;

         // Ersetzen From Src Lib  (&SL)
         if (i_variables.frmSrcLib <> cNone);
            replaceVar('&FL': i_variables.frmSrcLib: cmdString);
         endif;

         // Ersetzen From Src File (&SF)
         if (i_variables.frmSrcFile <> cNone);
            replaceVar('&FF': i_variables.frmSrcFile: cmdString);
         endif;

         // Ersetzen From Src Mbr  (&SM)
         if (i_variables.frmSrcMbr <> cNone);
            replaceVar('&FM': i_variables.frmSrcMbr: cmdString);
         endif;

         // Ersetzen Parameter  (&USER0)
         if (i_variables.user0 <> cNone);
            replaceVar('&U0': i_variables.user0: cmdString);
         endif;

         // Ersetzen Parameter  (&USER1)
         if (i_variables.user1 <> cNone);
            replaceVar('&U1': i_variables.user1: cmdString);
         endif;

         // Ersetzen Parameter  (&USER2)
         if (i_variables.user2 <> cNone);
            replaceVar('&U2': i_variables.user2: cmdString);
         endif;

         // Ersetzen Parameter  (&USER3)
         if (i_variables.user3 <> cNone);
            replaceVar('&U3': i_variables.user3: cmdString);
         endif;

         // Ersetzen Parameter  (&USER4)
         if (i_variables.user4 <> cNone);
            replaceVar('&U4': i_variables.user4: cmdString);
         endif;

         // Ersetzen Parameter  (&USER5)
         if (i_variables.user5 <> cNone);
            replaceVar('&U5': i_variables.user5: cmdString);
         endif;

         // Ersetzen Parameter  (&USER6)
         if (i_variables.user6 <> cNone);
            replaceVar('&U6': i_variables.user6: cmdString);
         endif;

         // Ersetzen Parameter  (&USER7)
         if (i_variables.user7 <> cNone);
            replaceVar('&U7': i_variables.user7: cmdString);
         endif;

         // Ersetzen Parameter  (&USER8)
         if (i_variables.user8 <> cNone);
            replaceVar('&U8': i_variables.user8: cmdString);
         endif;

         // Ersetzen Parameter  (&USER9)
         if (i_variables.user9 <> cNone);
            replaceVar('&U9': i_variables.user9: cmdString);
         endif;

         // Ersetzen Parameter  (&LL)
         if (i_variables.libl.usrLibl.numE >= 1);
            replaceVar(
               '&LL': libListToStr(i_variables.libl.usrLibl): cmdString);
         endif;

         // Ersetzen Parameter  (&LX)
         if (i_variables.prvLibl.usrLibl.numE >= 1);
            replaceVar(
               '&LX': libListToStr(i_variables.prvLibl.usrLibl): cmdString);
         endif;

         // Ersetzen Parameter Sonderwert  (*LX)
       //  if (i_variables.prvLibl.usrLibl.numE >= 1);
       //     replaceVar(
       //        '*LX': libListToStr(i_variables.prvLibl.usrLibl): cmdString);
       //  endif;

         // Ersetzen Parameter  (&CL)
         if (i_variables.libl.curLib <> cNone);
            replaceVar('&CL': i_variables.libl.curLib: cmdString);
         endif;

         // Ersetzen Parameter  (&CX)
         if (i_variables.prvLibl.curLib <> '');
            replaceVar('&CX': i_variables.prvLibl.curLib: cmdString);
         endif;

         // Ersetzen Parameter Sonderwert  (*CX)
       //  if (i_variables.prvLibl.curLib <> '');
       //     replaceVar('*CX': i_variables.prvLibl.curLib: cmdString);
       //  endif;

         // Prüfen, ob alle Variablen ersetzt worden sind
         posOfVar = %scan('&': cmdString);

         if (posOfVar <> 0);
            clear PRZ0023;
            PRZ00231 = posOfVar;
            PRZ00232 = cmdString;
            sendMsg(f_newMsg('PRZ0023': PRZ0023: cTYPE_DIAG));
            endAbnormal();
         endif;

         return cmdString;

      /end-free
     P                 E

      * =============================================================
      *  Converts a library list to string.
      * =============================================================
     P libListToStr...
     P                 b
     D                 pi                  like(cmdLong_t)
     D  i_libl                             value  likeds(libl_t)
      *
     D i               s             10i 0
     D liblStr         s                   like(cmdLong_t)
      /free

         for i = 1 to i_libl.numE;
            if (liblStr <> '');
               liblStr = liblStr + ' ';
            endif;
            liblStr = liblStr + %trim(i_libl.name(i));
         endfor;

         return liblStr;

      /end-free
     p                 e

      * =============================================================
      *  Execute >>EXECUTE<< tag. (Execute main creation command)
      * =============================================================
     P performExecute...
     P                 b
     D                 pi
     D  i_cmd                              value  like(cmdLong_t)
     D  i_cmdChgObjD                       value  like(cmdLong_t)
      *
      *  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
      /COPY QSTRPREPRC,PRZ0026
      /free

         if (not isExecOpt(EXEC_CRTCMD));
            g_prePostCmdsMode = MODE_POSTCMDS;
            return;
         endif;

         g_prePostCmdsMode = MODE_EXECUTE;

         g_enforceJobLogOnError = *off;

         if (g_option.isEventf);
            monitor;
               prepareEventFile();
            on-error;
               clear PRZ0026;
               sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_ESCAPE));
               endAbnormal();
            endmon;
         endif;

         if (not validateCmd(i_cmd));
            endAbnormal();
         endif;

         if (not executeCmd(cTrue: i_cmd));
            if (%scan(cEVENTF_YES: i_cmd) > 0);
               endAbnormal(retrieveEventFile(i_cmd)); // EVENT file created by IBM command
            else;
               endAbnormal();
            endif;
         else;
            // Write event file, but change messages greater or
            // equal to "error" to "warning".
            if (%scan(cEVENTF_YES: i_cmd) > 0);
               endOK(retrieveEventFile(i_cmd)); // EVENT file created by IBM command
            else;
               endOK();
            endif;
         endif;

         if (i_cmdChgObjD <> '');
            performCmd(i_cmdChgObjD);
         endif;

         g_enforceJobLogOnError = *on;
         g_prePostCmdsMode = MODE_POSTCMDS;

      /end-free
     p                 e

      * =============================================================
      *  Execute >>CMD<< tag (Pre and post commands)
      * =============================================================
     P performCmd...
     P                 b
     D                 pi
     D  i_cmd                              value  like(cmdLong_t)
      *
     D errMsgId        s                   like(msgId_t)
     D monMsgIds       ds                  likeds(monMsgIds_t)
      *
      *  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
      /COPY QSTRPREPRC,PRZ0026
      /free

         if (g_prePostCmdsMode = MODE_PRECMDS and
             not isExecOpt(EXEC_PRECMDS));
            return;
         endif;

         if (g_prePostCmdsMode = MODE_POSTCMDS and
             not isExecOpt(EXEC_POSTCMDS));
            return;
         endif;

         if (g_option.isEventf);
            monitor;
               prepareEventFile();
            on-error;
               clear PRZ0026;
               sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_ESCAPE));
               endAbnormal();
            endmon;
         endif;

         if (not validateCmd(i_cmd));
            endAbnormal();
         endif;

         if (not executeCmd(cTrue: i_cmd: errMsgId));
            monMsgIds = loadMonitoredMessageIDs();
            if (isMonitoredMessageId(errMsgId: monMsgIds));
               // TODO: remove job log entries
            else;
               if (%scan(cEVENTF_YES: i_cmd) > 0);
                  endAbnormal(retrieveEventFile(i_cmd)); // EVENT file created by command
               else;
                  endAbnormal();
               endif;
            endif;
         endif;

      /end-free
     P                 e

      * =============================================================
      *  Execute >>INCLUDE<< tag (Read /include)
      * =============================================================
     P performInclude...
     P                 b
     D                 pi
     D  i_include                          value  like(cmdLong_t)
      *
     D s               s             10i 0
     D e               s             10i 0
     D library         s             10a   varying
     D file            s             10a   varying
     D member          s             10a   varying
      *
      *  ... Die Datensatzlänge der Eingabedatei ist zu lang.
      /COPY QSTRPREPRC,PRZ0011
      *  ... Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.
      /COPY QSTRPREPRC,PRZ0012
      *  ... Ungültige INCLUDE Marke in Zeile &1 gefunden.
      /COPY QSTRPREPRC,PRZ0031
      /free

         s = 1;
         e = %scan('/': i_include);
         if (e - s > 0);
            library = %subst(i_include: 1: e - s);
            s = e + 1;
         else;
            library = '*LIBL';
            s = 1;
         endif;

         if (s < %len(i_include));
            e = %scan(' ': i_include: s);
            if (e - s > 0);
               file = %subst(i_include: s: e - s);
               s = e + 1;
            endif;
         endif;

         if (file = '');
            clear PRZ0031;
            PRZ00311 = f1_line_number;
            sendMsg(f_newMsg('PRZ0031': PRZ0031: cTYPE_DIAG));
            endAbnormal();
         endif;

         if (s < %len(i_include));
            s = %check(' ': i_include: s); // Skip spaces
            e = %len(%trimr(i_include)) + 1;
            if (e - s > 0);
               member = %subst(i_include: s: e - s);
            endif;
         endif;

         if (member = '');
            clear PRZ0031;
            PRZ00311 = f1_line_number;
            sendMsg(f_newMsg('PRZ0031': PRZ0031: cTYPE_DIAG));
            endAbnormal();
         endif;

         g_include.name = library + '/' + file;
         g_include.member = member;

         open(E) INCLUDE;
         if (%error());
            clear PRZ0012;
            PRZ00121 = file;
            PRZ00122 = library;
            PRZ00123 = member;
            sendMsg(f_newMsg('PRZ0012': PRZ0012: cTYPE_DIAG));
            endAbnormal();
         endif;

         removeFileOpenMessage();

         // Prüfen der Datensatzlänge
         if (f3.rcdLen > cMaxRcdLen);
            clear PRZ0011;
            PRZ00111 = f3.rcdLen;
            PRZ00112 = cMaxRcdLen;
            PRZ00113 = f3.lib;
            PRZ00114 = f3.file;
            sendMsg(f_newMsg('PRZ0011': PRZ0011: cTYPE_DIAG));
            endAbnormal();
         endif;

         f3_line_number = 0;

      /end-free
     P                 e

      * =============================================================
      *  Loads monitored message IDs from >>MONMSG<< section.
      * =============================================================
     P loadMonitoredMessageIDs...
     P                 b
     D                 pi                  likeds(monMsgIds_t)
      *
     D monMsgIds       ds                  likeds(monMsgIds_t)
      *
     D isFirstLine     s               n   inz(cTrue)
     D count           s             10i 0
     D srcDta          S                   like(ds_srcFile_t.srcDta)
     D tag             S                   like(tag_t) inz
     D mode            s                   like(mode_t) inz
     D newMode         s                   like(mode_t) inz
     D lineData        ds                  likeds(lineData_t) inz
      /free

         count = 0;
         isFirstLine = cTrue;

         mode = cMODE_CMD;

         dow readLine(srcDta);

            // Wenn sich in der Programmzeile ein Tag befindet, ...
            if (isTag(srcDta: tag));

               if (isFirstLine and tag <> cTAG_MONMSG);
                  readPrvLine(srcDta);
                  leave;
               else;
                  isFirstLine = cFalse;
               endif;

               // ermitteln neue Betriebsart
               newMode = tagToMode(tag);

               // prüfen Betriebsartenwechsel
               if (not checkMode(mode: newMode));
                  endAbnormal();
               endif;

               // umschalten Betriebsartenwechsel
               mode = newMode;

               // Betriebsart merken
               pushMode(mode);
            endif;

            // MsgID-Anweisung     >>MSGID<<
            if (mode = cMODE_MSGID);

               // zufügen Schlüsselwortdaten
               lineData.keyData = addData(cTAG_MSGID
                                          : lineData.keyData
                                          : srcDta
                                          : lineData.continue );

               // prüfen auf Fortsetzungszeile
               if (lineData.continue <> cEND_OF_LINE);
                  iter;
               else;
                  count += 1;
                  monMsgIds.item(count) = lineData.keyData;
                  resetLineData(lineData);
                  mode = popMode();
                  iter;
               endif;
            endif;

            // Ende MONMSG
            if (mode = cMODE_ENDMONMSG);
               mode = popMode();
               mode = popMode();
               leave;
            endif;

         enddo;

         return monMsgIds;

      /end-free
     P                 e

      * =============================================================
      *  Checks whether a given message ID is covered by a list
      *  of monitored message IDs.
      * =============================================================
     P isMonitoredMessageID...
     P                 b
     D                 pi              n
     D  i_errMsgId                         value like(msgId_t)
     D  i_monMsgIds                        value likeds(monMsgIds_t)
      *
     D i               s             10i 0
     D msgId           s                   like(msgId_t)
     D cmpLen          s             10i 0
      /free

         if (i_errMsgId = '');
            return cTrue;
         endif;

         i = 1;

         dow (i <= %elem(i_monMsgIds.item) and i_monMsgIds.item(i) <> '');
            msgId = i_monMsgIds.item(i);

            select;
            when (%subst(msgId: 4: 4) = '0000');
               cmpLen = 3;
            when (%subst(msgId: 6: 2) = '00');
               cmpLen = 5;
            other;
               cmpLen = 7;
            endsl;

            if (%subst(i_errMsgId: 1: cmpLen) = %subst(msgId: 1: cmpLen));
               return cTrue;
            endif;

            i += 1;
         enddo;

         return cFalse;

      /end-free
     P                 e

      * =============================================================
      *  Checks whether a given message ID is covered by a list
      *  of monitored message IDs.
      * =============================================================
     P isExecOpt...
     P                 b
     D                 pi              n
     D  i_execOpt                          value like(execOpt_t.execOpt)
      *
     D i               s             10i 0
      /free

         for i = 1 to g_execOpt.numElem;
            if (g_execOpt.execOpt(i) = EXEC_ALL or
                g_execOpt.execOpt(i) = i_execOpt);
              return cTrue;
            endif;
         endfor;

         return cFalse;

      /end-free
     P                 e

      * =============================================================
      *  Execute >>LIBL<< tag (set library list)
      * =============================================================
     P performSetLibraryList...
     P                 b
     D                 pi
     D  i_cmd                              value  like(cmdLong_t)
     D  io_variables                              likeds(variables_t)
      *
     D liblList        ds                  likeds(liblList_t) inz
      *
      *  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
      /COPY QSTRPREPRC,PRZ0026
      /free

         if (g_option.isEventf);
            monitor;
               prepareEventFile();
            on-error;
               clear PRZ0026;
               sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_ESCAPE));
               endAbnormal();
            endmon;
         endif;

         liblList = retrieveLibraryList();
         io_variables.prvLibl.usrLibl = liblList.usrLibl;

         // Change library list
         if (not validateCmd(i_cmd));
            endAbnormal();
         endif;

         if (not executeCmd(cTrue: i_cmd));
            if (%scan(cEVENTF_YES: i_cmd) > 0);
               endAbnormal(retrieveEventFile(i_cmd)); // EVENT file created by command
            else;
               endAbnormal();
            endif;
         endif;

      /end-free
     P                 e

      * =============================================================
      *  Execute >>CURLIB<< tag (set current library)
      * =============================================================
     P performSetCurrentLibrary...
     P                 b
     D                 pi
     D  i_cmd                              value  like(cmdLong_t)
     D  io_variables                              likeds(variables_t)
      *
     D liblList        ds                  likeds(liblList_t) inz
      *
      *  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
      /COPY QSTRPREPRC,PRZ0026
      /free

         if (g_option.isEventf);
            monitor;
               prepareEventFile();
            on-error;
               clear PRZ0026;
               sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_ESCAPE));
               endAbnormal();
            endmon;
         endif;

         liblList = retrieveLibraryList();
         io_variables.prvLibl.curLib = liblList.curLib;

         // Change library list
         if (not validateCmd(i_cmd));
            endAbnormal();
         endif;

         if (not executeCmd(cTrue: i_cmd));
            if (%scan(cEVENTF_YES: i_cmd) > 0);
               endAbnormal(retrieveEventFile(i_cmd)); // EVENT file created by command
            else;
               endAbnormal();
            endif;
         endif;

      /end-free
     P                 e

      * =============================================================
      *  Retrieves the current library list of the job.
      * =============================================================
     P retrieveLibraryList...
     P                 b
     D                 pi                  likeds(liblList_t)
      *
      *  Return value
     D libl            ds                  likeds(liblList_t) inz
      *
     D rtvc0200        ds                  likeds(rtvc0200_t) based(pRtvc0200)
     D rcvVar          s           4096a   inz
     D errCode         ds                  likeds(errCode_t) inz
     D i               s             10i 0
     D keysToRtn       s             10i 0 dim(2)
     D pOffs           s               *   inz
     D curLib          s                   like(QWCRTVCA_libName_t)
     D                                     based(pCurLib)
     D usrLibl         s                   like(QWCRTVCA_libName_t)
     D                                     dim(DIM_LIBLIST) based(pUsrLibl)
      /free


         pRtvc0200 = %addr(rcvVar);

         keysToRtn(1) = KEY_CURRENT_LIBRARY;
         keysToRtn(2) = KEY_USER_LIBRARIES;
         errCode = f_newApiErrCode(cFalse); // send *ESCAPE message on error
         QWCRTVCA(rcvVar: %size(rcvVar): 'RTVC0200'
                  : %elem(keysToRtn): keysToRtn: errCode);

         pOffs = %addr(rtvc0200) + %size(rtvc0200);

         if (rtvc0200.numSysLiblE >= 1);
            // pSysLibl = pOffs;
            pOffs = pOffs + (rtvc0200.numSysLiblE * %size(QWCRTVCA_libName_t));
         endif;

         if (rtvc0200.numPrdLiblE >= 1);
            // pPrdLibl = pOffs;
            pOffs = pOffs + (rtvc0200.numPrdLiblE * %size(QWCRTVCA_libName_t));
         endif;

         if (rtvc0200.curLibExists >= CURLIB_EXISTS);
            pCurLib = pOffs;
            libl.curLib = curLib;
            pOffs = pOffs + %size(QWCRTVCA_libName_t);
         else;
            libl.curLib = CURLIB_CRTDFT;
         endif;

         if (rtvc0200.numUsrLiblE >= 1);
            pUsrLibl = pOffs;
            for i = 1 to rtvc0200.numUsrLiblE;
               libl.usrLibl.numE += 1;
               libl.usrLibl.name(libl.usrLibl.numE) = usrLibl(i);
            endfor;
            pOffs = pOffs + (rtvc0200.numUsrLiblE * %size(QWCRTVCA_libName_t));
         else;
            clear libl.usrLibl;
         endif;

         return libl;

      /end-free
     P                 e

      * =============================================================
      *  Retrieve the name of the event file (library & member)
      *  from the object creation command.
      * =============================================================
     P retrieveEventFile...
     P                 b
     D                 pi                  likeds(qObj_t)
     D  i_cmd                              value  like(cmdLong_t)
      *
      *  Return value
     D qObj            ds                  likeds(qObj_t) inz
      *
     D cmd             s                   like(i_cmd)
     D clCmd           s             10a   varying
     D clKwd           s             10a   varying
     D i               s             10i 0
     D s               s             10i 0
     D e               s             10i 0
     D parmValue       s             30a   varying
      *
     D SPACE           c                   ' '
      /free

         clear qObj;

         cmd = formatCmd(i_cmd);
         i = %scan(SPACE: cmd);
         if (i <= 1);
            return qObj;
         endif;

         // Find command in command table and
         // get the keyword that specifies the
         // qualified object name.
         clKwd = '';
         clCmd = %subst(cmd: 1: i-1);
         for i = 1 to %elem(g_crtCmds);
            if (g_crtCmds(i).cmd = clCmd);
               clKwd = %trim(g_crtCmds(i).keyword);
               leave;
            endif;
         endfor;

         // If not found in command table or not present in
         // the command, retrieve the first keyword, assuming
         // that it is the keyword that specifies the
         // qualified object name.
         if (clKwd = '' or %scan(' ' + clKwd + '(': cmd) = 0);
            i = %scan(SPACE: cmd: 1); // Skip CL command
            s = %check(SPACE: cmd: i); // Skip spaces = Start of 1. keyword
            e = %scan('(': cmd: s);   // Start of keyword value
            if ((e - s) <= 0);
               return qObj;
            endif;
            clKwd = %subst(cmd: s: e-s);
         endif;

         s = %scan(clKwd + '(': cmd); // Start of object parameter
         e = %scan(')': cmd); // End of object parameter

         s = s + %len(clKwd) + 1;
         if ((e - s) <= 0);
            return qObj;
         endif;

         parmValue = %trim(%subst(cmd: s: e-s));
         s = %scan('/': parmValue);
         if ((s - 1) > 0);
            if (s >= %len(parmValue));
               return qObj;
            endif;
            qObj.lib = %subst(parmValue: 1: s-1);
            qObj.name = %subst(parmValue: s+1);
         else;
            qObj.lib = '*LIBL';
            qObj.name = parmValue;
         endif;

         return qObj;

      /end-free
     P                 e

      * =============================================================
      *  Zusammenbauen Schlüsselwortdaten
      * =============================================================
     P addData...
     P                 b
     D                 pi                  like(keyData_t)
     D  i_tag                              value  like(tag_t)
     D  i_keyData                          value  like(keyData_t)
     D  i_srcDta                           value  like(srcDta_t)
     D  io_continue                               like(continue_t)
      *
      *  Funktionswert
     D keyData         s                   like(keyData_t) inz
      *
      *  Nachrichten
      *  ... Ungültiges Fortsetzungszeichen &1 in Zeile &2 gefunden.
      /COPY QSTRPREPRC,PRZ0005
      *  ... Das Zeilenendekennzeichen konnte nicht gefunden werden.
      /COPY QSTRPREPRC,PRZ0008
      *  ... Unbekannter Wert "&1" für Fortsetzungszeichen gefunden.
      /COPY QSTRPREPRC,PRZ0009
      *
      *  Arbeitsfelder
     D start           s                   like(int4_t) inz
     D                                     static
     D dataLen         s                   like(int4_t) inz
     D x               s                   like(int4_t) inz
      /free

         // ermitteln der getStartPosition
         if (io_continue = cNEW_LINE);
            start = getStartPos(i_tag: i_srcDta);
         endif;

         // ermitteln Zeilenende
         x = %len(%trimr(i_srcDta));
         dow (x >= start);

            // ... Zeilenende
            if (%subst(i_srcDta: x: %len(io_continue)) = cEND_OF_LINE);
               leave;
            endif;

            // ... '+' Zeichen
            if (%subst(i_srcDta: x: %len(io_continue)) = cTRUNC_CONT);
               leave;
            endif;

            // ... '-' Zeichen
            if (%subst(i_srcDta: x: %len(io_continue)) = cCONT);
               leave;
            endif;

            x = x - 1;
         enddo;

         // ermitteln Datenlänge Fortsetzungszeichen
         dataLen = x - start;

         // prüfen Datenlänge
         if (dataLen < 0);
            clear PRZ0008;
            PRZ00081 = f1_line_number;
            sendMsg(f_newMsg('PRZ0008': PRZ0008: cTYPE_DIAG));
            endAbnormal();
         endif;

         // Wenn eine Datenlänge ermittelt werden konnte, ...
         if (dataLen > 0);
            // ... dann
            //     zufügen neue Daten zu Schlüsselwort bei ...
            select;
            when (io_continue = cNEW_LINE);     // ... neue Zeile
               keyData = %subst(i_srcDta: start: dataLen);

            when (io_continue = cTRUNC_CONT);   // ... Fortsetzungszeichen '+'
               keyData = i_keyData + %triml(%subst(i_srcDta: start:dataLen));

            when (io_continue = cCONT);         // ... Fortsetzungszeichen '-'
               keyData = i_keyData + %subst(i_srcDta: start: dataLen);

            other;
               // ... dieser Fall kann nicht eintreten
               //     weil über die Prüfung von dataLen sichergestellt ist,
               //     dass immer ein gültiges Fortsetzungszeichen vorhanden ist.
               //     Dennoch:
               clear PRZ0009;
               PRZ00091 = io_continue;
               sendMsg(f_newMsg('PRZ0009': PRZ0009: cTYPE_DIAG));
               endAbnormal();
            endsl;

         else;
            // ... dann
            //     beibehalten der bisherigen Daten
            keyData = i_keyData;
         endif;

         // ermitteln neues Fortsetzungszeichen
         io_continue = %subst(i_srcdta: x: %len(io_continue));

         // prüfen neues Fortsetzungszeichen
         if (io_continue <> cEND_OF_LINE) and
            (io_continue <> cTRUNC_CONT) and
            (io_continue <> cCONT);
            clear PRZ0005;
            PRZ00051 = io_continue;
            PRZ00052 = f1_line_number;
            sendMsg(f_newMsg('PRZ0005': PRZ0005: cTYPE_DIAG));
            endAbnormal();
         endif;

         return keyData;

      /end-free
     P                 e
      *
      * =============================================================
      *  Ermitteln der Breite der Quellenangaben am >>WIDTH<< Tag
      * =============================================================
     P getWidthValue...
     P                 b
     D                 pi            10i 0
     D  i_srcDta                           value  like(srcDta_t)
     D  i_length                     10i 0 value
      *
      *  Funktionswert
     D width           s             10i 0 inz(80)
      *
     D cWIDTH_LEN      c                   %len(width)
     D cWIDTH_DECPOS   c                   %decpos(width)
      *
      *  Arbeitsfelder
     D x               s                   like(int4_t) inz
     D tmpWidth        s             16a   varying inz
      *
      *  Konstanten
     D cNUMBERS        c                   '0123456789'
      /free

         // ermitteln der getStartPosition
         x = %scan(cTAG_WIDTH: %subst(i_srcDta: 1: i_length));
         if (x = 0);
            return width;
         endif;

         // Überspringen von Leerzeichen zwischen >>WIDTH<< und der angegebenen Breite
         x = x + %len(cTAG_WIDTH);
         x = %check(' ': %subst(i_srcDta: 1: i_length): x);

         dow (x >= 1 and x < i_length and
              %check(cNUMBERS: %subst(i_srcDta:x:1)) = 0);
            tmpWidth = tmpWidth + %subst(i_srcDta:x:1);
            x = x + 1;
         enddo;

         if (tmpWidth <> '');
            width = %dec(tmpWidth: cWIDTH_LEN: cWIDTH_DECPOS);
         endif;

         return width;

      /end-free
     P                 e
      *
      * =============================================================
      *  Ersetzen/Hinzufügen Schlüsselwort
      * =============================================================
     P replaceCmdKeyWord...
     P                 b
     D                 pi                         like(cmdLong_t)
     D  i_cmd                              value  like(cmdLong_t)
     D  i_keyData                          value  like(keyData_t)
      *
      *  Funktionswert
     D cmd             s                   like(cmdLong_t) inz
      *
      *  Nachrichten
      *  ... Das Ende des Schlüsselwortes &1 konnte nicht gefunden werden.
      /COPY QSTRPREPRC,PRZ0006
      *
      *  Arbeitsfelder
     D startPos        s                   like(int4_t) inz
     D dataLen         s                   like(int4_t) inz
     D x               s                   like(int4_t) inz
     D y               s                   like(int4_t) inz
     D token           s             11a   varying inz
     D cmdDtaLen       s                   like(int4_t) inz
     D numBracket      s                   like(int4_t) inz
      /free

         // ermitteln Befehlstoken
         x = %scan('(': i_keyData: 1);
         token = %subst(i_keyData: 1: x);

         // ermitteln Ende des Befehlswortes ...
         // ... überspringen führende Leerzeichen
         x = %check(' ': i_cmd);
         // ... suchen Leerzeichen nach Befehlswort
         x = %scan(' ': i_cmd: x);

         // suchen Token im vorhandenen Befehlstring
         dow (x > 0 and startPos < %len(i_cmd));
            startPos = %scan(token: i_cmd: x);
            if ((startPos > 1)   and
                (%subst(i_cmd: startPos - 1: 1) <> ' '));
               x =  startPos + %len(token);
               iter;
            else;
               leave;
            endif;
         enddo;

         // Wenn das Token gefunden werden konnte, ...
         if (startPos <> 0);
            // ... dann
            //     ermitteln Länge des Schlüsselwortes ...
            x = startPos + %len(token);
            numBracket = 1;
            dataLen = %len(token);
            cmdDtaLen = %len(i_cmd);

            for y = x to cmdDtaLen;

               DataLen = DataLen + 1;

               // ... '('
               if (%subst(i_cmd: y: 1) = '(');
                  numBracket = numBracket + 1;
               endif;

               // ... ')'
               if (%subst(i_cmd: y: 1) = ')');
                  numBracket = numBracket - 1;

                  // ... gefunden
                  if (numBracket <= 0);
                     leave;
                  else;
                     iter;
                  endif;
               endif;

            endfor;

            // Wenn der Klammernzähler <> 0 ist, ...
            if (numBracket <> 0);
                // ... dann
                //     konnte das Ende des Schlüsselwortes
                //     nicht gefunden werden
                clear PRZ0006;
                PRZ00061 = %subst(token: 1: %len(token) - 1);
                sendMsg(f_newMsg('PRZ0006': PRZ0006: cTYPE_DIAG));
                endAbnormal();
            endif;

            // austauschen Schlüsselwort
            cmd = %replace(i_keyData: i_cmd: startPos: dataLen);

         else;
            // ... sonst
            //     anfügen Schlüsselwort
            cmd = %trim(i_cmd) + ' ' + i_keyData;
         endif;

         return cmd;

      /end-free
     P                 e
      *
      * =============================================================
      *  Ermitteln Länge von srcDta
      * =============================================================
     P getSrcDataLength...
     P                 b
     D                 pi                         like(int4_t)
      *
      *  Funktionswert
     D srcDtaLen       s                   like(int4_t) inz
      /free

         if (%open(INCLUDE));
            srcDtaLen =
               f3.rcdLen -
               (%size(ds_srcFile_t.srcSeq) + %size(ds_srcFile_t.srcDat));
         else;
            srcDtaLen =
               f1.rcdLen -
               (%size(ds_srcFile_t.srcSeq) + %size(ds_srcFile_t.srcDat));
         endif;

         if (g_width <> -1 and g_width < srcDtaLen);
            srcDtaLen = g_width;
         endif;

         return srcDtaLen;

      /end-free
     P                 E
      *
      * =============================================================
      *  Ermitteln der getStartPosition
      * =============================================================
     P getStartPos...
     P                 b
     D                 pi                         like(int4_t)
     D  i_tag                              value  like(tag_t)
     D  i_srcDta                                  like(srcDta_t)
      *
      *  Funktionswert
     D pos             s                   like(int4_t) inz
      *
      *  Arbeitsfelder
      /free

         pos = %scan(%trim(i_tag): i_srcDta: 1);
         if (pos > 0);
            pos = pos + %len(%trim(i_tag));
            pos = %check(' ': i_srcDta: pos);
         endif;

         return pos;

      /end-free
     P                 e
      *
      * =============================================================
      *  Prüfen auf gültiges Tag
      * =============================================================
     P isTag...
     P                 b
     D                 pi                         like(bool_t)
     D  i_srcDta                           value  like(srcDta_t)
     D  o_tag                                     like(tag_t)
      *
      *  Funktionswert
     D isTag           s                   like(bool_t) inz(cFalse)
      /free

         isTag = cFalse;

         dou '1';
            // Anfang Pre-Compiler
            if (retrieveTag(cTAG_PREPRZ: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ende Pre-Compiler
            if (retrieveTag(cTAG_ENDPREPRZ: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Anfang Link
            if (retrieveTag(cTAG_LINK: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ende Link
            if (retrieveTag(cTAG_ENDLINK: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Anfang Compiler
            if (retrieveTag(cTAG_COMPILE: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ende Compiler
            if (retrieveTag(cTAG_ENDCOMPILE: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Anfang Important
            if (retrieveTag(cTAG_IMPORTANT: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ende Important
            if (retrieveTag(cTAG_ENDIMPORTANT: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Anfang MONMSG
            if (retrieveTag(cTAG_MONMSG: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ende MONMSG
            if (retrieveTag(cTAG_ENDMONMSG: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Breite der Quellenangaben
            if (retrieveTag(cTAG_WIDTH: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Erstellungsbefehl
            if (retrieveTag(cTAG_CRTCMD: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Parameter
            if (retrieveTag(cTAG_PARM: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Message ID
            if (retrieveTag(cTAG_MSGID: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ausführen "Hauptbefehl"
            if (retrieveTag(cTAG_EXECUTE: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ausführen Pre-/Post-Anweisung
            if (retrieveTag(cTAG_CMD: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Einlesen /include
            if (retrieveTag(cTAG_INCLUDE: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ausführen Anweisung zum Setzen einer Bibliotheksliste
            if (retrieveTag(cTAG_LIBL: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;

            // Ausführen Anweisung zum Setzen der aktuellen Bibliothek
            if (retrieveTag(cTAG_CURLIB: i_srcDta: o_tag));
               isTag = cTrue;
               leave;
            endif;
         enddo;

         return isTag;

      /end-free
     P                 e
      *
      * =============================================================
      *  Ermitteln Tag aus Quellendaten
      * =============================================================
     P retrieveTag...
     P                 b
     D                 pi                         like(bool_t)
     D  i_tagToTest                        value  like(tag_t)
     D  i_srcDta                           value  like(srcDta_t)
     D  o_tag                                     like(tag_t)
      *
      *  Funktionswert
     D isTag           s                   like(bool_t) inz(cFalse)
      *
      *  Arbeitsfelder
     D startPos        s                   like(int4_t) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /free

         startPos = %scan(%trim(i_tagToTest): i_srcDta);
         if (startPos > 0);
            o_tag = i_tagToTest;
            isTag = cTrue;
         else;
            o_tag = '';
            isTag = cFalse;
         endif;

         return isTag;

      /end-free
     P                 e
      *
      * =============================================================
      *  Umsetzen Tag in Betriebsmodus
      * =============================================================
     P tagToMode...
     P                 b
     D                 pi                         like(mode_t)
     D  i_tag                              value  like(tag_t)
      *
      *  Funktionswert
     D mode            s                   like(mode_t) inz
      *
      *  Nachrichten
      *  ... Das Ende des Schlüsselwortes &1 konnte nicht gefunden werden.
      /COPY QSTRPREPRC,PRZ0010
      /free

         select;
            // Anfang Pre-Compiler
            when (i_tag = cTAG_PREPRZ);
               mode = cMODE_PREPRZ;

            // Ende Pre-Compiler
            when (i_tag = cTAG_ENDPREPRZ);
               mode = cMODE_ENDPREPRZ;

            // Anfang Link
            when (i_tag = cTAG_LINK);
               mode = cMODE_LINK;

            // Ende Link
            when (i_tag = cTAG_ENDLINK);
               mode = cMODE_ENDLINK;

            // Anfang Compile
            when (i_tag = cTAG_COMPILE);
               mode = cMODE_COMPILE;

            // Ende Compile
            when (i_tag = cTAG_ENDCOMPILE);
               mode = cMODE_ENDCOMPILE;

            // Anfang Important
            when (i_tag = cTAG_IMPORTANT);
               mode = cMODE_IMPORTANT;

            // Ende Important
            when (i_tag = cTAG_ENDIMPORTANT);
               mode = cMODE_ENDIMPORTANT;

            // Anfang MONMSG
            when (i_tag = cTAG_MONMSG);
               mode = cMODE_MONMSG;

            // Ende MONMSG
            when (i_tag = cTAG_ENDMONMSG);
               mode = cMODE_ENDMONMSG;

            // Maximale Breite der Quellendaten
            when (i_tag = cTAG_WIDTH);
               mode = cMODE_WIDTH;

            // Erstellungsbefehl
            when (i_tag = cTAG_CRTCMD);
               mode = cMODE_CRTCMD;

            // Parameter
            when (i_tag = cTAG_PARM);
               mode = cMODE_PARM;

            // Message ID
            when (i_tag = cTAG_MSGID);
               mode = cMODE_MSGID;

            // Ausführen "Hauptbefehl"
         when (i_tag = cTAG_EXECUTE);
            mode  = cMODE_EXECUTE;

            // Ausführen Pre-/Post-Befehle
         when (i_tag = cTAG_CMD);
            mode  = cMODE_CMD;

            // Einlesen /include
         when (i_tag = cTAG_INCLUDE);
            mode  = cMODE_INCLUDE;

            // Ausführen Anweisung zum Setzen einer Bibliotheksliste
         when (i_tag = cTAG_LIBL);
            mode  = cMODE_LIBL;

            // Ausführen Anweisung zum Setzen der aktuellen Bibliothek
         when (i_tag = cTAG_CURLIB);
            mode  = cMODE_CURLIB;

         other;
            // ... darf nicht vorkommen, da alle Tags, die erkannt werden
            //     auch umgesetzt werden müssen.
            //     Dennoch:
            clear PRZ0010;
            PRZ00101 = i_tag;
            sendMsg(f_newMsg('PRZ0010': PRZ0010: cTYPE_DIAG));
            endAbnormal();
         endsl;

         return mode;

      /end-free
     P                 e
      *
      * =============================================================
      *  Ändern Betriebsmodus
      * =============================================================
     P checkMode...
     P                 b
     D                 pi              n
     D  i_mode                             value  like(mode_t)
     D  i_newMode                          value  like(mode_t)
      *
      *  Access key of file STRPRE1 (Pre-compiler modes)
     D P1Key2          ds                  qualified
     D  MODE                               like(P1MODE)
     D  NEWMODE                            like(P1NEWMODE)
      *
      *  Nachrichten
      *  ... Falsche Reihenfolge im Betriebsmodus.
      /COPY QSTRPREPRC,PRZ0001
      *  ... Verschachtelte INCLUDE Marke in Zeile &4 der Datei &2/&1, Teildatei &3 gefunden.
      /COPY QSTRPREPRC,PRZ0032
      /free

         P1KEY2.MODE = i_mode;
         P1KEY2.NEWMODE = i_newMode;
         setll %kds(P1Key2) FSTRPRE1;

         dow '1';
            reade %kds(P1Key2) FSTRPRE1;
            if (%eof());
               clear PRZ0001;
               PRZ00011 = i_mode;
               PRZ00012 = i_newMode;
               sendMsg(f_newMsg('PRZ0001': PRZ0001: cTYPE_DIAG));
               return cFalse;
            else;
               leave;
            endif;
         enddo;

         if (i_newMode = cMODE_INCLUDE and %open(INCLUDE));
            clear PRZ0032;
            PRZ00321 = f3.file;
            PRZ00322 = f3.lib;
            PRZ00323 = f3.mbr;
            PRZ00324 = f3_line_number;
            sendMsg(f_newMsg('PRZ0032': PRZ0032: cTYPE_DIAG));
            return cFalse;
         endif;

         return cTrue;

      /end-free
     P                 e
      *
      * =============================================================
      *  Senden Escape Nachricht
      * =============================================================
     P sendMsg...
     P                 b
     D                 pi
     D  i_msg                              value  likeds(msg_t)
      /free

        f_sndPgmMsg(i_msg: cMsg_Prv: cMsg_ToCtlBdy);

      /end-free
     P                 e
      *
      * =============================================================
      *  Mode auf Stack
      * =============================================================
     P pushMode...
     P                 b
      *
     D pushMode...
     D                 pi
     D  i_mode                             value  like(mode_t)
      /free

         g_modeCnt = g_modeCnt + 1;
         g_mode(g_modeCnt) = i_mode;

      /end-free
     P                 e
      *
      * =============================================================
      *  Mode vom Stack
      * =============================================================
     P popMode...
     P                 b
      *
     D popMode...
     D                 pi                         like(mode_t)
      /free

         g_mode(g_modeCnt) = '';
         g_modeCnt = g_modeCnt - 1;

         return g_mode(g_modeCnt);

      /end-free
     P                 e
      *
      * =============================================================
      *  Prüfen CL Befehl
      * =============================================================
     P validateCmd...
     P                 b
     D                 pi                         like(bool_t)
     D  i_cmd                              value  like(cmdLong_t)
      *
      *  Definitionen für QCAPCMD
     D optCtrl         ds                  likeds(cpop0100_t) inz
     D retCmd          s                   like(cmdLongFixLen_t) inz
     D retCmdLenAvl    s             10i 0 inz(%len(retCmd))
     D retCmdLenRtn    s             10i 0 inz
     D errCode         ds                  likeds(errCode_t) inz
      *
      *  ... Fehler im Erstellungsbefehl gefunden.
      /COPY QSTRPREPRC,PRZ0015
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /free

         clear errCode;

         monitor;

            clear optCtrl;
            optCtrl.typeCmdPrc = cQCAPCMD_PRC_CHK_CMDLINE;
            optCtrl.DBCS_data = cQCAPCMD_DBCS_HANDLE;
            optCtrl.prmtAction = cQCAPCMD_PROMPT_NEVER;
            optCtrl.cmdStrSyntax = cQCAPCMD_SYNTAX_SYSTEM;
            optCtrl.msgRtvKey = '';
            optCtrl.ccsidCmdStr = 0;
            optCtrl.res_01 = *ALLx'00';

            errCode = f_newApiErrCode(cTrue);
            QCAPCMD(i_cmd: %len(%trimR(i_cmd)): optCtrl: %size(optCtrl)
                    : 'CPOP0100': retCmd: retCmdLenAvl: retCmdLenRtn: errCode);

            if (not f_isApiError(errCode));
               return cTrue;
            endif;

         on-error;
         endmon;

         if (%trim(i_cmd) = '');
           appendToJobLog('Command validation error: Command is missing');
         else;
           appendToJobLog(i_cmd);
         endif;

         return cFalse;

      /end-free
     P                 e
      *
      * =============================================================
      *  Execute a CL command.
      * =============================================================
     P executeCmd...
     P                 b
     D                 pi                         like(bool_t)
     D  i_monErr                           value  like(bool_t)
     D  i_cmd                              value  like(cmdLong_t)
     D  o_errMsgId                                like(msgId_t) options(*nopass)
      *
     D p_errMsgId      c                   3
      *
      *  Fields for getMsgInf()
     D msgID           s                   like(msgID_t) inz
     D msgDta          s                   like(msg_t.data) inz
     D msgFile         s                   like(msg_t.file) inz
     D msgLib          s                   like(msg_t.lib) inz
      *
      * Definitionen für Ausgangsprogramm
     D cmdLongFixLength...
     D                 s                   like(cmdLongFixLen_t)
     D cmdLongLength   s             15P 5
     D exitPgmName     s             21A   varying
      *
     D exitPgm         pr                  extpgm(exitPgmName)
     D  cmd                                like(cmdLongFixLen_t)
     D                                     options(*varsize)
     D  length                       15P 5 options(*nopass: *omit)
      *
      *  Definitionen für QCAPCMD
     D optCtrl         ds                  likeds(cpop0100_t) inz
     D retCmd          s                   like(cmdLongFixLen_t) inz
     D retCmdLenAvl    s             10i 0 inz(%len(retCmd))
     D retCmdLenRtn    s             10i 0 inz
     D errCode         ds                  likeds(errCode_t) inz
      *
      *  ... Fehler im Erstellungsbefehl gefunden.
      /COPY QSTRPREPRC,PRZ0015
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /free

         clear errCode;

         if (g_pgmCmdExc <> '*NONE');
            exitPgmName = %trim(g_libPgmCmdExc) + '/' + %trim(g_pgmCmdExc);
            cmdLongFixLength = i_cmd;
            cmdLongLength = %len(cmdLongFixLength);
            exitPgm(cmdLongFixLength: cmdLongLength);
            i_cmd = %trimR(%subst(cmdLongFixLength: 1: %int(cmdLongLength)));
         endif;

         // Execute command
         monitor;

            clear optCtrl;
            optCtrl.typeCmdPrc = cQCAPCMD_PRC_EXC_CMDLINE;
            optCtrl.DBCS_data = cQCAPCMD_DBCS_HANDLE;
            optCtrl.prmtAction = cQCAPCMD_PROMPT_NEVER;
            optCtrl.cmdStrSyntax = cQCAPCMD_SYNTAX_SYSTEM;
            optCtrl.msgRtvKey = '';
            optCtrl.res_01 = *ALLx'00';

            errCode = f_newApiErrCode(cFalse);
            QCAPCMD(i_cmd: %len(i_cmd): optCtrl: %size(optCtrl): 'CPOP0100'
                    : retCmd: retCmdLenAvl: retCmdLenRtn: errCode);

            return cTrue;

         on-error;

            appendToJobLog(i_cmd);

            getMsgInf('STRPREPRC': 'STRPREPRC2': 'executeCmd'
                      : errCode.excID: msgID: msgDta: msgFile: msgLib);

            if (not g_option.isEventf);
               clear PRZ0015;
               PRZ00151 = i_cmd;
               sendMsg(f_newMsg('PRZ0015': PRZ0015: cTYPE_DIAG));
               sendMsg(f_newMsg(msgID: msgDta: cTYPE_DIAG: msgFile: msgLib));
            endif;

            if (i_monErr);
               if (%parms() >= p_errMsgId and %addr(o_errMsgId) <> *null);
                  o_errMsgId = msgID;
               endif;
               return cFalse;
            else;
               endAbnormal();
            endif;
         endmon;

      /end-free
     P                 e
      *
      *===============================================================*
      *  Appends a message to the job log.
      *===============================================================*
     P appendToJobLog...
     P                 b
     D                 pi
     D  i_message                          value  like(cmdLong_t)
      *
     D startPos        S             10U 0 inz(1)
     D prefix          S             11A   inz
     D line            S             60A   inz
      *
      *  Nachrichten
      *  ... &1.
      /COPY QSTRPREPRC,PRZ0029
      /free

         if (i_message = '');
            i_message = '*MISSING';
         endif;

         clear PRZ0029;
         prefix = 'STRPREPRC: ';
         dow (startPos > 0);
            line = f_wordWrap(i_message: %len(line): startPos);
            clear PRZ0029;
            PRZ00291 = prefix + line;
            sendMsg(f_newMsg('PRZ0029': PRZ0029: cTYPE_DIAG));
            prefix = '';
         enddo;

      /end-free
     P                 E
      *
      * =============================================================
      *  Ermitteln Nachrichteninformationen
      * =============================================================
     P getMsgInf...
     P                 b
     D                 pi
     D  i_pgm                              value  like(pgm_t)
     D  i_module                           value  like(module_t)
     D  i_proc                             value  like(proc_t)
     D  i_msgId                            value  like(msgID_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msg_t.data)
     D  o_msgFile                                 like(msg_t.file)
     D  o_msgLib                                  like(msg_t.lib)
      *
     D RCVM0200        ds                  likeds(rcvm0200_t)
      *
     D lenMsgInf       s             10i 0 inz(%size(RCVM0200))
     D stackEntry      s             64a   inz
     D stackCounter    s             10i 0 inz(0)
     D msgType         s             10a   inz
     D msgKey          s              4a   inz
     D wait            s             10i 0 inz(0)
     D msgAction       s             10a   inz('*SAME')
     D lenStackEntry   s             10i 0 inz(%size(stackEntry))
     D stackQual       ds
     D  stackQualMod                 10a   inz('*NONE')
     D  stackQualPgm                 10a   inz('*NONE')
      *
     D errCode         ds                  likeds(errCode_t) inz
      *
     D firstMsg        s                   like(RCVM0200) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /free

         stackEntry = i_proc;
         stackQualPgm = i_pgm;
         stackQualMod = i_module;
         msgType = '*LAST';
         msgKey = '';
         firstMsg = '';

         dou (rcvm0200.msgId = i_msgId);

            clear RCVM0200;
            errCode = f_newApiErrCode(cTrue);

            QMHRCVPM(RCVM0200: lenMsgInf: 'RCVM0200': stackEntry: stackCounter
                     : msgType: msgKey: wait: msgAction: errCode
                     : lenStackEntry: stackQual);

            if (f_isApiError(errCode));
               leave;
            endif;

            if (rcvm0200.bytAvl = 0);
               RCVM0200 = firstMsg;
               leave;
            endif;

            if (firstMsg = '');
               firstMsg = RCVM0200;
            endif;

            msgType = '*PRV';
            msgKey  = rcvm0200.msgKey;
         enddo;

         if (f_isApiError(errCode));
            o_msgID   = '';
            o_msgDta  = '';
            o_msgFile = '';
            o_msgLib  = '';
         else;
            o_msgID   = rcvm0200.msgId;
            o_msgDta  = %subst(rcvm0200.varLenData: 1: rcvm0200.lenRplDtaRet);
            o_msgFile = rcvm0200.msgF;
            o_msgLib = rcvm0200.msgFLibRet;
         endif;

      /end-free
     P                 e
      *
      * =============================================================
      *  Formatieren CL Befehl
      * =============================================================
     P formatCmd...
     P                 b
     D                 pi                         like(cmdLong_t)
     D  i_cmd                              value  like(cmdLong_t)
      *
      *  Nachrichten
      *  ... Befehlszeichenfolge ist zu lang.
      /COPY QSTRPREPRC,PRZ0007
      *  ... Fehler im Erstellungsbefehl gefunden.
      /COPY QSTRPREPRC,PRZ0015
      *
      *  Definitionen für QCAPCMD
     D cmd             s                   like(i_cmd)
     D optCtrl         ds                  likeds(cpop0100_t) inz
     D retCmd          s                   like(cmdLongFixLen_t) inz
     D retCmdLenAvl    s             10i 0 inz(%len(retCmd))
     D retCmdLenRtn    s             10i 0 inz
     D errCode         ds                  likeds(errCode_t) inz
      *
     D msg             ds                  likeds(msg_t) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /free

            if (i_cmd = '');
               return i_cmd;
            endif;

            cmd = i_cmd;

            clear optCtrl;
            optCtrl.typeCmdPrc = cQCAPCMD_PRC_CHK_CMDLINE;
            optCtrl.DBCS_data = cQCAPCMD_DBCS_HANDLE;
            optCtrl.prmtAction = cQCAPCMD_PROMPT_NEVER;
            optCtrl.cmdStrSyntax = cQCAPCMD_SYNTAX_SYSTEM;
            optCtrl.msgRtvKey = '';
            optCtrl.res_01 = *ALLx'00';

            errCode = f_newApiErrCode(cTrue);

            QCAPCMD(cmd: %len(cmd): optCtrl: %size(optCtrl): 'CPOP0100'
                    : retCmd: retCmdLenAvl: retCmdLenRtn: errCode);

         // Prüfen API-Fehler ...
         if (f_isApiError(errCode));
            msg = f_cvtApiErrCodeToMsg(errCode);
            msg.type = cTYPE_DIAG;
            sendMsg(msg);
            clear PRZ0015;
            PRZ00151 = i_cmd;
            sendMsg(f_newMsg('PRZ0015': PRZ0015: cTYPE_DIAG));
            endAbnormal();
         endif;

         // Prüfen Länge der Befehlszeichenkette ...
         if (retCmdLenRtn > retCmdLenAvl);
            clear PRZ0007;
            PRZ00071 = retCmdLenAvl;
            sendMsg(f_newMsg('PRZ0007': PRZ0007: cTYPE_DIAG));
            endAbnormal();
         endif;

         return retCmd;

      /end-free
     P                 e
      *
      * =============================================================
      *  Beenden Programm abnormal
      * =============================================================
     P endAbnormal...
     P                 b
     D                 pi
     D  i_qEventf                          const  likeds(qObj_t)
     D                                     options(*nopass)
      *
     D p_qEventf       c                   1
      *
     D qEventf         ds                  likeds(i_qEventf)
      *
      *  Nachrichten
      *  ... Verarbeitung in Zeile &1 abgebrochen.
      /COPY QSTRPREPRC,PRZ0002
      /free

         if (%parms() >= p_qEventf and %addr(i_qEventf) <> *null);
            qEventf = i_qEventf;
         else;
            clear qEventf;
         endif;

         if (g_option.isEventf);
            writeJobLogToEventf(qEventf: cTrue);
         endif;

         if (%open(SRCFILE));
            close SRCFILE;
         endif;

         if (%open(STRPRE1));
            close STRPRE1;
         endif;

         if (%open(INCLUDE));
            close INCLUDE;
         endif;

         clear PRZ0002;
         PRZ00021 = f1_line_number;
         sendMsg(f_newMsg('PRZ0002': PRZ0002: cTYPE_ESCAPE));

      /end-free
     P                 e
      *
      * =============================================================
      *  Beenden Programm normal
      * =============================================================
     P endOK...
     P                 b
     D                 pi
     D  i_qEventf                          const  likeds(qObj_t)
     D                                     options(*nopass)
      *
     D p_qEventf       c                   1
      *
     D qEventf         ds                  likeds(i_qEventf)
      *
      *  Nachrichten
      *  ... EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konnte nicht geöffnet
      /COPY QSTRPREPRC,PRZ0025
      /free

         if (%parms() >= p_qEventf and %addr(i_qEventf) <> *null);
            qEventf = i_qEventf;
         else;
            clear qEventf;
         endif;

         if (g_option.isEventf);
            writeJobLogToEventf(qEventf: cFalse);
         endif;

      /end-free
     P                 e
      *
      * =============================================================
      *  Write job log entries to the event file.
      *
      *  i_qEventf - Event file created by the object creation
      *              command. If the object name was overridden by
      *              a STRPREPRC >>PARM<< tag, the events ctreated by
      *              the object creation command must be copied to
      *              the event file created by STRPREPRC.
      * =============================================================
     P writeJobLogToEventf...
     P                 b
     D                 pi
     D  i_qEventf                          const  likeds(qObj_t)
     D  i_isAbnEnd                     n   const
      *
     D isEmpty         s               n
     D doAppend        s               n
     D doAppendJobLog  s               n
      *  ... EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konnte nicht geöffnet
      /COPY QSTRPREPRC,PRZ0025
      /free

         monitor;

            // Event file of IBM object creation command
            if (g_eventf.lib <> '' and g_eventf.mbr <> '');
               isEmpty = isEmptyEventFile(g_eventf.lib: g_eventf.mbr);
            else;
               isEmpty = cTrue;
            endif;

            select; // g_prePostCmdsMode
            when (g_prePostCmdsMode = MODE_PRECMDS);
               doAppendJobLog = i_isAbnEnd;
            when (g_prePostCmdsMode = MODE_EXECUTE);
               doAppendJobLog = isEmpty and
                                (i_isAbnEnd or g_option.doAppendJobLog);
            when (g_prePostCmdsMode = MODE_POSTCMDS);
               doAppendJobLog = i_isAbnEnd;
            other;
               doAppendJobLog = cFalse;
            endsl;

            if (doAppendJobLog);
               doAppend = not isEmpty;
               // TODO: Copy compile listing from pre/post-command if available
               //       instead of appending the job log???
               // g_eventf.isOpen = openEventFile(g_eventf.mbr: g_eventf.lib
               //                                 : doAppend: i_qEventf);
               g_eventf.isOpen = openEventFile(
                                    g_eventf.mbr: g_eventf.lib: doAppend);
               if (g_eventf.isOpen);
                  writeEventFile(
                     g_srcFile.name: g_srcFile.lib: g_srcFile.mbr
                     : f1_line_number: i_isAbnEnd);
               endif;
            endif;

         on-error;
            g_eventf.isOpen = cFalse;
            clear PRZ0025;
            PRZ00251 = g_eventf.lib;
            sendMsg(f_newMsg('PRZ0025': PRZ0025: cTYPE_DIAG));
         endmon;

         // Allways try to close the event file.

         monitor;

            if (g_eventf.isOpen);
               closeEventFile();
               g_eventf.isOpen = cFalse;
            endif;

         on-error;
            // Ignore close errors.
         endmon;

      /end-free
     P                 e
      *
      *===============================================================*
      *  Replace variables
      *===============================================================*
     P replaceVar...
     P                 b
     D                 pi
     D  i_var                        10a   value
     D  i_value                            value  like(cmdLong_t)
     D  io_string                                 like(cmdLong_t)
      *
     D x               s                   like(int4_t)
      /free

         dou (x = 0);
            if (x > 0);
               io_string = %replace(%trim(i_value)
                                    : io_string
                                    : x
                                    : %len(%trim(i_var)));
            endif;
            x = %scan(%trim(i_var): io_string);
         enddo;

      /end-free
     P                 E
      *
      *===============================================================*
      *  Check existence of a stream file
      *===============================================================*
     P chkMbr...
     P                 b                   export
     D                 pi
     D  i_file                       10a   const
     D  i_lib                        10a   const
     D  i_mbr                        10a   const
      *
     D rc              s             10i 0
      *
      *  system -- Execute a Command
      *     Return value       Meaning
      *     ----------------   --------------------------------------
      *     0                  the command is successful
      *     -1                 for a NULL pointer
      *     1                  the command fails
     d system          pr            10i 0 extproc('system')
     d  i_clCommand                    *   value options(*string)
      *
      *  Nachrichten
      *  ... Bibliothek &1 nicht gefunden.
      /COPY QSTRPREPRC,PRZ0035
      *  ... Datei &1 in Bibliothek &2 nicht gefunden.
      /COPY QSTRPREPRC,PRZ0036
      *  ... Teildatei &3 von Datei &1 in Bibliothek &2 nicht gefunden.
      /COPY QSTRPREPRC,PRZ0037
      /free

         if (%subst(i_lib: 1: 1) <> '*');
            rc = system('CHKOBJ OBJ(' + %trim(i_lib) + ') OBJTYPE(*LIB)');
            if (rc <> 0);
               clear PRZ0035;
               PRZ00351 = i_lib;
               sendMsg(f_newMsg('PRZ0035': PRZ0035: cTYPE_ESCAPE));
            endif;
         endif;

         rc = system('CHKOBJ OBJ(' + %trim(i_lib) + '/' +
                                     %trim(i_file) + ') OBJTYPE(*FILE)');
         if (rc <> 0);
            clear PRZ0036;
            PRZ00361 = i_file;
            PRZ00362 = i_lib;
            sendMsg(f_newMsg('PRZ0036': PRZ0036: cTYPE_ESCAPE));
         endif;

         rc = system('CHKOBJ OBJ(' + %trim(i_lib) + '/' +
                                     %trim(i_file) + ') OBJTYPE(*FILE) ' +
                                     'MBR(' + %trim(i_mbr) + ')');
         if (rc <> 0);
            clear PRZ0037;
            PRZ00371 = i_file;
            PRZ00372 = i_lib;
            PRZ00373 = i_mbr;
            sendMsg(f_newMsg('PRZ0037': PRZ0037: cTYPE_ESCAPE));
         endif;

      /end-free
     P                 E
      *
      *===============================================================*
      *  Remove file open message:
      *  CPF4011 - Buffer length longer than record for member
      *===============================================================*
     P removeFileOpenMessage...
     P                 b
     D                 pi
      *
     D rcvm0100        ds                  likeds(rcvm0100_t)
     D errCode         ds                  likeds(errCode_t)
      /free

       errCode = f_newApiErrCode(cTrue); // ignore errors

       QMHRCVPM(rcvm0100: %size(rcvm0100): 'RCVM0100': '*': 1
                : '*ANY': '': 0: '*SAME': errCode);

       if (not f_isApiError(errCode) and rcvm0100.msgID = 'CPF4011');
          QMHRMVPM('*' : 1: rcvm0100.msgKey: '*BYKEY': errCode);
       endif;


      /end-free
     P                 E
      *
** CTDATA g_crtCmdsDta
CRTBNDCL    PGM         Create Bound CL Program
CRTBNDRPG   PGM         Create Bound RPG Program
CRTCBLMOD   MODULE      Create COBOL Module
CRTCLMOD    MODULE      Create CL Module
CRTCLD      CLD         Create C Locale Description
CRTCMOD     MODULE      Create C Module
CRTCMD      CMD         Create Command
CRTCPPMOD   MODULE      Create C++ Module
CRTDSPF     FILE        Create Display File
CRTMNU      MENU        Create Menu
CRTPNLGRP   PNLGRP      Create Panel Group
CRTPRTF     FILE        Create Printer File
CRTQMQRY    QMQRY       Create Query Management Query
CRTRPGMOD   MODULE      Create RPG Module
CRTSQLCBL   PGM         Create SQL COBOL Program
CRTSQLCBLI  OBJ         Create SQL ILE COBOL Object
CRTSQLCI    OBJ         Create SQL ILE C object
CRTSQLCPPI  OBJ         Create SQL ILE C++ Object
CRTSQLRPG   PGM         Create SQL RPG Program
CRTSQLRPGI  OBJ         Create SQL ILE RPG Object
CRTTBL      TBL         Create Table
XCRTSQLOBJ  SQLOBJ      Create SQL-Object
