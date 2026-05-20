**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : STRPREPRC                                          *
//  Objekt  . . . : STRPREPRC2                                         *
//  Beschreibung  : Start Pre-Processor - Services                     *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 21.11.2000                                         *
//                                                                     *
// =================================================================== *
//                                                                     *
//  This software is free software, you can redistribute it and/or     *
//  modify it under the terms of the GNU General Public License (GPL)  *
//  as published by the Free Software Foundation.                      *
//                                                                     *
//  See GNU General Public License for details.                        *
//          http://www.opensource.org                                  *
//          http://www.opensource.org/licenses/gpl-license.html        *
//                                                                     *
//=====================================================================*
//  History:                                                           *
//                                                                     *
//  Datum       Name          Änderung                                 *
//  ----------  ------------  ---------------------------------------  *
//  21.05.2002  Th.Raddatz    Removed special characters from src mbr  *
//                                                                     *
//  23.01.2007  Th.Raddatz    Added parameter TAGSREQ(...) to command. *
//                                                                     *
//  20.02.2009  Th.Raddatz    Added Pre-Compiler tag "WIDTH".          *
//                            Moved H-Specs into member H_SPEC.        *
//                                                                     *
//  09.04.2015  Hildebrandt   Added parameter EXICMDEXC to command.    *
//                                                                     *
//  16.05.2015  Th.Raddatz    Added parameter EVENTF to command.       *
//                                                                     *
//  18.05.2015  Th.Raddatz    Converted to /free.                      *
//                                                                     *
//  18.06.2015  Th.Raddatz    Renamed parameter EVENTF to OPTION.      *
//                                                                     *
//  23.07.2015  Th.Raddatz    Fixed problem that the EVFEVENT file     *
//                            was not created when the creation        *
//                            command had been executed implicitly.    *
//                                                                     *
//  17.12.2015  Th.Raddatz    Fixed executeCmd(), which must           *
//                            pass 'executeCmd' case sensitive         *
//                            to getMsgInf();                          *
//                                                                     *
//  18.02.2016  Th.Raddatz    Added the >IMPORTANT< parameter tag.     *
//                                                                     *
//  10.03.2016  Th.Raddatz    Added message PRZ0028.                   *
//                                                                     *
//  20.10.2016  Th.Raddatz    Now calling prepareEventFile() right at  *
//                            beginning of the program to capture      *
//                            early STRPREPRC errors.                  *
//                                                                     *
//  09.01.2017  Th.Raddatz    Now logging the complete command, when   *
//                            it could not be executed.                *
//                                                                     *
//  17.01.2017  Th.Raddatz    Added option *ADDJOBLOG to append the    *
//                            job log to event files create by IBM     *
//                            object creation commands.                *
//                                                                     *
//  28.01.2017  Th.Raddatz    Fixed problem, that event file entries   *
//                            created by an IBM object creation command*
//                            were lost, when the object name was      *
//                            overridden in the STRPREPRC section.     *
//                                                                     *
//  06.02.2017  Th.Raddatz    Changed interface of exit program.       *
//                                                                     *
//  15.09.2017  Th.Raddatz    Added parameter LIBL to STRPREPRC        *
//                            command.                                 *
//                            Added header tags 'LIBL' and 'CURLIB'    *
//                            to STRPREPRC command.                    *
//                            Added replacement variables &LL, &CL,    *
//                            &LX and &CX to STRPREPRC utility.        *
//                                                                     *
//  16.09.2017  Th.Raddatz    Changed length of parameter CMD from     *
//                            2048 to 8192.                            *
//                                                                     *
//  18.09.2017  Th.Raddatz    Fixed problem that 'cmdLongLength'       *
//                            was not properly filled.                 *
//                                                                     *
//  20.09.2017  Th.Raddatz    Added parameter USELIBL to let STRPREPRC *
//                            run the XCRTSQLOBJ command of CMOne      *
//                            for source members without a STRPREPRC   *
//                            header.                                  *
//                            Renamed a couple of procedures for       *
//                            better names.                            *
//                                                                     *
//  21.09.2017  Th.Raddatz    Fixed parameter length of replaceVar().  *
//                                                                     *
//  22.09.2017  Th.Raddatz    Added parameter USRDEFVAR to STRPREPRC   *
//                            command.                                 *
//                                                                     *
//  19.11.2017  Th.Raddatz    Fixed bug in restoreLibraryList() to     *
//                            restore the library list.                *
//                                                                     *
//  11.02.2019  Th.Raddatz    Replaced OVRDBF of module STRPREPRC1     *
//                            with EXTFILE and EXTMBR in STRPREPRC2.   *
//                            Moved checking of object existence to    *
//                            STRPREPRC2.                              *
//                            Moved handling the *DFT special value to *
//                            STRPREPRC2.                              *
//                                                                     *
//  08.05.2019  Th.Raddatz    Added procedure readLine().              *
//                                                                     *
//  17.05.2019  Th.Raddatz    Added new tags for monitoring messages   *
//                            of 'CMD' tags. The new tags are:         *
//                              'CMD'  CHKOBJ FOO/BAR *FILE;           *
//                              'MONMSG'                               *
//                                'MSGID' CPF9801; // Object not found *
//                              'END-MONMSG'                           *
//                                                                     *
//  26.04.2020  Th.Raddatz    Added 'INCLUDE' tag.                     *
//                                                                     *
//  23.12.2020  Th.Raddatz    Fixed content auf g_srcFile.* variables. *
//                            Fixed error message when attempting to   *
//                            execute an empty command.                *
//                            Fixed decision when to append the job    *
//                            log messages to the EVFEVENT file.       *
//                            Added iRPGUnit test suite STRPREPRCT.    *
//                                                                     *
//  04.01.2021  Th.Raddatz    Added messages:                          *
//                              PRZ0033 - Objekt created               *
//                              PRZ0034 - Error message ignored ...    *
//                                                                     *
//  26.01.2021  Th.Raddatz    Fixed problem that parameter &LX was     *
//                            not replaced when the library list was   *
//                            empty.                                   *
//                                                                     *
//  18.05.2021  Th.Raddatz    Changed performSetLibraryList(),         *
//                            performSetCurrentLibrary() and           *
//                            peformCmd() to call endAbnormal()        *
//                            without 'event file' parameter.          *
//                                                                     *
//  18.05.2021  Th.Raddatz    Changed writeJobLogToEventf() to copy    *
//                            the event file data from the actual      *
//                            event file used by the IBM object        *
//                            creation command.                        *
//                                                                     *
//  19.05.2021  Th.Raddatz    Fixed duplicate TIMESTAMP and PROCESSOR  *
//                            entries after copying an EVENTF member.  *
//                                                                     *
//  19.11.2021  Th.Raddatz    Fixed problem that the *LDA was not      *
//                            properly set. (==> updateLDA())          *
//                                                                     *
//  15.03.2022  Th.Raddatz    Added module STRPREPRC5 to prepare the   *
//                            utility to support stream files.         *
//                                                                     *
//  16.03.2022  Th.Raddatz    Renamed PROTO_H to TYPES_H.              *
//                                                                     *
//  15.03.2022  Th.Raddatz    Moved files SRCFILE and INCLUDE to       *
//                            member STRPREPRC5.                       *
//                            Created prototypes and moved global      *
//                            fields and constants to TYPES_H.         *
//                                                                     *
//  21.03.2022  Th.Raddatz    Added parameters USESRCSTMF and STMF     *
//                            to support IFS stream files.             *
//                                                                     *
//  21.03.2022  Th.Raddatz    Added include file syntax:               *
//                              library/file,member                    *
//                                                                     *
//  26.03.2022  Th.Raddatz    Added variables &STMF, &FOLDER and &FILE.*
//                                                                     *
//  26.03.2022  Th.Raddatz    Added stream file support.               *
//                                                                     *
//  12.01.2023  Th.Raddatz    Changed all parameters of run() to const.*
//                                                                     *
//  15.05.2026  Th.Raddatz    Added parameters RNF7031.                *
//                                                                     *
// =================================================================== *
// >>PRE-COMPILER<<                                                    *
//   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
//                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
//   >>IMPORTANT<<                                                     *
//     >>PARM<< TRUNCNBR(*NO);                                         *
//     >>PARM<< DBGVIEW(*LIST);                                        *
//     >>PARM<< OPTION(*EVENTF);                                       *
//   >>END-IMPORTANT<<                                                 *
//   >>EXECUTE<<                                                       *
// >>END-PRE-COMPILER<<                                                *
// =================================================================== *
ctl-opt nomain bnddir('QC2LE');
/copy QSTRPREPRC,H_SPEC
/copy QSTRPREPRC,COPYRIGHT
// =================================================================== *
//
// -------------------------------------------------------------
//  Verwendete Dateien
// -------------------------------------------------------------

