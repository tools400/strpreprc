**FREE
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : STRPREPRC                                          *
//  Objekt  . . . : STRPREPRC4                                         *
//  Beschreibung  : Start Pre-Processor - Event File                   *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 15.05.2015                                         *
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
//  03.02.2017  Th.Raddatz    Changed, to append the version           *
//                            information to the job log.              *
//                                                                     *
//  09.03.2019  Th.Raddatz    Changed, to open the event file for      *
//                            modus 'new', when the event file is      *
//                            empty.                                   *
//                                                                     *
//  22.12.2020  Th.Raddatz    Changed writing job log entries as ERROR *
//                            entries, in case of compilation errors.  *
//                                                                     *
//  19.11.2021  Th.Raddatz    Moved prototype of updateLDA() to member *
//                            PROTO_H.                                 *
//                                                                     *
//  16.03.2022  Th.Raddatz    Renamed PROTO_H to TYPES_H.              *
//                                                                     *
//  23.03.2022  Th.Raddatz    Changed writeEventFile() to accept an    *
//                            IFS stream file at parameter i_srcFile.  *
//                                                                     *
//  26.03.2022  Th.Raddatz    Added stream file support.               *
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
/COPY QSTRPREPRC,H_SPEC
ctl-opt NOMAIN BNDDIR('QC2LE');
//
dcl-f STRPRE2 keyed usropn extfile(g_strpre2.name)
      extmbr(g_strpre2.member) prefix(P2);
//
dcl-ds g_strpre2 qualified inz;
  name            varchar(21);
  member          varchar(10);
end-ds;
//
// -------------------------------------------------------------
//  Exportierte Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,PSTRPREPR4
//
/copy QSTRPREPRC,SDS
//
//  Returns cTrue for an ignored message ID, else cFalse.
dcl-pr isIgnoredMsgID
       ind
       extproc('isIgnoredMsgID');
  i_jobLogEntry   const likeds(JobLog_jobLogEntry_t);
end-pr;
//
//  Returns the statement number of the line that has the error.
dcl-pr getLineNumber
       int(20)
       extproc('getLineNumber');
  i_jobLogEntry   const likeds(JobLog_jobLogEntry_t);
end-pr;
//
//  Macro to prepare the _NUM_Descr_T, used in the cpynv and edit functions.
dcl-pr NUM_Descr_T
       int(10);
  i_type          int(3) const;
  i_length        int(3) const;
  i_fractional    int(3) const;
end-pr;
//
//  Copy Numeric Value (CPYNV)
dcl-pr cpynv
       pointer extproc('cpynv');
  i_rcvDesc       value  like(NUM_Descr_T );
  i_pRcvVar       pointer value;
  i_srcDesc       value  like(NUM_Descr_T );
  i_pSrcVar       pointer value;
end-pr;
//
//  These values must be specified on the Scalar Type for CPYNV,
//  CVTEFN, and EDIT instructions.                              QSYSINC/MIH.MICPTCOM
dcl-c T_SIGNED x'00';
dcl-c T_FLOAT x'01';
dcl-c T_ZONED x'02';
dcl-c T_PACKED x'03';
dcl-c T_CHAR x'04';
dcl-c T_ONLYNS x'06';
dcl-c T_ONLYN x'07';
dcl-c T_EITHER x'08';
dcl-c T_OPEN x'09';
dcl-c T_UNSIGNED x'0A';
//
// -------------------------------------------------------------
//  External prototypes
// -------------------------------------------------------------
/COPY QSTRPREPRC,QUSRMBRD                   Retrieve Member Description (QUSRMBRD) API
//
// -------------------------------------------------------------
//  Globale Referenzfelder
// -------------------------------------------------------------
//
// -------------------------------------------------------------
//  Globale Konstanten
// -------------------------------------------------------------
/DEFINE COPYRIGHT_DSPEC
/COPY QSTRPREPRC,COPYRIGHT
//
dcl-c SOURCE_ID 1;
dcl-c JOBLOG_ID 999;
//
// -------------------------------------------------------------
//  Globale Variablen
// -------------------------------------------------------------
dcl-ds g_status qualified;
  isEnabled       ind inz(cFalse);
  haveEventFile   ind inz(cFalse);
  haveJobLog      ind inz(cFalse);
  openForAppend   ind inz(cFalse);
  copyEvents      ind inz(cFalse);
  msgKey          char(4) inz(*ALLx'FF');
