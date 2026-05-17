**free
/if NOT DEFINED(QMHRCVPM)
/define QMHRCVPM

//  Receive Program Message (QMHRCVPM) API
dcl-pr QMHRCVPM extpgm('QMHRCVPM');
  o_msgInf      char(65535) options(*varsize);
  i_msgInfLen   int(10) const;
  i_format      char(8) const;
  i_callStkE    char(256) const;
  i_callStkC    int(10) const;
  i_msgType     char(10) const;
  i_msgKey      char(4) const;
  i_wait        int(10) const;
  i_action      char(10) const;
  io_ErrCode    char(65535) options(*varsize);
  i_lenStkE     int(10) options(*nopass) const; // | optGrp 1
  i_callStkEQ   char(20) options(*nopass) const; // |
  i_callStkEDT  char(10) options(*nopass) const; // | optGrp 2
  i_ccsid       int(10) options(*nopass) const; // |
  i_alwDfRpyRjc char(10) options(*nopass) const; // | optGrp 3
end-pr;

dcl-ds rcvm0100_t qualified based(pDummy);
  bytRet            int(10); // Bytes ret.
  bytAvl            int(10); // Bytes avail.
  msgSev            int(10); // Msg Severty
  msgID             char(7); // Msg ID
  msgType           char(2); // Msg Type
  msgKey            char(4); // Msg Key
  reserved_1        char(7); // Reserved
  ccsidCnvStsDtaTxt int(10); // Conv. Status
  ccsidRplDtaTxt    int(10); // Ccsid Dta/Txt
  lenRplDtaRet      int(10); // Len.RplDta Ret
  lenRplDtaAvl      int(10); // Len.RplDta Avl
  varLenData        char(3136);
end-ds;
// Replacement data or impromptu message text    CHAR(*)

/if NOT DEFINED(rcvm0200_t)
/define rcvm0200_t

dcl-ds rcvm0200_t qualified based(pDummy);
  bytRet         int(10); // Bytes ret.
  bytAvl         int(10); // Bytes avail.
  msgSev         int(10); // Msg Severty
  msgID          char(7); // Msg ID
  msgType        char(2); // Msg Type
  msgKey         char(4); // Msg Key
  msgF           char(10); // Msg File
  msgFLib        char(10); // Msg File Lib
  msgFLibRet     char(10); // Msg File Lib
  sndJob         char(10); // Snd.Job
  sndUser        char(10); // Snd.User
  sndNbr         char(6); // Snd.JobNbr
  sndPgm         char(12); // Snd.Pgm
  sndPgmInstr    char(4); // Snd.Pgm Instr#
  sndDate        char(7); // Snd.Date
  sndTime        char(6); // Snd.Time
  rcvPgm         char(10); // Rcv.Pgm
  rcvPgmInstr    char(4); // Rcv.Pgm Instr#
  sndType        char(1); // Snd.Type
  rcvType        char(1); // Rcv.Type
  reserved_01    char(1); // reserved
  ccsidCnvStsTxt int(10); // Conv.Sts.Text
  ccsidCnvStsDta int(10); // Conv.Sts.Data
  alrOpt         char(9); // Alert Option
  ccsidText      int(10); // Ccsid Text
  ccsidRplDta    int(10); // Ccsid Data
  lenRplDtaRet   int(10); // Len.RplDta Ret
  lenRplDtaAvl   int(10); // Len.RplDta Avl
  lenMsgRet      int(10); // Len.Msg Avl
  lenMsgAvl      int(10); // Len.Msg Ret
  lenMsgHlpRet   int(10); // Len.Help Ret
  lenMsgHlpAvl   int(10); // Len.Help Avl
  varLenData     char(3136);
end-ds;
// Replacement data or impromptu message text    CHAR(*)
// Message                                       CHAR(*)
// Message help                                  CHAR(*)

/endif

/if NOT DEFINED(rcvm0300_t)
/define rcvm0300_t

dcl-ds rcvm0300_t qualified based(pDummy);
  bytRet         int(10); // Bytes ret.
  bytAvl         int(10); // Bytes avail.
  msgSev         int(10); // Msg Severty
  msgID          char(7); // Msg ID
  msgType        char(2); // Msg Type
  msgKey         char(4); // Msg Key
  msgF           char(10); // Msg File
  msgFLib        char(10); // Msg File Lib
  msgFLibRet     char(10); // Msg File Lib
  alrOpt         char(9); // Alert Option
  ccsidCnvStsTxt int(10); // Conv.Sts.Text
  ccsidCnvStsDta int(10); // Conv.Sts.Data
  ccsidRplDta    int(10); // Ccsid Data
  ccsidText      int(10); // Ccsid Text
  lenRplDtaRet   int(10); // Len.RplDta Ret
  lenRplDtaAvl   int(10); // Len.RplDta Avl
  lenMsgRet      int(10); // Len.Msg Avl
  lenMsgAvl      int(10); // Len.Ms
  lenMsgHlpRet   int(10); // Len.Help Ret
  lenMsgHlpAvl   int(10); // Len.Help Avl
  lenSndInfRet   int(10); // Len.SndInf Ret
  lenSndInfAvl   int(10); // Len.SndInf Avl
  varLenData     char(3136);
