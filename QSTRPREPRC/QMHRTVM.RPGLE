**free
/if NOT DEFINED(QMHRTVM)
/define QMHRTVM

//  Retrieve Message (QMHRTVM) API
dcl-pr QMHRTVM extpgm('QMHRTVM');
  o_msgInf      char(65535) options(*varsize);
  i_msgInfLen   int(10) const;
  i_format      char(8) const;
  i_msgID       char(7) const;
  i_qMsgF       char(20) const;
  i_rplData     char(65535) options(*varsize) const;
  i_rpldataLen  int(10) const;
  i_rplVars     char(10) const;
  i_rtnCtrlChrs char(10) const;
  io_ErrCode    char(65535) options(*varsize);
  i_rtvOpt      char(10) options(*nopass) const; // | OptGrp 1
  i_toCcsid     int(10) options(*nopass) const; // |
  i_ccsidRplDta int(10) options(*nopass) const; // |
end-pr;

/if not defined(rtvm0100_t)
/define rtvm0100_t
dcl-ds rtvm0100_t qualified based(pDummy);
  //  Bytes returned
  BYTRET    bindec(9);
  //  Bytes available
  BYTAVL    bindec(9);
  //  Length of message returned
  LENMSGRET bindec(9);
  //  Length of message available
  LENMSGAVL bindec(9);
  //  Length of msg help returned
  LENHLPRET bindec(9);
  //  Length of msg help available
  LENHLPAVL bindec(9);
  //  Msg text and data of varying length!
  DATA      char(2048);
end-ds;

/endif
/if not defined(rtvm0200_t)
/define rtvm0200_t
dcl-ds rtvm0200_t qualified based(pDummy);
  //  Bytes returned
  bytRet     int(10);
  //  Bytes available
  bytAvl     int(10);
  //  Message severity
  msgSev     int(10);
  //  Alert index
  altIdx     int(10);
  // Alert Option
  altOpt     char(9);
  // Log indicator
  logInd     char(1);
  // Reserved
  reserved_1 char(2);
  // Length of default reply ret.
  lenDftRpyR int(10);
  // Length of default reply avl.
  lenDftRpyA int(10);
  // Length of message returned
  lenMsgR    int(10);
  // Length of message available
  lenMsgA    int(10);
  // Length of message help ret.
  lenMsgHlpR int(10);
  // Length of message help avl.
  lenMsgHlpA int(10);
end-ds;
//                       CHAR(*)  Default reply
//                       CHAR(*)  Message
//                       CHAR(*)  Message help

/endif
/if not defined(rtvm0300_t)
/define rtvm0300_t
dcl-ds rtvm0300_t qualified based(pDummy);
  //  Bytes returned
  bytRet      int(10);
  //  Bytes available
  bytAvl      int(10);
  //  Message severity
  msgSev      int(10);
  //  Alert index
  altIdx      int(10);
  // Alert Option
  altOpt      char(9);
  // Log indicator
  logInd      char(1);
  // Message ID
  msgID       char(7);
  // Reserved
  reserved_01 char(3);
  // Nbr. of subst. var. formats
  numVarFmt   int(10);
  // CCSID conv. stat. ind. text
  csIndTxt    int(10);
  // CCSID conv. stat. ind. data
  csIndDta    int(10);
  // CCSID of Text returned
  ccsidTxt    int(10);
  // Offset of default reply
  ofsDftR     int(10);
  // Length of default reply ret.
  lenDftRpyR  int(10);
  // Length of default reply avl.
  lenDftRpyA  int(10);
  // Offset of message
  ofsMsg      int(10);
  // Length of message returned
  lenMsgR     int(10);
  // Length of message available
  lenMsgA     int(10);
  // Offset of message help
  ofsMsgHlp   int(10);
  // Length of message help ret.
  lenMsgHlpR  int(10);
  // Length of message help avl.
  lenMsgHlpA  int(10);
  // Ofs. of subst. var. formats
  ofsVarFmt   int(10);
  // Length subst. var. fmt. ret.
  lenVarFmtR  int(10);
  // Length subst. var. fmt. avl.
  lenVarFmtA  int(10);
  // Length subst. var. element
  lenVarFmtE  int(10);
  // Data
  data        char(4096);
end-ds;
//                       CHAR(*)  Default reply
//                       CHAR(*)  Message
//                       CHAR(*)  Message help
//                       CHAR(*)  Substitution variable formats

