      /IF NOT DEFINED(QMHRCVPM)
      /DEFINE QMHRCVPM
      *
      *  Receive Program Message (QMHRCVPM) API
     D QMHRCVPM...
     D                 PR                  extpgm('QMHRCVPM')
     D  o_msgInf                  65535A          options(*varsize)
     D  i_msgInfLen                  10I 0 const
     D  i_format                      8A   const
     D  i_callStkE                  256A   const
     D  i_callStkC                   10I 0 const
     D  i_msgType                    10A   const
     D  i_msgKey                      4A   const
     D  i_wait                       10I 0 const
     D  i_action                     10A   const
     D  io_ErrCode                65535A          options(*varsize)
     D  i_lenStkE                    10I 0 const  options(*nopass )             | optGrp 1
     D  i_callStkEQ                  20A   const  options(*nopass )             |
     D  i_callStkEDT                 10A   const  options(*nopass )             | optGrp 2
     D  i_ccsid                      10I 0 const  options(*nopass )             |
     D  i_alwDfRpyRjc                10A   const  options(*nopass )             | optGrp 3
      *
     D rcvm0100_t...
     D                 DS                  qualified               based(pDummy)
     D  bytRet                       10I 0                                      Bytes ret.
     D  bytAvl                       10I 0                                      Bytes avail.
     D  msgSev                       10I 0                                      Msg Severty
     D  msgID                         7A                                        Msg ID
     D  msgType                       2A                                        Msg Type
     D  msgKey                        4A                                        Msg Key
     D  reserved_1                    7A                                        Reserved
     D  ccsidCnvStsDtaTxt...                                                    Conv. Status
     D                               10I 0
     D  ccsidRplDtaTxt...                                                       Ccsid Dta/Txt
     D                               10I 0
     D  lenRplDtaRet                 10I 0                                      Len.RplDta Ret
     D  lenRplDtaAvl                 10I 0                                      Len.RplDta Avl
     D  varLenData                 3136
      * Replacement data or impromptu message text    CHAR(*)
      *
      /IF NOT DEFINED(rcvm0200_t)
      /DEFINE rcvm0200_t
      *
     D rcvm0200_t...
     D                 DS                  qualified               based(pDummy)
     D  bytRet                       10I 0                                      Bytes ret.
     D  bytAvl                       10I 0                                      Bytes avail.
     D  msgSev                       10I 0                                      Msg Severty
     D  msgID                         7A                                        Msg ID
     D  msgType                       2A                                        Msg Type
     D  msgKey                        4A                                        Msg Key
     D  msgF                         10A                                        Msg File
     D  msgFLib                      10A                                        Msg File Lib
     D  msgFLibRet                   10A                                        Msg File Lib
     D  sndJob                       10A                                        Snd.Job
     D  sndUser                      10A                                        Snd.User
     D  sndNbr                        6A                                        Snd.JobNbr
     D  sndPgm                       12A                                        Snd.Pgm
     D  sndPgmInstr                   4A                                        Snd.Pgm Instr#
     D  sndDate                       7A                                        Snd.Date
     D  sndTime                       6A                                        Snd.Time
     D  rcvPgm                       10A                                        Rcv.Pgm
     D  rcvPgmInstr                   4A                                        Rcv.Pgm Instr#
     D  sndType                       1A                                        Snd.Type
     D  rcvType                       1A                                        Rcv.Type
     D  reserved_01                   1A                                        reserved
     D  ccsidCnvStsTxt...
     D                               10I 0                                      Conv.Sts.Text
     D  ccsidCnvStsDta...
     D                               10I 0                                      Conv.Sts.Data
     D  alrOpt                        9A                                        Alert Option
     D  ccsidText                    10I 0                                      Ccsid Text
     D  ccsidRplDta                  10I 0                                      Ccsid Data
     D  lenRplDtaRet                 10I 0                                      Len.RplDta Ret
     D  lenRplDtaAvl                 10I 0                                      Len.RplDta Avl
     D  lenMsgRet                    10I 0                                      Len.Msg Avl
     D  lenMsgAvl                    10I 0                                      Len.Msg Ret
     D  lenMsgHlpRet                 10I 0                                      Len.Help Ret
     D  lenMsgHlpAvl                 10I 0                                      Len.Help Avl
     D  varLenData                 3136
      * Replacement data or impromptu message text    CHAR(*)
      * Message                                       CHAR(*)
      * Message help                                  CHAR(*)
      *
      /ENDIF
      *
      /IF NOT DEFINED(rcvm0300_t)
      /DEFINE rcvm0300_t
      *
     D rcvm0300_t...
     D                 DS                  qualified               based(pDummy)
     D  bytRet                       10I 0                                      Bytes ret.
     D  bytAvl                       10I 0                                      Bytes avail.
     D  msgSev                       10I 0                                      Msg Severty
     D  msgID                         7A                                        Msg ID
     D  msgType                       2A                                        Msg Type
     D  msgKey                        4A                                        Msg Key
     D  msgF                         10A                                        Msg File
     D  msgFLib                      10A                                        Msg File Lib
     D  msgFLibRet                   10A                                        Msg File Lib
     D  alrOpt                        9A                                        Alert Option
     D  ccsidCnvStsTxt...
     D                               10I 0                                      Conv.Sts.Text
     D  ccsidCnvStsDta...
     D                               10I 0                                      Conv.Sts.Data
     D  ccsidRplDta                  10I 0                                      Ccsid Data
     D  ccsidText                    10I 0                                      Ccsid Text
     D  lenRplDtaRet                 10I 0                                      Len.RplDta Ret
     D  lenRplDtaAvl                 10I 0                                      Len.RplDta Avl
     D  lenMsgRet                    10I 0                                      Len.Msg Avl
     D  lenMsgAvl                    10I 0                                      Len.Ms
     D  lenMsgHlpRet                 10I 0                                      Len.Help Ret
     D  lenMsgHlpAvl                 10I 0                                      Len.Help Avl
     D  lenSndInfRet                 10I 0                                      Len.SndInf Ret
     D  lenSndInfAvl                 10I 0                                      Len.SndInf Avl
     D  varLenData                 3136
      * Replacement data or impromptu message text    CHAR(*)
      * Message                                       CHAR(*)
      * Message help                                  CHAR(*)
      * Sender information                            CHAR(*)
      *
      /ENDIF
      *
      * --------------------------------------------
      *  QMHRCVM API - Sender Information Format
      * --------------------------------------------
     D rcvm_sndInf_t...
     D                 DS                  qualified               based(pDummy)
     D  sndJob                 1     10A                                        Snd.Job
     D  sndUser               11     20A                                        Snd.User
     D  sndNbr                21     26A                                        Snd.JobNbr
     D  sndDate               27     33A                                        Snd.Data
     D  sndTime               34     39A                                        Snd.Time
     D  sndType               40     40A                                        Snd.Type
     D  rcvType               41     41A                                        Rcv.Type
     D  sndPgm                42     53A                                        Snd.Pgm
     D  sndMod                54     63A                                        Snd.Module
     D  sndProc               64    319A                                        Snd.Procedure
     D  reserved_01          320    320A                                        reserved
     D  sndPgmNumStmt        321    324I 0                                      Num Stmt/Instr
     D  sndPgmStmts          325    354A                                        Stmts/Instr.
     D   sndPgmStmt                  10A   dim(3) overlay(sndPgmStmts)
     D  rcvPgm               355    364A                                        Rcv.Pgm
     D  rcvMod               365    374A                                        Rcv.Module
     D  rcvProc              375    630A                                        Rcv.Procedure
     D  reserved_02          631    640A                                        reserved
     D  rcvPgmNumStmt        641    644I 0                                      Num Stmt/Instr
     D  rcvPgmStmts          645    674A                                        Stmts/Instr.
     D   rcvPgmStmt                  10A   dim(3) overlay(rcvPgmStmts)
     D  reserved_03          675    676A                                        reserved
     D  ofsSndPgmName        677    680I 0                                      Ofs.Long Name
     D  lenSndPgmName        681    684I 0                                      Len.Long Name
     D  ofsSndPrcName        685    688I 0                                      Ofs.Long Name
     D  lenSndPrcName        689    692I 0                                      Len.Long Name
     D  ofsRcvPrcName        693    696I 0                                      Ofs.Long Name
     D  lenRcvPrcName        697    700I 0                                      Len.Long Name
     D  microSecs            701    706A                                        Microseconds
     D  sndUsrPrf            707    716A                                        Snd.User
      * Reserved                                      CHAR(*)
      * Long sending program name                     CHAR(*)
      * Long sending procedure name                   CHAR(*)
      * Long receiving procedure name                 CHAR(*)
      *
      * ---------------------------------------------------
      *  Call stack entry
      * ---------------------------------------------------
      /IF NOT DEFINED(cQMSG_CALLSTACK_ENTRY_SAME)
      /DEFINE cQMSG_CALLSTACK_ENTRY_SAME
     D cQMSG_CALLSTACK_ENTRY_SAME...
     D                 C                   '*'
      /ENDIF
      *
      /IF NOT DEFINED(cQMSG_CALLSTACK_ENTRY_EXT)
      /DEFINE cQMSG_CALLSTACK_ENTRY_EXT
     D cQMSG_CALLSTACK_ENTRY_EXT...
     D                 C                   '*EXT'
      /ENDIF
      *
      * ---------------------------------------------------
      *  Message action
      * ---------------------------------------------------
     D cQMSG_ACTION_OLD...
     D                 C                   '*OLD'
      *
     D cQMSG_ACTION_REMOVE...
     D                 C                   '*REMOVE'
      *
     D cQMSG_ACTION_SAME...
     D                 C                   '*SAME'
      *
      * ---------------------------------------------------
      *  Call stack entry qualification
      * ---------------------------------------------------
      /IF NOT DEFINED(cQMSG_CALLSTACK_ENTRY_QUALIFIER_NONE)
      /DEFINE cQMSG_CALLSTACK_ENTRY_QUALIFIER_NONE
     D cQMSG_CALLSTACK_ENTRY_QUALIFIER_NONE...
     D                 C                   '*NONE'
      /ENDIF
      *
      * ---------------------------------------------------
      *  Call stack entry data type
      * ---------------------------------------------------
      /IF NOT DEFINED(cQMSG_CALLSTACK_ENTRY_DATATYPE_CHAR)
      /DEFINE cQMSG_CALLSTACK_ENTRY_DATATYPE_CHAR
     D cQMSG_CALLSTACK_ENTRY_DATATYPE_CHAR...
     D                 C                   '*CHAR'
      /ENDIF
      *
      /IF NOT DEFINED(cQMSG_CALLSTACK_ENTRY_DATATYPE_PTR)
      /DEFINE cQMSG_CALLSTACK_ENTRY_DATATYPE_PTR
     D cQMSG_CALLSTACK_ENTRY_DATATYPE_PTR...
     D                 C                   '*PTR'
      /ENDIF
      *
      * ---------------------------------------------------
      *  Allow default reply rejection
      * ---------------------------------------------------
     D cQMSG_ALLOW_DFT_REPLY_REJECT_NO...
     D                 C                   '*NO'
      *
     D cQMSG_ALLOW_DFT_REPLY_REJECT_YES...
     D                 C                   '*YES'
      *
      /ENDIF