end-ds;
//
dcl-ds g_LDA dtaara(*USRCTL:*LDA) qualified;
  library         char(10);
  object          char(10);
end-ds;
//
// -------------------------------------------------------------
//  Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,TYPES_H                     Tool: STRPREPRC - Global Types and Constants
/copy QSTRPREPRC,QMHRTVM                     Retrieve Message (QMHRTVM) API
/copy QEVENTF,PEVENTF                        EVFEVENT API - Public Interface
/copy QJOBLOG,PJOBLOG                        EVFEVENT API - Job Log
//
// =============================================================
//  Enables this module.
// =============================================================
dcl-proc enableEventFile export;
  dcl-pi *N;
  end-pi;

  g_status.isEnabled = cTrue;

end-proc;
//
// =============================================================
//  Checks whether the event file is empty.
// =============================================================
dcl-proc isEmptyEventFile export;
  dcl-pi *N              ind;
    i_lib           char(10) const;
    i_obj           char(10) const;
  end-pi;
  //
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds mbrd0200 likeds(mbrd0200_t) inz;
  dcl-ds msg likeds(msg_t) inz;

  monitor;

    if (not f_exist('EVFEVENT': i_lib: '*FILE': i_obj));
      return cTrue;
    endif;

    qFile.name = 'EVFEVENT';
    qFile.lib = i_lib;
    QUSRMBRD(mbrd0200: %size(mbrd0200): 'MBRD0200': qFile: i_obj: '0');

    return mbrd0200.numTotRcds = 0;

  on-error;
    msg = f_rcvPgmMsgObj(cMsg_Escape);
    f_sndPgmMsg(msg: cMsg_Prv);
  endmon;

end-proc;
//
// =============================================================
//  Clears an event file.
// =============================================================
dcl-proc clearEventFile export;
  dcl-pi *N;
    i_obj           char(10) const;
    i_lib           char(10) const;
  end-pi;

  if (not g_status.isEnabled);
    return;
  endif;

  Eventf_clear(i_lib: i_obj);

end-proc;
//
// =============================================================
//  Prepares for writing the event file.
// =============================================================
dcl-proc prepareEventFile export;
  dcl-pi *N;
  end-pi;

  dcl-ds jobLogEntry likeds(JobLog_jobLogEntry_t) inz;

  if (not g_status.isEnabled);
    return;
  endif;

  if (JobLog_getNewest('*': jobLogEntry));
    g_status.haveJobLog = cTrue;
    g_status.msgKey = jobLogEntry.msgKey;
  else;
    g_status.haveJobLog = cFalse;
    g_status.msgKey = *ALLx'FF';
  endif;

end-proc;
//
// =============================================================
//  Opens the event file.
// =============================================================
dcl-proc openEventFile export;
  dcl-pi *N              ind;
    i_obj           char(10) const;
    i_lib           char(10) const;
    i_append        ind const;
  end-pi;

  dcl-s rtnLib          like(i_lib);

  if (not g_status.isEnabled);
    return cFalse;
  endif;

  g_status.openForAppend = i_append;

  if (g_status.openForAppend);
    Eventf_openAppend(i_lib: i_obj: rtnLib);
    if (rtnLib = '');
      return cFalse;
    endif;
  else;
    Eventf_open(i_lib: i_obj: rtnLib);
    if (rtnLib = '');
      return cFalse;
    endif;
    Eventf_writeProcessor();
  endif;

  g_status.haveEventFile = cTrue;

  return cTrue;

