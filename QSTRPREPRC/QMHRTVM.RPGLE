      /IF NOT DEFINED(QMHRTVM)
      /DEFINE QMHRTVM
      *
      *  Retrieve Message (QMHRTVM) API
     D QMHRTVM...
     D                 PR                  extpgm('QMHRTVM')
     D  o_msgInf                  65535A          options(*varsize)
     D  i_msgInfLen                  10I 0 const
     D  i_format                      8A   const
     D  i_msgID                       7A   const
     D  i_qMsgF                      20A   const
     D  i_rplData                 65535A   const  options(*varsize )
     D  i_rpldataLen                 10I 0 const
     D  i_rplVars                    10A   const
     D  i_rtnCtrlChrs                10A   const
     D  io_ErrCode                65535A          options(*varsize )
     D  i_rtvOpt                     10A   const  options(*nopass  )            | OptGrp 1
     D  i_toCcsid                    10I 0 const  options(*nopass  )            |
     D  i_ccsidRplDta                10I 0 const  options(*nopass  )            |
      *
      /if not defined(rtvm0100_t)
      /define rtvm0100_t
     D rtvm0100_t      DS                  qualified           based(pDummy)
      *  Bytes returned
     D  BYTRET                        9B 0
      *  Bytes available
     D  BYTAVL                        9B 0
      *  Length of message returned
     D  LENMSGRET                     9B 0
      *  Length of message available
     D  LENMSGAVL                     9B 0
      *  Length of msg help returned
     D  LENHLPRET                     9B 0
      *  Length of msg help available
     D  LENHLPAVL                     9B 0
      *  Msg text and data of varying length!
     D  DATA                       2048A
      *
      /endif
      /if not defined(rtvm0200_t)
      /define rtvm0200_t
     D rtvm0200_t      DS                  qualified           based(pDummy)
      *  Bytes returned
     D  bytRet                       10I 0
      *  Bytes available
     D  bytAvl                       10I 0
      *  Message severity
     D  msgSev                       10I 0
      *  Alert index
     D  altIdx                       10I 0
      * Alert Option
     D  altOpt                        9A
      * Log indicator
     D  logInd                        1A
      * Reserved
     D  reserved_1                    2A
      * Length of default reply ret.
     D  lenDftRpyR                   10I 0
      * Length of default reply avl.
     D  lenDftRpyA                   10I 0
      * Length of message returned
     D  lenMsgR                      10I 0
      * Length of message available
     D  lenMsgA                      10I 0
      * Length of message help ret.
     D  lenMsgHlpR                   10I 0
      * Length of message help avl.
     D  lenMsgHlpA                   10I 0
      *                       CHAR(*)  Default reply
      *                       CHAR(*)  Message
      *                       CHAR(*)  Message help
      *
      /endif
      /if not defined(rtvm0300_t)
      /define rtvm0300_t
     D rtvm0300_t      DS                  qualified           based(pDummy)
      *  Bytes returned
     D  bytRet                       10I 0
      *  Bytes available
     D  bytAvl                       10I 0
      *  Message severity
     D  msgSev                       10I 0
      *  Alert index
     D  altIdx                       10I 0
      * Alert Option
     D  altOpt                        9A
      * Log indicator
     D  logInd                        1A
      * Message ID
     D  msgID                         7A
      * Reserved
     D  reserved_01                   3A
      * Nbr. of subst. var. formats
     D  numVarFmt                    10I 0
      * CCSID conv. stat. ind. text
     D  csIndTxt                     10I 0
      * CCSID conv. stat. ind. data
     D  csIndDta                     10I 0
      * CCSID of Text returned
     D  ccsidTxt                     10I 0
      * Offset of default reply
     D  ofsDftR                      10I 0
      * Length of default reply ret.
     D  lenDftRpyR                   10I 0
      * Length of default reply avl.
     D  lenDftRpyA                   10I 0
      * Offset of message
     D  ofsMsg                       10I 0
      * Length of message returned
     D  lenMsgR                      10I 0
      * Length of message available
     D  lenMsgA                      10I 0
      * Offset of message help
     D  ofsMsgHlp                    10I 0
      * Length of message help ret.
     D  lenMsgHlpR                   10I 0
      * Length of message help avl.
     D  lenMsgHlpA                   10I 0
      * Ofs. of subst. var. formats
     D  ofsVarFmt                    10I 0
      * Length subst. var. fmt. ret.
     D  lenVarFmtR                   10I 0
      * Length subst. var. fmt. avl.
     D  lenVarFmtA                   10I 0
      * Length subst. var. element
     D  lenVarFmtE                   10I 0
      * Data
     D  data                       4096A
      *                       CHAR(*)  Default reply
      *                       CHAR(*)  Message
      *                       CHAR(*)  Message help
      *                       CHAR(*)  Substitution variable formats
      *
      /endif
      /if not defined(rtvm0400_t)
      /define rtvm0400_t
     D rtvm0400_t      DS                  qualified           based(pDummy)
      *  Bytes returned
     D  bytRet                       10I 0
      *  Bytes available
     D  bytAvl                       10I 0
      *  Message severity
     D  msgSev                       10I 0
      *  Alert index
     D  altIdx                       10I 0
      * Alert Option
     D  altOpt                        9A
      * Log indicator
     D  logInd                        1A
      * Message ID
     D  msgID                         7A
      * Reserved
     D  reserved_01                   3A
      * Nbr. of subst. var. formats
     D  numVarFmt                    10I 0
      * CCSID conv. stat. ind. text
     D  csIndTxt                     10I 0
      * CCSID conv. stat. ind. data
     D  csIndDta                     10I 0
      * CCSID of Text returned
     D  ccsidTxt                     10I 0
      * Offset of default reply
     D  ofsDftR                      10I 0
      * Length of default reply ret.
     D  lenDftRpyR                   10I 0
      * Length of default reply avl.
     D  lenDftRpyA                   10I 0
      * Offset of message
     D  ofsMsg                       10I 0
      * Length of message returned
     D  lenMsgR                      10I 0
      * Length of message available
     D  lenMsgA                      10I 0
      * Offset of message
     D  ofsMsgHlp                    10I 0
      * Length of message help ret.
     D  lenMsgHlpR                   10I 0
      * Length of message help avl.
     D  lenMsgHlpA                   10I 0
      * Ofs. of subst. var. formats
     D  ofsVarFmt                    10I 0
      * Length subst. var. fmt. ret.
     D  lenVarFmtR                   10I 0
      * Length subst. var. fmt. avl.
     D  lenVarFmtA                   10I 0
      * Length subst. var. element
     D  lenVarFmtE                   10I 0
      * Reply type
     D  rpyType                      10A
      * Reserved
     D  reserved_02                   2A
      * Maximum reply length
     D  maxRpyLen                    10I 0
      * Maximum reply decimal positions
     D  maxRpyDecPos                 10I 0
      * Offset of valid reply value entries
     D  ofsRpyE                      10I 0
      * Number of valid reply values entries returned
     D  numRpyER                     10I 0
      * Length of valid reply value entries returned
     D  lenRpyER                     10I 0
      * Length of valid reply value entries available
     D  lenRpyEA                     10I 0
      * Length of valid reply value entry
     D  lenRpyE                      10I 0
      * Offset of special reply value entries
     D  ofsSpcRpyE                   10I 0
      * Number of special reply values returned
     D  numSpcRpyER                  10I 0
      * Length of special reply value entries returned
     D  lenSpcRpyER                  10I 0
      * Length of special reply value entries available
     D  lenSpcRpyEA                  10I 0
      * Length of special reply value entry
     D  lenSpcRpyE                   10I 0
      * Offset of lower range reply value
     D  ofsLowRpyE                   10I 0
      * Length of lower range reply value returned
     D  lenLowRpyER                  10I 0
      * Length of lower range reply value available
     D  lenLowRpyEA                  10I 0
      * Offset of upper range reply value
     D  ofsUpRpyE                    10I 0
      * Length of upper range reply value returned
     D  ofsUpRpyER                   10I 0
      * Length of upper range reply value available
     D  ofsUpRpyEA                   10I 0
      * Offset of relational test entry
     D  ofsRelTestE                  10I 0
      * Length of relational test entry returned
     D  lenRelTestER                 10I 0
      * Length of relational test entry available
     D  lenRelTestEA                 10I 0
      * Message creation date
     D  crtDate                       7A
      * Reserved
     D  reserved_03                   1A
      * Message creation level number
     D  crtLvlNbr                    10I 0
      * Message modification date
     D  modDate                       7A
      * Reserved
     D  reserved_04                   1A
      * Message modification level number
     D  modLvlNbr                    10I 0
      * Stored CCSID of message
     D  storedCCSID                  10I 0
      * Offset of dump list entries
     D  ofsDmpListE                  10I 0
      * Number of dump list entries returned
     D  numDmpListER                 10I 0
      * Length of dump list entries returned
     D  lenDmpListER                 10I 0
      * Length of dump list entries available
     D  lenDmpListEA                 10I 0
      * Default program name
     D  dftPgmName                   10A
      * Default program library name
     D  dftPgmLib                    10A
      * Data
     D  data                       4096A
      *                       CHAR(*)  Default reply
      *                       CHAR(*)  Message
      *                       CHAR(*)  Message help
      *                       CHAR(*)  Substitution variable formats
      *                       CHAR(*)  Valid reply value entries
      *                       CHAR(*)  Special reply value entries
      *                       CHAR(*)  Lower range reply value
      *                       CHAR(*)  Upper range reply value
      *                       CHAR(*)  Relational test entry
      *                       CHAR(*)  Dump list entries
      *
      /endif
      /if not defined(qmhrtvm_substVarFmt_t)
      /define qmhrtvm_substVarFmt_t
     D qmhrtvm_substVarFmt_t...
     D                 DS                  qualified           based(pDummy)
     D  length                 1      4i 0
     D  sizeOrDecPos           5      8i 0
     D  size                         10i 0 overlay(sizeOrDecPos)
     D  decPos                       10i 0 overlay(sizeOrDecPos)
     D  type                   9     18a
      *                       CHAR(*)  Reserved
      /endif
      /ENDIF