dcl-f STRPRE1 keyed usropn prefix(P1) extfile(g_strpre1.name) extmbr(g_strpre1.member) infds(f2);

dcl-ds g_strpre1 qualified inz;
  name   varchar(21);
  member varchar(10);
end-ds;

dcl-ds f2 qualified;
  status   zoned(5) pos(11);
  file     char(10) pos(83);
  lib      char(10);
  rcdLen   bindec(4) pos(125);
  mbr      char(10) pos(129);
  nbrOfKey bindec(4) pos(387);
  rcdNbr   bindec(9) pos(397);
end-ds;

// -------------------------------------------------------------
//  Globale Konstanten
// -------------------------------------------------------------
dcl-c cNone '*NONE';

//  Pre-Prozessor Tags
dcl-c cTAG_PREPRZ '>>PRE-COMPILER<<';
dcl-c cTAG_ENDPREPRZ '>>END-PRE-COMPILER<<';

dcl-c cTAG_LINK '>>LINK<<';
dcl-c cTAG_ENDLINK '>>END-LINK<<';

dcl-c cTAG_COMPILE '>>COMPILE<<';
dcl-c cTAG_ENDCOMPILE '>>END-COMPILE<<';

dcl-c cTAG_IMPORTANT '>>IMPORTANT<<';
dcl-c cTAG_ENDIMPORTANT '>>END-IMPORTANT<<';

dcl-c cTAG_MONMSG '>>MONMSG<<';
dcl-c cTAG_MSGID '>>MSGID<<';
dcl-c cTAG_ENDMONMSG '>>END-MONMSG<<';

dcl-c cTAG_WIDTH '>>WIDTH<<';
dcl-c cTAG_CRTCMD '>>CRTCMD<<';
dcl-c cTAG_PARM '>>PARM<<';
dcl-c cTAG_EXECUTE '>>EXECUTE<<';
dcl-c cTAG_CMD '>>CMD<<';
dcl-c cTAG_INCLUDE '>>INCLUDE<<';
dcl-c cTAG_LIBL '>>LIBL<<';
dcl-c cTAG_CURLIB '>>CURLIB<<';

//  Pre-Prozessor Modi
dcl-c cMODE_SCAN '*SCAN';
dcl-c cMODE_PREPRZ '>>PRE-COMPILER<<';
dcl-c cMODE_ENDPREPRZ '*EXIT';

dcl-c cMODE_LINK '>>LINK<<';
dcl-c cMODE_ENDLINK '>>END-LINK<<';

dcl-c cMODE_COMPILE '>>COMPILE<<';
dcl-c cMODE_ENDCOMPILE '>>END-COMPILE<<';

dcl-c cMODE_IMPORTANT '>>IMPORTANT<<';
dcl-c cMODE_ENDIMPORTANT '>>END-IMPORTANT<<';

dcl-c cMODE_MONMSG '>>MONMSG<<';
dcl-c cMODE_MSGID '>>MSGID<<';
dcl-c cMODE_ENDMONMSG '>>END-MONMSG<<';

dcl-c cMODE_WIDTH '>>WIDTH<<';
dcl-c cMODE_CRTCMD '>>CRTCMD<<';
dcl-c cMODE_PARM '>>PARM<<';
dcl-c cMODE_EXECUTE '>>EXECUTE<<';
dcl-c cMODE_CMD '>>CMD<<';
dcl-c cMODE_INCLUDE '>>INCLUDE<<';
dcl-c cMODE_LIBL '>>LIBL<<';
dcl-c cMODE_CURLIB '>>CURLIB<<';

//  Zeilenendemarkierungen
dcl-c cNEW_LINE ' ';
dcl-c cTRUNC_CONT '+';
dcl-c cCONT '-';
dcl-c cEND_OF_LINE ';';

dcl-c cEVENTF_NO '*NOEVENTF';
dcl-c cEVENTF_YES '*EVENTF';

dcl-c cJOBLOG_NO '*NOJOBLOG';
dcl-c cJOBLOG_YES '*ADDJOBLOG';

dcl-c EXEC_ALL '*ALL';
dcl-c EXEC_PRECMDS '*PRECMDS';
dcl-c EXEC_CRTCMD '*CRTCMD';
dcl-c EXEC_POSTCMDS '*POSTCMDS';

dcl-c CURLIB_CRTDFT '*CRTDFT';

