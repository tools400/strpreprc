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
     D  i_useSrcFile                       const  like(file_t)
     D  i_useSrcLib                        const  like(lib_t)
     D  i_useSrcMbr                        const  like(mbr_t)
     D  i_useStmf                          const  like(path_t)
     D  i_cmd                              const  like(cmd_t)
     D  i_chgObjD                          const  like(chgObjD_t)
     D  i_objType                          const  like(objType_t)
     D  i_objSrcFile                       const  like(file_t)
     D  i_objSrcLib                        const  like(lib_t)
     D  i_objSrcMbr                        const  like(mbr_t)
     D  i_lib                              const  like(lib_t)
     D  i_obj                              const  like(obj_t)
     D  i_typeCode                         const  like(typeCode_t)
     D  i_srcLib                           const  like(lib_t)
     D  i_srcFile                          const  like(file_t)
     D  i_srcMbr                           const  like(mbr_t)
     D  i_testLib                          const  like(lib_t)
     D  i_testObj                          const  like(obj_t)
     D  i_tgtRls                           const  like(tgtRls_t)
     D  i_frmSrcLib                        const  like(lib_t)
     D  i_frmSrcFile                       const  like(file_t)
     D  i_frmSrcMbr                        const  like(mbr_t)
     D  i_user0                            const  like(userParm_t)
     D  i_user1                            const  like(userParm_t)
     D  i_user2                            const  like(userParm_t)
     D  i_user3                            const  like(userParm_t)
     D  i_user4                            const  like(userParm_t)
     D  i_user5                            const  like(userParm_t)
     D  i_user6                            const  like(userParm_t)
     D  i_user7                            const  like(userParm_t)
     D  i_user8                            const  like(userParm_t)
     D  i_user9                            const  like(userParm_t)
     D  i_stmf                             const  like(path_t)
     D  i_tagsReq                          const  like(bool_t)
     D  i_msgFile                          const  like(msg_t.file)
     D  i_msgFileLib                       const  like(msg_t.lib)
     D  i_pgmCmdExc...
     D                                     const  like(pgm_t)
     D  i_libPgmCmdExc...
     D                                     const  like(lib_t)
     D  i_option                           const  likeds(option_t)
     D  i_libl                             const  likeds(inpLibList_t)
     D  i_useLibl                          const  like(bool_t)
     D  i_usrDefVars                       const  likeds(inpUsrDefVars_t)
     D  i_execOpt                          const  likeds(execOpt_t)

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