end-ds;
// Replacement data or impromptu message text    CHAR(*)
// Message                                       CHAR(*)
// Message help                                  CHAR(*)
// Sender information                            CHAR(*)

/endif

// --------------------------------------------
//  QMHRCVM API - Sender Information Format
// --------------------------------------------
dcl-ds rcvm_sndInf_t qualified based(pDummy);
  sndJob        char(10) pos(1); // Snd.Job
  sndUser       char(10) pos(11); // Snd.User
  sndNbr        char(6) pos(21); // Snd.JobNbr
  sndDate       char(7) pos(27); // Snd.Data
  sndTime       char(6) pos(34); // Snd.Time
  sndType       char(1) pos(40); // Snd.Type
  rcvType       char(1) pos(41); // Rcv.Type
  sndPgm        char(12) pos(42); // Snd.Pgm
  sndMod        char(10) pos(54); // Snd.Module
  sndProc       char(256) pos(64); // Snd.Procedure
  reserved_01   char(1) pos(320); // reserved
  sndPgmNumStmt int(10) pos(321); // Num Stmt/Instr
  sndPgmStmts   char(30) pos(325); // Stmts/Instr.
  sndPgmStmt    char(10) dim(3) overlay(sndPgmStmts);
  rcvPgm        char(10) pos(355); // Rcv.Pgm
  rcvMod        char(10) pos(365); // Rcv.Module
  rcvProc       char(256) pos(375); // Rcv.Procedure
  reserved_02   char(10) pos(631); // reserved
  rcvPgmNumStmt int(10) pos(641); // Num Stmt/Instr
  rcvPgmStmts   char(30) pos(645); // Stmts/Instr.
  rcvPgmStmt    char(10) dim(3) overlay(rcvPgmStmts);
  reserved_03   char(2) pos(675); // reserved
  ofsSndPgmName int(10) pos(677); // Ofs.Long Name
  lenSndPgmName int(10) pos(681); // Len.Long Name
  ofsSndPrcName int(10) pos(685); // Ofs.Long Name
  lenSndPrcName int(10) pos(689); // Len.Long Name
  ofsRcvPrcName int(10) pos(693); // Ofs.Long Name
  lenRcvPrcName int(10) pos(697); // Len.Long Name
  microSecs     char(6) pos(701); // Microseconds
  sndUsrPrf     char(10) pos(707); // Snd.User
end-ds;
// Reserved                                      CHAR(*)
// Long sending program name                     CHAR(*)
// Long sending procedure name                   CHAR(*)
// Long receiving procedure name                 CHAR(*)
//
// ---------------------------------------------------
//  Call stack entry
// ---------------------------------------------------
/if NOT DEFINED(cQMSG_CALLSTACK_ENTRY_SAME)
/define cQMSG_CALLSTACK_ENTRY_SAME
dcl-c cQMSG_CALLSTACK_ENTRY_SAME '*';
/endif

/if NOT DEFINED(cQMSG_CALLSTACK_ENTRY_EXT)
/define cQMSG_CALLSTACK_ENTRY_EXT
dcl-c cQMSG_CALLSTACK_ENTRY_EXT '*EXT';
/endif

// ---------------------------------------------------
//  Message action
// ---------------------------------------------------
dcl-c cQMSG_ACTION_OLD '*OLD';

dcl-c cQMSG_ACTION_REMOVE '*REMOVE';

dcl-c cQMSG_ACTION_SAME '*SAME';

// ---------------------------------------------------
//  Call stack entry qualification
// ---------------------------------------------------
/if NOT DEFINED(cQMSG_CALLSTACK_ENTRY_QUALIFIER_NONE)
/define cQMSG_CALLSTACK_ENTRY_QUALIFIER_NONE
dcl-c cQMSG_CALLSTACK_ENTRY_QUALIFIER_NONE '*NONE';
/endif

// ---------------------------------------------------
//  Call stack entry data type
// ---------------------------------------------------
/if NOT DEFINED(cQMSG_CALLSTACK_ENTRY_DATATYPE_CHAR)
/define cQMSG_CALLSTACK_ENTRY_DATATYPE_CHAR
dcl-c cQMSG_CALLSTACK_ENTRY_DATATYPE_CHAR '*CHAR';
/endif

/if NOT DEFINED(cQMSG_CALLSTACK_ENTRY_DATATYPE_PTR)
/define cQMSG_CALLSTACK_ENTRY_DATATYPE_PTR
dcl-c cQMSG_CALLSTACK_ENTRY_DATATYPE_PTR '*PTR';
/endif

// ---------------------------------------------------
//  Allow default reply rejection
// ---------------------------------------------------
dcl-c cQMSG_ALLOW_DFT_REPLY_REJECT_NO '*NO';

dcl-c cQMSG_ALLOW_DFT_REPLY_REJECT_YES '*YES';

/endif