end-proc;
//
// =============================================================
//  Update the *LDA with the name of the event file.
// =============================================================
dcl-proc updateLDA export;
  dcl-pi *N;
    i_lib           char(10) const;
    i_obj           char(10) const;
  end-pi;

  monitor;
    in g_LDA;
    if (i_lib <> '' and i_obj <> '');
      g_LDA.library = i_lib;
      g_LDA.object = i_obj;
    else;
      g_LDA.library = '';
      g_LDA.object = '';
    endif;
    out g_LDA;
  on-error;
  endmon;

end-proc;
//
// =============================================================
//  Copies the job log messages to the event file.
// =============================================================
dcl-proc writeEventFile export;
  dcl-pi *N;
    i_srcFile       const  like(path_t);
    i_srcLib        char(10) const;
    i_srcMbr        char(10) const;
    i_lineNumber    int(10) const;
    i_isAbnEnd      ind const;
  end-pi;

  dcl-s path            like(evf_path_t);

  dcl-s hJobLog         like(JobLog_handle_t) inz;
  dcl-ds jobLogEntry likeds(JobLog_jobLogEntry_t) inz;
  dcl-s isFirstMsg      ind inz(cTrue);
  dcl-s lineNumber      like(i_lineNumber);
  dcl-s sourceId        like(evf_source_id_t);
  //
  //  Nachrichten
  //  ... &1.
  /copy QSTRPREPRC,PRZ0029

  if (not g_status.isEnabled);
    return;
  endif;

  if (not g_status.haveEventFile);
    return;
  endif;

  if (not g_status.haveJobLog);
    return;
  endif;

  if (not g_status.openForAppend);
    if (i_srcLib <> '' and i_srcMbr <> '');
      path = f_cvtQSYSObjNameToPath(
                i_srcFile: i_srcLib: i_srcMbr:'*FILE');
    else;
      path = i_srcFile; // i_srcFile is an IFS stream file
    endif;
    sourceId = SOURCE_ID;
    Eventf_writeFileID(
       sourceId: path: EVF_NAME_TYPE_PATH);
  else;
    sourceId = JOBLOG_ID;
    Eventf_writeFileID(
       sourceId: '*JOBLOG': EVF_NAME_TYPE_PATH: EVF_TEMPORARY_SOURCE);
  endif;

  // Append version information to job log
  clear PRZ0029;
  PRZ00291 = 'STRPREPRC v' + STRPREPRC_VERSION + ' - ' + STRPREPRC_DATE;
  f_sndPgmMsg(f_newMsg('PRZ0029': PRZ0029: cMsg_Diag));

  hJobLog = JobLog_open(*omit: JOBLOG_OPTION_MSG +
                               JOBLOG_OPTION_REPLACE_VARS +
                               JOBLOG_OPTION_SENDER
                             : JOBLOG_NEXT
                             : g_status.msgKey);

  dow (JobLog_getEntry(hJobLog: jobLogEntry));

    if (isFirstMsg);
      isFirstMsg = cFalse;
      iter;
    endif;

    if (isIgnoredMsgID(jobLogEntry));
      iter;
    endif;

    if (sourceId = SOURCE_ID);
      lineNumber = getLineNumber(jobLogEntry);
      if (lineNumber = -1);
        lineNumber = i_lineNumber;
      endif;
    else;
      lineNumber = 0;
    endif;

    if (not i_isAbnEnd);
      if (jobLogEntry.msgSeverity >= EVF_MSG_SEVERITY_ERROR);
        jobLogEntry.msgSeverity = EVF_MSG_SEVERITY_WARNING;
      endif;
    endif;

    if (sourceId = SOURCE_ID);
      Eventf_writeError(sourceId
                        : lineNumber
                        : jobLogEntry.msgID
                        : jobLogEntry.msgSeverity
                        : jobLogEntry.msgText);
    else;
      if (i_isAbnEnd);
        Eventf_writeError(sourceId
                          : lineNumber
                          : jobLogEntry.msgID
                          : jobLogEntry.msgSeverity
                          : jobLogEntry.msgText);
      else;
        Eventf_writeError(sourceId
                          : lineNumber
                          : jobLogEntry.msgID
                          : jobLogEntry.msgSeverity
                          : jobLogEntry.msgText
                          : EVF_SEVERITY_WARNING
                          : EVF_ANNOTATION_BOTTOM);
      endif;
    endif;
  enddo;

  JobLog_close(hJobLog);

  Eventf_writeFileEnd(sourceId: 0);

