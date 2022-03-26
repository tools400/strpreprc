      /if defined(PSTRPREPR2)
      /eof
      /endif
      /define PSTRPREPR2

      /include QBASICS1,FDMSG
      /include QBASICS1,FDQOBJ
      /include QSTRPREPRC,TYPES_H

     D run...
     D                 pr
     D                                     extproc('STRPREPRC2_+
     D                                     run+
     D                                     ')
     D  i_useSrcFile                              like(file_t)
     D  i_useSrcLib                               like(lib_t)
     D  i_useSrcMbr                               like(mbr_t)
     D  i_useStmf                                 like(path_t)
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
     D  i_stmf                                    like(path_t)
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

     D sendMsg...
     D                 PR
     D                                     extproc('STRPREPRC2_+
     D                                     sendMsg+
     D                                     ')
     D  i_msg                              value  likeds(msg_t)

     D endAbnormal...
     D                 pr
     D                                     extproc('STRPREPRC2_+
     D                                     endAbnormal+
     D                                     ')
     D  i_qEventf                          const  likeds(qObj_t)
     D                                     options(*nopass)