dcl-c SINGLE_QUOTE '''';
dcl-c DOUBLE_QUOTE '"';
// -------------------------------------------------------------
//  Globale Variablen
// -------------------------------------------------------------
dcl-s g_mode like(mode_t) dim(10) inz;
dcl-s g_modeCnt like(int4_t) inz;
dcl-s g_pgmCmdExc like(pgm_t) inz;
dcl-s g_libPgmCmdExc like(lib_t) inz;
dcl-s g_width int(10) inz(-1);

dcl-ds g_eventf qualified;
  isOpen ind inz(cFalse);
  mbr    char(10) inz;
  lib    char(10) inz('*N');
end-ds;

dcl-ds g_option qualified inz;
  isEventf       ind inz(cFalse);
  doAppendJobLog ind inz(cFalse);
end-ds;

dcl-s g_enforceJobLogOnError ind;

dcl-ds g_execOpt likeds(execOpt_t);

dcl-ds g_srcFile qualified;
  name char(10);
  lib  char(10);
  mbr  char(10);
end-ds;

// Known creation commands and their object name keywords
dcl-ds g_crtCmds qualified based(g_pCrtCmds) dim(22);
  cmd        char(10);
  reserved_1 char(2);
  keyword    char(10);
  reserved_2 char(2);
  text       char(50);
end-ds;

dcl-s g_crtCmdsDta char(74) dim(22) ctdata;
dcl-s g_pCrtCmds pointer inz(%addr(g_crtCmdsDta));

dcl-ds g_startUpLiblList likeds(liblList_t) inz;

dcl-s g_prePostCmdsMode int(10);

dcl-c MODE_PRECMDS 1;
dcl-c MODE_EXECUTE 2;
dcl-c MODE_POSTCMDS 3;

/copy QSTRPREPRC,SDS

// -------------------------------------------------------------
//  Exportierte Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,PSTRPREPR2

// -------------------------------------------------------------
//  Importierte Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,PSTRPREPR4
/copy QSTRPREPRC,PSTRPREPR5
/copy QSTRPREPRC,PSTRPREPR6
/copy QSTRPREPRC,QMHRCVPM
/copy QBASICS1,PBASICS1
/copy QSTRPREPRC,TYPES_H
/copy QSTRPREPRC,QCAPCMD
/copy QSTRPREPRC,QWCRTVCA
/copy QEVENTF,PEVENTF

// -------------------------------------------------------------
//  Prototypen
// -------------------------------------------------------------

dcl-pr readLine ind extproc('readLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

dcl-pr readPrvLine ind extproc('readPrvLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

dcl-pr getSpcValDft like(path_t) extproc('getValue');
  i_actual  like(path_t) options(*varsize) const;
  i_default like(path_t) options(*varsize) const;
end-pr;

dcl-pr restoreLibraryList extproc('restoreLibraryList');
end-pr;

dcl-pr resetLineData extproc('resetLineData');
  io_lineData likeds(lineData_t);
end-pr;

dcl-pr replaceVars like(cmdLong_t) extproc('replaceVars');
  i_cmd       like(cmdLong_t) value;
  i_variables likeds(variables_t) value;
end-pr;

dcl-pr libListToStr like(cmdLong_t) extproc('libListToStr');
  i_libl likeds(libl_t) value;
end-pr;

dcl-pr performExecute extproc('performExecute');
  i_cmd        like(cmdLong_t) value;
  i_cmdChgObjD like(cmdLong_t) value;
end-pr;

dcl-pr performCmd extproc('performCmd');
  i_cmd like(cmdLong_t) value;
end-pr;

dcl-pr performInclude extproc('performInclude');
  i_include like(cmdLong_t) value;
end-pr;

dcl-pr performIncludeStmf extproc('performIncludeStmf');
  i_include like(cmdLong_t) value;
end-pr;

dcl-pr performIncludeMember extproc('performIncludeMember');
  i_include like(cmdLong_t) value;
end-pr;

dcl-pr performSetLibraryList extproc('performSetLibraryList');
  i_libl       like(cmdLong_t) value;
  io_variables likeds(variables_t);
end-pr;

dcl-pr performSetCurrentLibrary extproc('performSetCurrentLibrary');
  i_libl       like(cmdLong_t) value;
  io_variables likeds(variables_t);
end-pr;

dcl-pr loadMonitoredMessageIDs likeds(monMsgIds_t) extproc('loadMonitoredMessageIDs');
end-pr;

dcl-pr isMonitoredMessageID ind extproc('isMonitoredMessageID');
  i_errMsgId  like(msgId_t) value;
  i_monMsgIds likeds(monMsgIds_t) value;
end-pr;

dcl-pr isExecOpt ind extproc('isExecOpt');
  i_execOpt like(execOpt_t.execOpt) value;
end-pr;

dcl-pr retrieveLibraryList likeds(liblList_t) extproc('retrieveLibraryList');
end-pr;

dcl-pr retrieveEventFile likeds(qObj_t) extproc('retrieveEventFile');
  i_cmd like(cmdLong_t) value;
end-pr;

dcl-pr addData like(keyData_t) extproc('addData');
  i_tag       like(tag_t) value;
  i_keyData   like(keyData_t) value;
  i_srcDta    like(srcDta_t) value;
  io_continue like(continue_t);
end-pr;

dcl-pr getWidthValue int(10) extproc('getWidthValue');
  i_srcDta like(srcDta_t) value;
  i_length int(10) value;
end-pr;

dcl-pr replaceCmdKeyWord like(cmdLong_t) extproc('replaceCmdKeyWord');
  i_cmd     like(cmdLong_t) value;
  i_keyData like(keyData_t) value;
end-pr;

dcl-pr getSrcDataLength like(int4_t) extproc('getSrcDataLength');
end-pr;

dcl-pr getStartPos like(int4_t) extproc('getStartPos');
  i_tag    like(tag_t) value;
  i_srcDta like(srcDta_t);
end-pr;

dcl-pr isTag like(bool_t) extproc('isTag');
  i_srcDta like(srcDta_t) value;
  o_tag    like(tag_t);
end-pr;

dcl-pr retrieveTag like(bool_t) extproc('retrieveTag');
  i_tagToTest like(tag_t) value;
  i_srcDta    like(srcDta_t) value;
  o_tag       like(tag_t);
end-pr;

dcl-pr tagToMode like(mode_t) extproc('tagToMode');
  i_tag like(tag_t) value;
end-pr;

dcl-pr checkMode ind extproc('checkMode');
  i_mode    like(mode_t) value;
  i_newMode like(mode_t) value;
end-pr;

dcl-pr pushMode extproc('pushMode');
  i_mode like(mode_t) value;
end-pr;

dcl-pr popMode like(mode_t) extproc('popMode');
end-pr;

dcl-pr validateCmd like(bool_t) extproc('validateCmd');
  i_cmd like(cmdLong_t) value;
end-pr;

dcl-pr executeCmd like(bool_t) extproc('executeCmd');
  i_monErr   like(bool_t) value;
  i_cmd      like(cmdLong_t) value;
  o_errMsgId like(msgId_t) options(*nopass);
end-pr;

dcl-pr appendToJobLog extproc('appendToJobLog');
  i_message like(cmdLong_t) value;
end-pr;

dcl-pr formatCmd like(cmdLong_t) extproc('formatCmd');
  i_cmd like(cmdLong_t) value;
end-pr;

dcl-pr endOK extproc('endOK');
  i_qEventf likeds(qObj_t) options(*nopass) const;
end-pr;

dcl-pr writeJobLogToEventf extproc('writeJobLogToEventf');
  i_qEventf  likeds(qObj_t) const;
  i_isAbnEnd ind const;
end-pr;

dcl-pr replaceVar extproc('replaceVar');
  i_var     char(10) value;
  i_value   like(cmdLong_t) value;
  io_string like(cmdLong_t);
end-pr;


//  Register Call Stack Entry Termination User Exit Procedure (CEERTX)
dcl-pr CEERTX extproc('CEERTX');
  i_procPtr  pointer(*proc) const;
  i_rtxToken pointer options(*omit) const;
  o_fc       char(12) options(*omit);
end-pr;

dcl-pr abnormalEndHandler extproc('abnormalEndHandler');
  i_rtxToken pointer const;
end-pr;

//  Unregister Call Stack Entry Termination User Exit Procedure (CEEUTX)
dcl-pr CEEUTX extproc('CEEUTX');
  i_procPtr pointer(*proc) const;
  o_fc      char(12) options(*omit);
end-pr;

// =============================================================
//  Ausführen Pre-Prozessor
// =============================================================
dcl-proc run export;
  dcl-pi *n;
    i_useSrcFile   like(file_t) const;
    i_useSrcLib    like(lib_t) const;
    i_useSrcMbr    like(mbr_t) const;
    i_useSrcStmf   like(path_t) const;
    i_cmd          like(cmd_t) const;
    i_chgObjD      like(chgObjD_t) const;
    i_objType      like(objType_t) const;
    i_objSrcFile   like(file_t) const;
    i_objSrcLib    like(lib_t) const;
    i_objSrcMbr    like(mbr_t) const;
    i_lib          like(lib_t) const;
    i_obj          like(obj_t) const;
    i_typeCode     like(typeCode_t) const;
    i_srcLib       like(lib_t) const;
    i_srcFile      like(file_t) const;
    i_srcMbr       like(mbr_t) const;
    i_testLib      like(lib_t) const;
    i_testObj      like(obj_t) const;
    i_tgtRls       like(tgtRls_t) const;
    i_frmSrcLib    like(lib_t) const;
    i_frmSrcFile   like(file_t) const;
    i_frmSrcMbr    like(mbr_t) const;
    i_user0        like(userParm_t) const;
    i_user1        like(userParm_t) const;
    i_user2        like(userParm_t) const;
    i_user3        like(userParm_t) const;
    i_user4        like(userParm_t) const;
    i_user5        like(userParm_t) const;
    i_user6        like(userParm_t) const;
    i_user7        like(userParm_t) const;
    i_user8        like(userParm_t) const;
    i_user9        like(userParm_t) const;
    i_stmf         like(path_t) const;
    i_tagsReq      like(bool_t) const;
    i_msgFile      like(msg_t.file) const;
    i_msgFileLib   like(msg_t.lib) const;
    i_pgmCmdExc    like(pgm_t) const;
    i_libPgmCmdExc like(lib_t) const;
    i_option       likeds(option_t) const;
    i_libl         likeds(inpLibList_t) const;
    i_useLibl      like(bool_t) const;
    i_usrDefVars   likeds(inpUsrDefVars_t) const;
    i_execOpt      likeds(execOpt_t) const;
    i_rnf7031      like(rnf7031_t) const;
  end-pi;

  //  Nachrichten
  //  ... Falsche Reihenfolge im Betriebsmodus.
/copy QSTRPREPRC,PRZ0001
  //  ... Fehler beim Öffnen der Steuerdatei &2/&1, Teildatei &3.
/copy QSTRPREPRC,PRZ0013
  //  ... Auszuführender Befehl fehlt. Weitere Verarbeitung nich . . .
/copy QSTRPREPRC,PRZ0014
  //  ... Keine Pre-Compiler Anweisungen in Quellendatei &2/&1, Teildatei &3 gefunden.
/copy QSTRPREPRC,PRZ0024
  //  ... EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konnte nicht geöffnet
/copy QSTRPREPRC,PRZ0025
  //  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
/copy QSTRPREPRC,PRZ0026
  //  ... Erstellungsbefehl nicht gefunden in Quellendatei &2/&1, Teildatei &3.
/copy QSTRPREPRC,PRZ0028
  //  ... Die Option *ADDJOBLOG ist nur in Verbindung mit *EVENTF zulässig.
/copy QSTRPREPRC,PRZ0030
  //  ... Erstellungsbefehl nicht gefunden in Quellendatei &1
/copy QSTRPREPRC,PRZ0044
  //  ... Erstellungsbefehl nicht gefunden in Quellendatei &2
/copy QSTRPREPRC,PRZ0045

  //  Arbeitsfelder
  dcl-s i int(10) inz;
  dcl-s srcDta like(ds_srcFile_t.srcDta);
  dcl-s tag like(tag_t) inz;
  dcl-s mode like(mode_t) inz;
  dcl-s newMode like(mode_t) inz;
  dcl-s cmdString like(cmdLong_t) inz;
  dcl-s execCmdImplizit like(bool_t) inz(cTrue);
  dcl-s foundPrePrcTags like(bool_t) inz(cFalse);
  dcl-s cmdChgObjD like(cmdLong_t);
  dcl-s cmd like(cmdLong_t);
  dcl-s isCmdMissingError ind inz(cFalse);
  dcl-s isMonMsgAllowed ind inz(cFalse);

  dcl-ds lineData likeds(lineData_t) inz;
  dcl-ds variables likeds(variables_t) inz;
  dcl-ds inpUsrDefVar likeds(inpUsrDefVar_t);
  dcl-s objSrcFile like(i_objSrcFile);
  dcl-s objSrcLib like(i_objSrcLib);
  dcl-s objSrcMbr like(i_objSrcMbr);

  dcl-s rnf7031Value like(i_rnf7031);

  ceertx(%paddr('abnormalEndHandler'): *omit: *omit);

  p_setAppMsgFile(i_msgFile: i_msgFileLib);

  g_startUpLiblList = retrieveLibraryList();

  g_prePostCmdsMode = MODE_PRECMDS;

  // Initialisieren globaler Variablen
  reset g_mode;
  reset g_modeCnt;
  reset g_pgmCmdExc;
  reset g_libPgmCmdExc;
  reset g_eventf;
  reset g_option;
  reset g_execOpt;
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
      sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_DIAG));
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
  variables.stmf = getSpcValDft(i_stmf: i_useSrcStmf);
  variables.folder = Path_getFolder(variables.stmf);
  variables.file = Path_getFile(variables.stmf);
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
    // pInpUsrDefVar = %addr(i_usrDefVars) + i_usrDefVars.offsItems(i);
    inpUsrDefVar = %subst(i_usrDefVars
                          : i_usrDefVars.offsItems(i) + 1
                          : %len(inpUsrDefVar));
    variables.usrDefVars.numE += 1;
    variables.usrDefVars.var(variables.usrDefVars.numE).name =
       inpUsrDefVar.name;
    variables.usrDefVars.var(variables.usrDefVars.numE).value =
       inpUsrDefVar.value;
  endfor;

  rnf7031Value = setReturnRNF7031Messages(i_rnf7031);

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

  if (i_useSrcStmf <> '');
    // Open IFS source file
    SourceStreamFile_open(i_useSrcStmf);
  else;
    // Open QSYS source file
    SourceFile_open(i_useSrcLib: i_useSrcFile: i_useSrcMbr);
  endif;

  // Open Pre-Compiler tags file
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

  // Entfernen der "öffnen" Nachrichten
  p_rmvPgmMsg(cMsg_Rmv_All);

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

  if (SourceStreamFile_isOpen());
    SourceStreamFile_close();
  endif;

  if (SourceFile_isOpen());
    SourceFile_close();
  endif;

  if (%open(STRPRE1));
    close STRPRE1;
  endif;

  if (IncludeStreamFile_isOpen);
    IncludeStreamFile_close();
  endif;

  if (IncludeFile_isOpen);
    IncludeFile_close();
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
    if (SourceStreamFile_isOpen());
      clear PRZ0045;
      PRZ00451 = SourceStreamFile_getFolder();
      PRZ00452 = SourceStreamFile_getFile();
      sendMsg(f_newMsg('PRZ0045': PRZ0045: cTYPE_ESCAPE));
    else;
      clear PRZ0024;
      PRZ00241 = SourceFile_getFile();
      PRZ00242 = SourceFile_getLibrary();
      PRZ00243 = SourceFile_getMember();
      sendMsg(f_newMsg('PRZ0024': PRZ0024: cTYPE_ESCAPE));
    endif;
  endif;

  if (isCmdMissingError);
    if (SourceStreamFile_isOpen());
      clear PRZ0044;
      PRZ00441 = SourceStreamFile_getFolder();
      PRZ00442 = SourceStreamFile_getFile();
      sendMsg(f_newMsg('PRZ0044': PRZ0044: cTYPE_ESCAPE));
    else;
      clear PRZ0028;
      PRZ00281 = SourceFile_getFile();
      PRZ00282 = SourceFile_getLibrary();
      PRZ00283 = SourceFile_getMember();
      sendMsg(f_newMsg('PRZ0028': PRZ0028: cTYPE_ESCAPE));
    endif;
  endif;

on-exit;
  setReturnRNF7031Messages(rnf7031Value);

end-proc;

// =============================================================
//  Reads a line from the source input file.
// =============================================================
dcl-proc readLine;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  //ds_srcFile      ds                  likeds(ds_srcFile_t) inz

  select;
  when (IncludeStreamFile_isOpen());
    if (not IncludeStreamFile_readLine(io_srcDta));
      IncludeStreamFile_close();
      // Read next line of source file
      return readLine(io_srcDta);
    endif;
  when (IncludeFile_isOpen());
    if (not IncludeFile_readLine(io_srcDta));
      IncludeFile_close();
      // Read next line of source file
      return readLine(io_srcDta);
    endif;
  when (SourceStreamFile_isOpen());
    if (not SourceStreamFile_readLine(io_srcDta));
      io_srcDta = '';
      return cFalse;
    endif;
  when (SourceFile_isOpen());
    if (not SourceFile_readLine(io_srcDta));
      io_srcDta = '';
      return cFalse;
    endif;
  other;
    // TODO: send escape message
    return cFalse;
  endsl;

  io_srcDta = %subst(io_srcDta: 1: getSrcDataLength());

  return cTrue;

end-proc;

// =============================================================
//  Read the previous line from the source input file.
// =============================================================
dcl-proc readPrvLine;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  select;
  when (IncludeStreamFile_isOpen());
    if (not IncludeStreamFile_readPrvLine(io_srcDta));
      IncludeStreamFile_close();
      // Read previous line of source file
      return readPrvLine(io_srcDta);
    endif;
  when (IncludeFile_isOpen());
    if (not IncludeFile_readPrvLine(io_srcDta));
      IncludeFile_close();
      // Read previous line of source file
      return readPrvLine(io_srcDta);
    endif;
  when (SourceStreamFile_isOpen());
    if (not SourceStreamFile_readLine(io_srcDta));
      io_srcDta = '';
      return cFalse;
    endif;
  when (SourceFile_isOpen());
    if (not SourceFile_readLine(io_srcDta));
      io_srcDta = '';
      return cFalse;
    endif;
  other;
    // TODO: send escape message
    return cFalse;
  endsl;

  io_srcDta = %subst(io_srcDta: 1: getSrcDataLength());

  return cTrue;

end-proc;

// =============================================================
//  Abnormal end handler.
// =============================================================
dcl-proc abnormalEndHandler;
  dcl-pi *n;
    i_pRtxToken pointer const;
  end-pi;

  // Restore library list to startup value
  restoreLibraryList();

end-proc;

// =============================================================
//  Returns the actual value or the default value if the
//  actual value is specified as *DFT.
// =============================================================
dcl-proc getSpcValDft;
  dcl-pi *n like(path_t);
    i_actual  like(path_t) options(*varsize) const;
    i_default like(path_t) options(*varsize) const;
  end-pi;

  if (i_actual = '*DFT');
    return i_default;
  endif;

  return i_actual;

end-proc;

// =============================================================
//  Restores the library list to what it was at the
//  start of the STRPREPRC utility.
// =============================================================
dcl-proc restoreLibraryList;
  dcl-pi *n;
  end-pi;

  dcl-ds currentLiblList likeds(liblList_t) inz;
  dcl-s liblStr like(cmdLong_t);
  dcl-s cmdString like(cmdLong_t) inz;

  currentLiblList = retrieveLibraryList();
  if (g_startUpLiblList <> currentLiblList);
    liblStr = libListToStr(g_startUpLiblList.usrLibl);
    cmdString = 'CHGLIBL +
                 LIBL(' + liblStr + ') +
                 CURLIB(' + g_startUpLiblList.curLib + ')';
    executeCmd(cFalse: cmdString);
  endif;

end-proc;

// =============================================================
//  Reset.
// =============================================================
dcl-proc resetLineData;
  dcl-pi *n;
    io_lineData likeds(lineData_t);
  end-pi;

  io_lineData.continue  = cNEW_LINE;
  io_lineData.keyData   = '';

end-proc;

// =============================================================
//  Replaces the replacement variables.
// =============================================================
dcl-proc replaceVars;
  dcl-pi *n like(cmdLong_t);
    i_cmd       like(cmdLong_t) value;
    i_variables likeds(variables_t) value;
  end-pi;

  dcl-s cmdString like(i_cmd);
  dcl-s posOfVar like(int4_t) inz;
  dcl-s i int(5);

  //  ... Fehlender Wert für Variable an Position &1 des auszuführenden Befehls.
/copy QSTRPREPRC,PRZ0023

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
  else;
    replaceVar(
    '&LX': '*NONE': cmdString);
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

  // Ersetzen Parameter  (&STMF)
  if (i_variables.stmf <> '');
    replaceVar('&STMF': i_variables.stmf: cmdString);
  endif;

  // Ersetzen Parameter  (&FOLDER)
  if (i_variables.folder <> '');
    replaceVar('&FOLDER': i_variables.folder: cmdString);
  endif;

  // Ersetzen Parameter  (&FILE)
  if (i_variables.file <> '');
    replaceVar('&FILE': i_variables.file: cmdString);
  endif;

  // Prüfen, ob alle Variablen ersetzt worden sind
  posOfVar = %scan('&': cmdString);

  if (posOfVar <> 0);
    clear PRZ0023;
    PRZ00231 = posOfVar;
    PRZ00232 = cmdString;
    sendMsg(f_newMsg('PRZ0023': PRZ0023: cTYPE_DIAG));
    appendToJobLog(i_cmd);
    endAbnormal();
  endif;

  return cmdString;

end-proc;

// =============================================================
//  Converts a library list to string.
// =============================================================
dcl-proc libListToStr;
  dcl-pi *n like(cmdLong_t);
    i_libl likeds(libl_t) value;
  end-pi;

  dcl-s i int(10);
  dcl-s liblStr like(cmdLong_t);

  for i = 1 to i_libl.numE;
    if (liblStr <> '');
      liblStr = liblStr + ' ';
    endif;
    liblStr = liblStr + %trim(i_libl.name(i));
  endfor;

  return liblStr;

end-proc;

// =============================================================
//  Execute >>EXECUTE<< tag. (Execute main creation command)
// =============================================================
dcl-proc performExecute;
  dcl-pi *n;
    i_cmd        like(cmdLong_t) value;
    i_cmdChgObjD like(cmdLong_t) value;
  end-pi;

  dcl-ds msg likeds(msg_t);

  //  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
/copy QSTRPREPRC,PRZ0026
  //  ... Objekt erstellt.
/copy QSTRPREPRC,PRZ0033

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
      sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_DIAG));
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
    clear PRZ0033;
    msg = f_newMsg('PRZ0033': PRZ0033: cMsg_Info);
    f_sndPgmMsg(msg: cMsg_Same: cMsg_ToMyself);

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

end-proc;

// =============================================================
//  Execute >>CMD<< tag (Pre and post commands)
// =============================================================
dcl-proc performCmd;
  dcl-pi *n;
    i_cmd like(cmdLong_t) value;
  end-pi;

  dcl-s errMsgId like(msgId_t);
  dcl-ds monMsgIds likeds(monMsgIds_t);
  dcl-ds msg likeds(msg_t);

  //  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
/copy QSTRPREPRC,PRZ0026
  //  ... Fehlernachricht &1 wurde aufgrund von MONMSG ignoriert.
/copy QSTRPREPRC,PRZ0034

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
      sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_DIAG));
      endAbnormal();
    endmon;
  endif;

  if (not validateCmd(i_cmd));
    endAbnormal();
  endif;

  if (not executeCmd(cTrue: i_cmd: errMsgId));
    monMsgIds = loadMonitoredMessageIDs();
    if (isMonitoredMessageId(errMsgId: monMsgIds));
      clear PRZ0034;
      PRZ00341 = errMsgId;
      msg = f_newMsg('PRZ0034': PRZ0034: cMsg_Info);
      f_sndPgmMsg(msg: cMsg_Same: cMsg_ToMyself);
    else;
      endAbnormal();
    endif;
  endif;

end-proc;

// =============================================================
//  Execute >>INCLUDE<< tag (Read /include)
// =============================================================
dcl-proc performInclude;
  dcl-pi *n;
    i_include like(cmdLong_t) value;
  end-pi;

  dcl-s include like(cmdLong_t);
  dcl-s stmf like(path_t);
  dcl-ds st_stat likeds(st_stat_t);
  dcl-s rc int(10);
  dcl-s isStmf ind;

  include = %trim(i_include);

  isStmf = cFalse;

  select;
  when (f_startsWith(SINGLE_QUOTE: include));
    stmf = f_rmvQuotes(include: SINGLE_QUOTE);
    isStmf = cTrue;
  when (f_startsWith(DOUBLE_QUOTE: include));
    stmf = f_rmvQuotes(include: DOUBLE_QUOTE);
    isStmf = cTrue;
  other;
    rc = stat(include: %addr(st_stat));
    if (rc = 0);
      stmf = include;
      isStmf = cTrue;
    endif;
  endsl;

  if (isStmf);
    performIncludeStmf(stmf);
  else;
    performIncludeMember(include);
  endif;

end-proc;

// =============================================================
//  Perform iclude for a given source stream file.
// =============================================================
dcl-proc performIncludeStmf;
  dcl-pi *n;
    i_include like(cmdLong_t) value;
  end-pi;

  dcl-s stmf like(path_t);

  stmf = f_rmvQuotes(i_include: SINGLE_QUOTE);

  IncludeStreamFile_open(stmf);

end-proc;

// =============================================================
//  Perform iclude for a given source member.
// =============================================================
dcl-proc performIncludeMember;
  dcl-pi *n;
    i_include like(cmdLong_t) value;
  end-pi;

  dcl-s s int(10);
  dcl-s e int(10);
  dcl-s library varchar(10);
  dcl-s file varchar(10);
  dcl-s member varchar(10);

  //  ... Ungültige INCLUDE Marke in Zeile &1 gefunden.
/copy QSTRPREPRC,PRZ0031

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
    if (e = 0);
      e = %scan(',': i_include: s);
    endif;
    if (e - s > 0);
      file = %subst(i_include: s: e - s);
      s = e + 1;
    endif;
  endif;

  if (file = '');
    clear PRZ0031;
    PRZ00311 = SourceFile_getLineNbr();
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
    PRZ00311 = SourceFile_getLineNbr();
    sendMsg(f_newMsg('PRZ0031': PRZ0031: cTYPE_DIAG));
    endAbnormal();
  endif;

  IncludeFile_open(library: file: member);

end-proc;

// =============================================================
//  Loads monitored message IDs from >>MONMSG<< section.
// =============================================================
dcl-proc loadMonitoredMessageIDs;
  dcl-pi *n likeds(monMsgIds_t);
  end-pi;

  dcl-ds monMsgIds likeds(monMsgIds_t);

  dcl-s isFirstLine ind inz(cTrue);
  dcl-s count int(10);
  dcl-s srcDta like(ds_srcFile_t.srcDta);
  dcl-s tag like(tag_t) inz;
  dcl-s mode like(mode_t) inz;
  dcl-s newMode like(mode_t) inz;
  dcl-ds lineData likeds(lineData_t) inz;

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

end-proc;

// =============================================================
//  Checks whether a given message ID is covered by a list
//  of monitored message IDs.
// =============================================================
dcl-proc isMonitoredMessageID;
  dcl-pi *n ind;
    i_errMsgId  like(msgId_t) value;
    i_monMsgIds likeds(monMsgIds_t) value;
  end-pi;

  dcl-s i int(10);
  dcl-s msgId like(msgId_t);
  dcl-s cmpLen int(10);

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

end-proc;

// =============================================================
//  Checks whether a given message ID is covered by a list
//  of monitored message IDs.
// =============================================================
dcl-proc isExecOpt;
  dcl-pi *n ind;
    i_execOpt like(execOpt_t.execOpt) value;
  end-pi;

  dcl-s i int(10);

  for i = 1 to g_execOpt.numElem;
    if (g_execOpt.execOpt(i) = EXEC_ALL or
      g_execOpt.execOpt(i) = i_execOpt);
      return cTrue;
    endif;
  endfor;

  return cFalse;

end-proc;

// =============================================================
//  Execute >>LIBL<< tag (set library list)
// =============================================================
dcl-proc performSetLibraryList;
  dcl-pi *n;
    i_cmd        like(cmdLong_t) value;
    io_variables likeds(variables_t);
  end-pi;

  dcl-ds liblList likeds(liblList_t) inz;

  //  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
/copy QSTRPREPRC,PRZ0026

  if (g_option.isEventf);
    monitor;
      prepareEventFile();
    on-error;
      clear PRZ0026;
      sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_DIAG));
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
    endAbnormal();
  endif;

end-proc;

// =============================================================
//  Execute >>CURLIB<< tag (set current library)
// =============================================================
dcl-proc performSetCurrentLibrary;
  dcl-pi *n;
    i_cmd        like(cmdLong_t) value;
    io_variables likeds(variables_t);
  end-pi;

  dcl-ds liblList likeds(liblList_t) inz;

  //  ... EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.
/copy QSTRPREPRC,PRZ0026

  if (g_option.isEventf);
    monitor;
      prepareEventFile();
    on-error;
      clear PRZ0026;
      sendMsg(f_newMsg('PRZ0026': PRZ0026: cTYPE_DIAG));
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
    endAbnormal();
  endif;

end-proc;

// =============================================================
//  Retrieves the current library list of the job.
// =============================================================
dcl-proc retrieveLibraryList;
  dcl-pi *n likeds(liblList_t);
  end-pi;

  //  Return value
  dcl-ds libl likeds(liblList_t) inz;

  dcl-ds rtvc0200 likeds(rtvc0200_t) based(pRtvc0200);
  dcl-s rcvVar char(4096) inz;
  dcl-ds errCode likeds(errCode_t) inz;
  dcl-s i int(10);
  dcl-s keysToRtn int(10) dim(2);
  dcl-s pOffs pointer inz;
  dcl-s curLib like(QWCRTVCA_libName_t) based(pCurLib);
  dcl-s usrLibl like(QWCRTVCA_libName_t) dim(DIM_LIBLIST) based(pUsrLibl);


  pRtvc0200 = %addr(rcvVar);

  keysToRtn(1) = KEY_CURRENT_LIBRARY;
  keysToRtn(2) = KEY_USER_LIBRARIES;
  errCode = f_newApiErrCode(cFalse); // send *ESCAPE message on error
  QWCRTVCA(rcvVar: %size(rcvVar): 'RTVC0200'
  : %elem(keysToRtn): keysToRtn: errCode);

  pOffs = %addr(rtvc0200) + %size(rtvc0200);

  if (rtvc0200.numSysLiblE >= 1);
    pOffs = pOffs + (rtvc0200.numSysLiblE * %size(QWCRTVCA_libName_t));
  endif;

  if (rtvc0200.numPrdLiblE >= 1);
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

end-proc;

// =============================================================
//  Retrieve the name of the event file (library & member)
//  from the object creation command.
// =============================================================
dcl-proc retrieveEventFile;
  dcl-pi *n likeds(qObj_t);
    i_cmd like(cmdLong_t) value;
  end-pi;

  //  Return value
  dcl-ds qObj likeds(qObj_t) inz;

  dcl-s cmd like(i_cmd);
  dcl-s clCmd varchar(10);
  dcl-s clKwd varchar(10);
  dcl-s i int(10);
  dcl-s s int(10);
  dcl-s e int(10);
  dcl-s parmValue varchar(30);

  dcl-c SPACE ' ';

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

end-proc;

// =============================================================
//  Zusammenbauen Schlüsselwortdaten
// =============================================================
dcl-proc addData;
  dcl-pi *n like(keyData_t);
    i_tag       like(tag_t) value;
    i_keyData   like(keyData_t) value;
    i_srcDta    like(srcDta_t) value;
    io_continue like(continue_t);
  end-pi;

  //  Funktionswert
  dcl-s keyData like(keyData_t) inz;

  //  Nachrichten
  //  ... Ungültiges Fortsetzungszeichen &1 in Zeile &2 gefunden.
/copy QSTRPREPRC,PRZ0005
  //  ... Das Zeilenendekennzeichen konnte nicht gefunden werden.
/copy QSTRPREPRC,PRZ0008
  //  ... Unbekannter Wert "&1" für Fortsetzungszeichen gefunden.
/copy QSTRPREPRC,PRZ0009

  //  Arbeitsfelder
  dcl-s start like(int4_t) inz static;
  dcl-s dataLen like(int4_t) inz;
  dcl-s x like(int4_t) inz;

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

    if (SourceStreamFile_isOpen());
      PRZ00081 = SourceStreamFile_getLineNbr();
    else;
      PRZ00081 = SourceFile_getLineNbr();
    endif;

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

    if (SourceStreamFile_isOpen());
      PRZ00052 = SourceStreamFile_getLineNbr();
    else;
      PRZ00052 = SourceFile_getLineNbr();
    endif;

    sendMsg(f_newMsg('PRZ0005': PRZ0005: cTYPE_DIAG));
    endAbnormal();
  endif;

  return keyData;

end-proc;

// =============================================================
//  Ermitteln der Breite der Quellenangaben am >>WIDTH<< Tag
// =============================================================
dcl-proc getWidthValue;
  dcl-pi *n int(10);
    i_srcDta like(srcDta_t) value;
    i_length int(10) value;
  end-pi;

  //  Funktionswert
  dcl-s width int(10) inz(80);

  dcl-c cWIDTH_LEN %len(width);
  dcl-c cWIDTH_DECPOS %decpos(width);

  //  Arbeitsfelder
  dcl-s x like(int4_t) inz;
  dcl-s tmpWidth varchar(16) inz;

  //  Konstanten
  dcl-c cNUMBERS '0123456789';

  // ermitteln der getStartPosition
  x = %scan(cTAG_WIDTH: %subst(i_srcDta: 1: i_length));
  if (x = 0);
    return width;
  endif;

  // überspringen von Leerzeichen zwischen >>WIDTH<< und der angegebenen Breite
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

end-proc;

// =============================================================
//  Ersetzen/Hinzufügen Schlüsselwort
// =============================================================
dcl-proc replaceCmdKeyWord;
  dcl-pi *n like(cmdLong_t);
    i_cmd     like(cmdLong_t) value;
    i_keyData like(keyData_t) value;
  end-pi;

  //  Funktionswert
  dcl-s cmd like(cmdLong_t) inz;

  //  Nachrichten
  //  ... Das Ende des Schlüsselwortes &1 konnte nicht gefunden werden.
/copy QSTRPREPRC,PRZ0006

  //  Arbeitsfelder
  dcl-s startPos like(int4_t) inz;
  dcl-s dataLen like(int4_t) inz;
  dcl-s x like(int4_t) inz;
  dcl-s y like(int4_t) inz;
  dcl-s token varchar(11) inz;
  dcl-s cmdDtaLen like(int4_t) inz;
  dcl-s numBracket like(int4_t) inz;

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

end-proc;

// =============================================================
//  Ermitteln Länge von srcDta
// =============================================================
dcl-proc getSrcDataLength;
  dcl-pi *n like(int4_t);
  end-pi;

  //  Funktionswert
  dcl-s srcDtaLen like(int4_t) inz;

  // if (%open(INCLUDE));
  if (IncludeFile_isOpen());
    if (IncludeStreamFile_isOpen());
      srcDtaLen = IncludeStreamFile_getDtaLength();
    else;
      srcDtaLen = IncludeFile_getDtaLength();
    endif;
  else;
    if (SourceStreamFile_isOpen());
      srcDtaLen = SourceStreamFile_getDtaLength();
    else;
      srcDtaLen = SourceFile_getDtaLength();
    endif;
  endif;

  if (g_width <> -1 and g_width < srcDtaLen);
    srcDtaLen = g_width;
  endif;

  return srcDtaLen;

end-proc;

// =============================================================
//  Ermitteln der getStartPosition
// =============================================================
dcl-proc getStartPos;
  dcl-pi *n like(int4_t);
    i_tag    like(tag_t) value;
    i_srcDta like(srcDta_t);
  end-pi;

  //  Funktionswert
  dcl-s pos like(int4_t) inz;

  //  Arbeitsfelder

  pos = %scan(%trim(i_tag): i_srcDta: 1);
  if (pos > 0);
    pos = pos + %len(%trim(i_tag));
    pos = %check(' ': i_srcDta: pos);
  endif;

  return pos;

end-proc;

// =============================================================
//  Prüfen auf gültiges Tag
// =============================================================
dcl-proc isTag;
  dcl-pi *n like(bool_t);
    i_srcDta like(srcDta_t) value;
    o_tag    like(tag_t);
  end-pi;

  //  Funktionswert
  dcl-s isTag like(bool_t) inz(cFalse);

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

end-proc;

// =============================================================
//  Ermitteln Tag aus Quellendaten
// =============================================================
dcl-proc retrieveTag;
  dcl-pi *n like(bool_t);
    i_tagToTest like(tag_t) value;
    i_srcDta    like(srcDta_t) value;
    o_tag       like(tag_t);
  end-pi;

  //  Funktionswert
  dcl-s isTag like(bool_t) inz(cFalse);

  //  Arbeitsfelder
  dcl-s startPos like(int4_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  startPos = %scan(%trim(i_tagToTest): i_srcDta);
  if (startPos > 0);
    o_tag = i_tagToTest;
    isTag = cTrue;
  else;
    o_tag = '';
    isTag = cFalse;
  endif;

  return isTag;

end-proc;

// =============================================================
//  Umsetzen Tag in Betriebsmodus
// =============================================================
dcl-proc tagToMode;
  dcl-pi *n like(mode_t);
    i_tag like(tag_t) value;
  end-pi;

  //  Funktionswert
  dcl-s mode like(mode_t) inz;

  //  Nachrichten
  //  ... Das Ende des Schlüsselwortes &1 konnte nicht gefunden werden.
/copy QSTRPREPRC,PRZ0010

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

end-proc;

// =============================================================
//  Ändern Betriebsmodus
// =============================================================
dcl-proc checkMode;
  dcl-pi *n ind;
    i_mode    like(mode_t) value;
    i_newMode like(mode_t) value;
  end-pi;

  //  Access key of file STRPRE1 (Pre-compiler modes)
  dcl-ds P1Key2 qualified;
    MODE    like(P1MODE);
    NEWMODE like(P1NEWMODE);
  end-ds;

  //  Nachrichten
  //  ... Falsche Reihenfolge im Betriebsmodus.
/copy QSTRPREPRC,PRZ0001
  //  ... Verschachtelte INCLUDE Marke in Zeile &4 der Datei &2/&1, Teildatei &3 gefunden.
/copy QSTRPREPRC,PRZ0032

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

  // if (i_newMode = cMODE_INCLUDE and %open(INCLUDE));
  if (i_newMode = cMODE_INCLUDE and IncludeFile_isOpen());
    clear PRZ0032;
    PRZ00321 = IncludeFile_getFile();
    PRZ00322 = IncludeFile_getLibrary();
    PRZ00323 = IncludeFile_getMember();
    PRZ00324 = IncludeFile_getLineNbr();
    sendMsg(f_newMsg('PRZ0032': PRZ0032: cTYPE_DIAG));
    return cFalse;
  endif;

  return cTrue;

end-proc;

// =============================================================
//  Senden Escape Nachricht
// =============================================================
dcl-proc sendMsg export;
  dcl-pi *n;
    i_msg likeds(msg_t) value;
  end-pi;

  f_sndPgmMsg(i_msg: cMsg_Prv: cMsg_ToCtlBdy);

end-proc;

// =============================================================
//  Mode auf Stack
// =============================================================
dcl-proc pushMode;
  dcl-pi *n;
    i_mode like(mode_t) value;
  end-pi;

  g_modeCnt = g_modeCnt + 1;
  g_mode(g_modeCnt) = i_mode;

end-proc;

// =============================================================
//  Mode vom Stack
// =============================================================
dcl-proc popMode;
  dcl-pi *n like(mode_t);
  end-pi;

  g_mode(g_modeCnt) = '';
  g_modeCnt = g_modeCnt - 1;

  return g_mode(g_modeCnt);

end-proc;

// =============================================================
//  Prüfen CL Befehl
// =============================================================
dcl-proc validateCmd;
  dcl-pi *n like(bool_t);
    i_cmd like(cmdLong_t) value;
  end-pi;

  //  Definitionen für QCAPCMD
  dcl-ds optCtrl likeds(cpop0100_t) inz;
  dcl-s retCmd like(cmdLongFixLen_t) inz;
  dcl-s retCmdLenAvl int(10) inz(%len(retCmd));
  dcl-s retCmdLenRtn int(10) inz;
  dcl-ds errCode likeds(errCode_t) inz;

  //  ... Fehler im Erstellungsbefehl gefunden.
/copy QSTRPREPRC,PRZ0015
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

end-proc;

// =============================================================
//  Execute a CL command.
// =============================================================
dcl-proc executeCmd;
  dcl-pi *n like(bool_t);
    i_monErr   like(bool_t) value;
    i_cmd      like(cmdLong_t) value;
    o_errMsgId like(msgId_t) options(*nopass);
  end-pi;

  dcl-c p_errMsgId 3;

  //  Fields for getMsgInf()
  dcl-s msgID like(msgID_t) inz;
  dcl-s msgDta like(msg_t.data) inz;
  dcl-s msgFile like(msg_t.file) inz;
  dcl-s msgLib like(msg_t.lib) inz;

  // Definitionen für Ausgangsprogramm
  dcl-s cmdLongFixLength like(cmdLongFixLen_t);
  dcl-s cmdLongLength packed(15: 5);
  dcl-s exitPgmName varchar(21);

  dcl-pr exitPgm extpgm(exitPgmName);
    cmd    like(cmdLongFixLen_t) options(*varsize);
    length packed(15: 5) options(*nopass: *omit);
  end-pr;

  //  Definitionen für QCAPCMD
  dcl-ds optCtrl likeds(cpop0100_t) inz;
  dcl-s retCmd like(cmdLongFixLen_t) inz;
  dcl-s retCmdLenAvl int(10) inz(%len(retCmd));
  dcl-s retCmdLenRtn int(10) inz;
  dcl-ds errCode likeds(errCode_t) inz;

  //  ... Fehler im Erstellungsbefehl gefunden.
/copy QSTRPREPRC,PRZ0015
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

end-proc;

//===============================================================*
//  Appends a message to the job log.
//===============================================================*
dcl-proc appendToJobLog;
  dcl-pi *n;
    i_message like(cmdLong_t) value;
  end-pi;

  dcl-s startPos uns(10) inz(1);
  dcl-s prefix char(11) inz;
  dcl-s line char(60) inz;

  //  Nachrichten
  //  ... &1.
/copy QSTRPREPRC,PRZ0029

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

end-proc;

// =============================================================
//  Ermitteln Nachrichteninformationen
// =============================================================
dcl-proc getMsgInf;
  dcl-pi *n;
    i_pgm     like(pgm_t) value;
    i_module  like(module_t) value;
    i_proc    like(proc_t) value;
    i_msgId   like(msgID_t) value;
    o_msgID   like(msgID_t);
    o_msgDta  like(msg_t.data);
    o_msgFile like(msg_t.file);
    o_msgLib  like(msg_t.lib);
  end-pi;

  dcl-ds RCVM0200 likeds(rcvm0200_t);

  dcl-s lenMsgInf int(10) inz(%size(RCVM0200));
  dcl-s stackEntry char(64) inz;
  dcl-s stackCounter int(10) inz(0);
  dcl-s msgType char(10) inz;
  dcl-s msgKey char(4) inz;
  dcl-s wait int(10) inz(0);
  dcl-s msgAction char(10) inz('*SAME');
  dcl-s lenStackEntry int(10) inz(%size(stackEntry));
  dcl-ds stackQual;
    stackQualMod char(10) inz('*NONE');
    stackQualPgm char(10) inz('*NONE');
  end-ds;

  dcl-ds errCode likeds(errCode_t) inz;

  dcl-s firstMsg like(RCVM0200) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

end-proc;

// =============================================================
//  Formatieren CL Befehl
// =============================================================
dcl-proc formatCmd;
  dcl-pi *n like(cmdLong_t);
    i_cmd like(cmdLong_t) value;
  end-pi;

  //  Nachrichten
  //  ... Befehlszeichenfolge ist zu lang.
/copy QSTRPREPRC,PRZ0007
  //  ... Fehler im Erstellungsbefehl gefunden.
/copy QSTRPREPRC,PRZ0015

  //  Definitionen für QCAPCMD
  dcl-s cmd like(i_cmd);
  dcl-ds optCtrl likeds(cpop0100_t) inz;
  dcl-s retCmd like(cmdLongFixLen_t) inz;
  dcl-s retCmdLenAvl int(10) inz(%len(retCmd));
  dcl-s retCmdLenRtn int(10) inz;
  dcl-ds errCode likeds(errCode_t) inz;

  dcl-ds msg likeds(msg_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

end-proc;

// =============================================================
//  Beenden Programm abnormal
// =============================================================
dcl-proc endAbnormal export;
  dcl-pi *n;
    i_qEventf likeds(qObj_t) options(*nopass) const;
  end-pi;

  dcl-c p_qEventf 1;

  dcl-ds qEventf likeds(i_qEventf);
  dcl-s lineNumber int(10);

  //  Nachrichten
  //  ... Verarbeitung in Zeile &1 abgebrochen.
/copy QSTRPREPRC,PRZ0002

  if (%parms() >= p_qEventf and %addr(i_qEventf) <> *null);
    qEventf = i_qEventf;
  else;
    clear qEventf;
  endif;

  if (g_option.isEventf);
    writeJobLogToEventf(qEventf: cTrue);
  endif;

  if (SourceStreamFile_isOpen());
    lineNumber = SourceStreamFile_getLineNbr();
    SourceStreamFile_close();
  else;
    lineNumber = SourceFile_getLineNbr();
    SourceFile_close();
  endif;

  if (%open(STRPRE1));
    close STRPRE1;
  endif;

  IncludeFile_close();

  clear PRZ0002;
  // PRZ00021 = f1_line_number;
  PRZ00021 = lineNumber;
  sendMsg(f_newMsg('PRZ0002': PRZ0002: cTYPE_ESCAPE));

end-proc;

// =============================================================
//  Beenden Programm normal
// =============================================================
dcl-proc endOK;
  dcl-pi *n;
    i_qEventf likeds(qObj_t) options(*nopass) const;
  end-pi;

  dcl-c p_qEventf 1;

  dcl-ds qEventf likeds(i_qEventf);

  //  Nachrichten
  //  ... EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konnte nht geöffnet
/copy QSTRPREPRC,PRZ0025

  if (%parms() >= p_qEventf and %addr(i_qEventf) <> *null);
    qEventf = i_qEventf;
  else;
    clear qEventf;
  endif;

  if (g_option.isEventf);
    writeJobLogToEventf(qEventf: cFalse);
  endif;

end-proc;

// =============================================================
//  Write job log entries to the event file.
//
//  i_qEventf - Event file created by the object creation
//              command. If the object name was overridden by
//              a STRPREPRC >>PARM<< tag, the events ctreated by
//              the object creation command must be copied to
//              the event file created by STRPREPRC.
// =============================================================
dcl-proc writeJobLogToEventf;
  dcl-pi *n;
    i_qEventf  likeds(qObj_t) const;
    i_isAbnEnd ind const;
  end-pi;

  dcl-s isEmpty ind;
  dcl-s doAppend ind;
  dcl-s doAppendJobLog ind;
  //  ... EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konnte nicht geöffnet
/copy QSTRPREPRC,PRZ0025

  monitor;

    if (i_qEventf.name <> '' and i_qEventf.lib <> '');
      if (i_qEventf.name <> g_eventf.mbr or
      i_qEventf.lib <> g_eventf.lib);
        if (not isEmptyEventFile(i_qEventf.lib: i_qEventf.name));
          copyEventFile(i_qEventf.lib: i_qEventf.name
          : g_eventf.lib: g_eventf.mbr);
        endif;
      endif;
    endif;

    isEmpty = isEmptyEventFile(g_eventf.lib: g_eventf.mbr);

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
      g_eventf.isOpen = openEventFile(
        g_eventf.mbr: g_eventf.lib: doAppend);
      if (g_eventf.isOpen);
        if (SourceStreamFile_isOpen());
          writeEventFile(
            SourceStreamFile_getPath()
          : '': ''
            : SourceStreamFile_getLineNbr(): i_isAbnEnd);
        else;
          writeEventFile(
            g_srcFile.name: g_srcFile.lib: g_srcFile.mbr
          : SourceFile_getLineNbr(): i_isAbnEnd);
        endif;
      endif;
    endif;

    // Update *LDA with event file name.
    updateLDA(g_eventf.lib: g_eventf.mbr);

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

end-proc;

//===============================================================*
//  Replace variables
//===============================================================*
dcl-proc replaceVar;
  dcl-pi *n;
    i_var     char(10) value;
    i_value   like(cmdLong_t) value;
    io_string like(cmdLong_t);
  end-pi;

  dcl-s x like(int4_t);

  dou (x = 0);
    if (x > 0);
      io_string = %replace(%trim(i_value)
      : io_string
      : x
      : %len(%trim(i_var)));
    endif;
    x = %scan(%trim(i_var): io_string);
  enddo;

end-proc;

//===============================================================*
//  Set whether to return RNF7031 messages
//===============================================================*
dcl-proc setReturnRNF7031Messages;
  dcl-pi *n like(rnf7031_t);
    i_rnf7031 varchar(10) const;
  end-pi;

  dcl-c QIBM_RPG_RNF7031_EVENTS 'QIBM_RPG_RNF7031_EVENTS';

  dcl-s currentValue like(rnf7031_t);

  if (i_rnf7031 = '*SYSTEM');
    return i_rnf7031;
  endif;

  currentValue = f_getEnvVar(QIBM_RPG_RNF7031_EVENTS);
  select;
  when (currentValue = 'N');
    currentValue = '*NO';
  when (currentValue = 'Y');
    currentValue = '*YES';
  other;
    currentValue = '';
  endsl;

  select;
  when (i_rnf7031 = '*YES');
    f_setEnvVar(QIBM_RPG_RNF7031_EVENTS: 'Y');
  when (i_rnf7031 = '*NO');
    f_setEnvVar(QIBM_RPG_RNF7031_EVENTS: 'N');
  when (i_rnf7031 = '');
    f_delEnvVar(QIBM_RPG_RNF7031_EVENTS);
  endsl;

  return currentValue;

end-proc;

** ctdata g_crtCmdsDta
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