end-proc;
//
// =============================================================
//  Closes the event file.
// =============================================================
dcl-proc closeEventFile export;
  dcl-pi *N;
  end-pi;

  if (not g_status.isEnabled);
    return;
  endif;

  if (%open(STRPRE2));
    close STRPRE2;
  endif;

  if (g_status.haveEventFile);
    Eventf_close();
    g_status.haveEventFile = cFalse;
  endif;

end-proc;
//
//===============================================================*
//  Copy event file.
//===============================================================*
dcl-proc copyEventFile export;
  dcl-pi *N;
    i_fromLib       char(10) const;
    i_fromMbr       char(10) const;
    i_toLib         char(10) const;
    i_toMbr         char(10) const;
  end-pi;

  Eventf_open(i_toLib: i_toMbr);
  Eventf_copyFrom(i_fromLib: i_fromMbr);
  Eventf_close();

end-proc;
//
// =============================================================
//  Returns cTrue for an ignored message ID, else cFalse.
// =============================================================
dcl-proc isIgnoredMsgID;
  dcl-pi *N              ind;
    i_jobLogEntry   const likeds(JobLog_jobLogEntry_t);
  end-pi;
  //
  dcl-ds key likerec(FSTRPRE2: *KEY);

  if (not %open(STRPRE2));
    g_strpre2.name = %trim(sds.pgmLib) + '/' + 'STRPRE2';
    g_strpre2.member = '*FIRST';
    open STRPRE2;
  endif;

  key.P2MSGFILE = i_jobLogEntry.msgFile;
  key.P2MSGLIB = i_jobLogEntry.msgFLibUsed;
  key.P2MSGID = i_jobLogEntry.msgID;
  chain %kds(key) FSTRPRE2;

  if (not %found());
    key.P2MSGLIB = i_jobLogEntry.msgFLibSpcfd;
    chain %kds(key) FSTRPRE2;
  endif;

  if (%found() and P2FMT = -1);
    return cTrue;
  endif;

  return cFalse;

