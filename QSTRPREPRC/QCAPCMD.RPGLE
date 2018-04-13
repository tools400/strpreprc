      /IF NOT DEFINED(QCAPCMD)
      /DEFINE QCAPCMD
      *
      *  Process Commands (QCAPCMD) API
     D QCAPCMD...
     D                 PR                         extpgm('QCAPCMD')
     D  i_cmd                     32702A   const  options(*varsize)
     D  i_cmdLen                     10I 0 const
     D  i_ctrlBlk                 32767A   const  options(*varsize)
     D  i_ctrlBlkLen                 10I 0 const
     D  i_ctrlBlkFmt                  8A   const
     D  o_chgCmd                  32702A          options(*varsize)
     D  i_chgCmdLnPrv                10I 0 const
     D  o_chgCmdLnAvl                10I 0
     D  io_errorCode              32767A          options(*varsize)
      *
      *  Option control block
     D cpop0100_t      DS                  qualified               based(pDummy)
     D  typeCmdPrc             1      4I 0
     D  DBCS_data              5      5A
     D  prmtAction             6      6A
     D  cmdStrSyntax           7      7A
     D  msgRtvKey              8     11A
     D  ccsidCmdStr           12     15I 0                                      new V5R4
     D  res_01                16     20A
      *
      *  Type of command processing.
      *  The type of command processing to be performed by the system.
     D cQCAPCMD_PRC_EXC_QCMDEXC...
     D                 C                   0
     D cQCAPCMD_PRC_CHK_QCMDCHK...
     D                 C                   1
     D cQCAPCMD_PRC_EXC_CMDLINE...
     D                 C                   2
     D cQCAPCMD_PRC_CHK_CMDLINE...
     D                 C                   3
     D cQCAPCMD_PRC_CHK_CL_STMT...
     D                 C                   4
     D cQCAPCMD_PRC_CHK_SEU_CL...
     D                 C                   5
     D cQCAPCMD_PRC_CHK_SEU_CMD...
     D                 C                   6
     D cQCAPCMD_PRC_CHK_SEU_BND...
     D                 C                   7
     D cQCAPCMD_PRC_CHK_UDO...
     D                 C                   8
     D cQCAPCMD_PRC_CHK_SEU_CLLE...
     D                 C                   9
      *
      *  DBCS data handling.
      *  Whether the command analyzer should handle the SO/SI
      *  characters as DBCS delimiters.
     D cQCAPCMD_DBCS_IGNORE...
     D                 C                   '0'
     D cQCAPCMD_DBCS_HANDLE...
     D                 C                   '1'
      *
      *  Prompter action.
      *  Indicates whether the prompter should be called on a command string.
     D cQCAPCMD_PROMPT_NEVER...
     D                 C                   '0'
     D cQCAPCMD_PROMPT_ALWAYS...
     D                 C                   '1'
     D cQCAPCMD_PROMPT_SELECTIVE...
     D                 C                   '2'
     D cQCAPCMD_PROMPT_HELP...
     D                 C                   '3'
      *
      *  Command string syntax.
      *  Whether command processing should be done in i5/OS mode or System/38 mode.
     D cQCAPCMD_SYNTAX_SYSTEM...
     D                 C                   '0'
     D cQCAPCMD_SYNTAX_SYSTEM38...
     D                 C                   '1'
      *
      *  CCSID of command string.
      *  CCSID of the command string.
     D cQCAPCMD_CCSID_JOB...
     D                 C                   0
     D cQCAPCMD_CCSID_UTF8...
     D                 C                   1208
     D cQCAPCMD_CCSID_UTF16...
     D                 C                   1200
      *
      /ENDIF