/endif
/if not defined(rtvm0400_t)
/define rtvm0400_t
dcl-ds rtvm0400_t qualified based(pDummy);
  //  Bytes returned
  bytRet       int(10);
  //  Bytes available
  bytAvl       int(10);
  //  Message severity
  msgSev       int(10);
  //  Alert index
  altIdx       int(10);
  // Alert Option
  altOpt       char(9);
  // Log indicator
  logInd       char(1);
  // Message ID
  msgID        char(7);
  // Reserved
  reserved_01  char(3);
  // Nbr. of subst. var. formats
  numVarFmt    int(10);
  // CCSID conv. stat. ind. text
  csIndTxt     int(10);
  // CCSID conv. stat. ind. data
  csIndDta     int(10);
  // CCSID of Text returned
  ccsidTxt     int(10);
  // Offset of default reply
  ofsDftR      int(10);
  // Length of default reply ret.
  lenDftRpyR   int(10);
  // Length of default reply avl.
  lenDftRpyA   int(10);
  // Offset of message
  ofsMsg       int(10);
  // Length of message returned
  lenMsgR      int(10);
  // Length of message available
  lenMsgA      int(10);
  // Offset of message
  ofsMsgHlp    int(10);
  // Length of message help ret.
  lenMsgHlpR   int(10);
  // Length of message help avl.
  lenMsgHlpA   int(10);
  // Ofs. of subst. var. formats
  ofsVarFmt    int(10);
  // Length subst. var. fmt. ret.
  lenVarFmtR   int(10);
  // Length subst. var. fmt. avl.
  lenVarFmtA   int(10);
  // Length subst. var. element
  lenVarFmtE   int(10);
  // Reply type
  rpyType      char(10);
  // Reserved
  reserved_02  char(2);
  // Maximum reply length
  maxRpyLen    int(10);
  // Maximum reply decimal positions
  maxRpyDecPos int(10);
  // Offset of valid reply value entries
  ofsRpyE      int(10);
  // Number of valid reply values entries returned
  numRpyER     int(10);
  // Length of valid reply value entries returned
  lenRpyER     int(10);
  // Length of valid reply value entries available
  lenRpyEA     int(10);
  // Length of valid reply value entry
  lenRpyE      int(10);
  // Offset of special reply value entries
  ofsSpcRpyE   int(10);
  // Number of special reply values returned
  numSpcRpyER  int(10);
  // Length of special reply value entries returned
  lenSpcRpyER  int(10);
  // Length of special reply value entries available
  lenSpcRpyEA  int(10);
  // Length of special reply value entry
  lenSpcRpyE   int(10);
  // Offset of lower range reply value
  ofsLowRpyE   int(10);
  // Length of lower range reply value returned
  lenLowRpyER  int(10);
  // Length of lower range reply value available
  lenLowRpyEA  int(10);
  // Offset of upper range reply value
  ofsUpRpyE    int(10);
  // Length of upper range reply value returned
  ofsUpRpyER   int(10);
  // Length of upper range reply value available
  ofsUpRpyEA   int(10);
  // Offset of relational test entry
  ofsRelTestE  int(10);
  // Length of relational test entry returned
  lenRelTestER int(10);
  // Length of relational test entry available
  lenRelTestEA int(10);
  // Message creation date
  crtDate      char(7);
  // Reserved
  reserved_03  char(1);
  // Message creation level number
  crtLvlNbr    int(10);
  // Message modification date
  modDate      char(7);
  // Reserved
  reserved_04  char(1);
  // Message modification level number
  modLvlNbr    int(10);
  // Stored CCSID of message
  storedCCSID  int(10);
  // Offset of dump list entries
  ofsDmpListE  int(10);
  // Number of dump list entries returned
  numDmpListER int(10);
  // Length of dump list entries returned
  lenDmpListER int(10);
  // Length of dump list entries available
  lenDmpListEA int(10);
  // Default program name
  dftPgmName   char(10);
  // Default program library name
  dftPgmLib    char(10);
  // Data
  data         char(4096);
end-ds;
//                       CHAR(*)  Default reply
//                       CHAR(*)  Message
//                       CHAR(*)  Message help
//                       CHAR(*)  Substitution variable formats
//                       CHAR(*)  Valid reply value entries
//                       CHAR(*)  Special reply value entries
//                       CHAR(*)  Lower range reply value
//                       CHAR(*)  Upper range reply value
//                       CHAR(*)  Relational test entry
//                       CHAR(*)  Dump list entries

/endif
/if not defined(qmhrtvm_substVarFmt_t)
/define qmhrtvm_substVarFmt_t
dcl-ds qmhrtvm_substVarFmt_t qualified based(pDummy);
  length       int(10) pos(1);
  sizeOrDecPos int(10) pos(5);
  size         int(10) overlay(sizeOrDecPos);
  decPos       int(10) overlay(sizeOrDecPos);
  type         char(10) pos(9);
end-ds;
//                       CHAR(*)  Reserved
/endif
/endif