end-proc;
//
// =============================================================
//  Returns the statement number of the line that has the error.
// =============================================================
dcl-proc getLineNumber;
  dcl-pi *N              int(20);
    i_jobLogEntry   const likeds(JobLog_jobLogEntry_t);
  end-pi;
  //
  dcl-ds key likerec(FSTRPRE2: *KEY);
  //
  dcl-ds qMsgF likeds(qObj_t) inz;
  dcl-ds errCode likeds(errCode_t) inz;
  dcl-s rtvm0300_buffer
        char(8192);
  dcl-ds rtvm0300 likeds(rtvm0300_t)
  based(pRtvm0300);
  dcl-ds varFmt likeds(qmhrtvm_substVarFmt_t)
  based(pVarFmt);
  dcl-s x               int(10);
  dcl-s offset          int(10);
  dcl-s length          int(10);
  //
  dcl-s tmpVal          char(128);
  dcl-s rtnVal          int(20);

  if (not %open(STRPRE2));
    open STRPRE2;
  endif;

  key.P2MSGFILE = i_jobLogEntry.msgFile;
  key.P2MSGLIB = i_jobLogEntry.msgFLibUsed;
  key.P2MSGID = i_jobLogEntry.msgID;
  chain %kds(key) FSTRPRE2;

  if (not %found());
    key.P2MSGLIB = i_jobLogEntry.msgFLibSpcfd;
    chain %kds(key) FSTRPRE2;
  endif;

  if (not %found() or P2FMT <= 0);
    return -1;
  endif;

  pRtvm0300 = %addr(rtvm0300_buffer);
  qMsgF.name = i_jobLogEntry.msgFile;
  qMsgF.lib = i_jobLogEntry.msgFLibUsed;
  errCode = f_newApiErrCode(cTrue);
  QMHRTVM(rtvm0300: %size(rtvm0300): 'RTVM0300'
          : i_jobLogEntry.msgID: qMsgF: '': 0: '*NO': '*NO': errCode);

  if (f_isApiError(errCode));
    return -1;
  endif;

  if (rtvm0300.bytRet <= 0);
    return -1;
  endif;

  if (rtvm0300.lenVarFmtR <= 0);
    return -1;
  endif;

  if (rtvm0300.numVarFmt < P2FMT);
    return -1;
  endif;

  for x = 1 to P2FMT;
    if (x = 1);
      pVarFmt = %addr(rtvm0300) + rtvm0300.ofsVarFmt;
    else;
      offset += varFmt.length;
      pVarFmt += rtvm0300.lenVarFmtE;
      length = varFmt.length;
    endif;
  endfor;

  rtnVal = -1;
  tmpVal = %subst(i_jobLogEntry.rplcData: offset + 1: length);

  select;
  when (varFmt.type = '*BIN');
    cpynv(NUM_Descr_T(T_UNSIGNED: 8: 0)
          : %addr(rtnVal)
          : NUM_Descr_T(T_SIGNED: varFmt.length: varFmt.decPos)
          : %addr(tmpVal));

  when (varFmt.type = '*UBIN');
    cpynv(NUM_Descr_T(T_UNSIGNED: 8: 0)
          : %addr(rtnVal)
          : NUM_Descr_T(T_UNSIGNED: varFmt.length: varFmt.decPos)
          : %addr(tmpVal));

  when (varFmt.type = '*DEC');
    cpynv(NUM_Descr_T(T_UNSIGNED: 8: 0)
          : %addr(rtnVal)
          : NUM_Descr_T(T_PACKED: varFmt.length: varFmt.decPos)
          : %addr(tmpVal));

  endsl;

  return rtnVal;

end-proc;
//
// =============================================================
//  NUM_Descr_T
//
//  The following macro is used to prepare the numeric descriptor
//  (_NUM_Descr_T), used in the cpynv and edit functions. Can also
//  be used to set the type and length fields of _DPA_Template_T.
//  The valid values for the parameters are:
//     type         length             fractional
//     -----------  -----------------  -------------------------
//     _T_Signed    2 or 4             0
//     _T_Float     4 or 8             0
//     _T_Zoned     1 <= length <= 31  0 <= fractional <= length
//     _T_Packed    1 <= length <= 31  0 <= fractional <= length
//     _T_Unsigned  2 or 4             0
// =============================================================
dcl-proc NUM_Descr_T;
  dcl-pi *N              int(10);
    i_type          int(3) const;
    i_length        int(3) const;
    i_fractional    int(3) const;
  end-pi;
  //
  dcl-ds *N;
    NUM_Descr       int(10) inz;
    NUM_Descr_24    int(3) overlay(NUM_Descr: 1);
    NUM_Descr_16    int(3) overlay(NUM_Descr: *NEXT);
    NUM_Descr_8     int(3) overlay(NUM_Descr: *NEXT);
    NUM_Descr_0     int(3) overlay(NUM_Descr: *NEXT);
  end-ds;

  NUM_Descr_0  = 0;
  NUM_Descr_8  = i_length;
  NUM_Descr_16 = i_fractional;
  NUM_Descr_24 = i_type;

  return NUM_Descr;

end-proc;
//
