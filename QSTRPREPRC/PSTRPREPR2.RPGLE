**FREE
/if defined(PSTRPREPR2)
/eof
/endif
/define PSTRPREPR2

/include QBASICS1,FDMSG
/include QBASICS1,FDQOBJ
/include QSTRPREPRC,TYPES_H

dcl-pr run
       extproc('STRPREPRC2_+
       run+
       ');
  i_useSrcFile    const  like(file_t);
  i_useSrcLib     const  like(lib_t);
  i_useSrcMbr     const  like(mbr_t);
  i_useStmf       const  like(path_t);
  i_cmd           const  like(cmd_t);
  i_chgObjD       const  like(chgObjD_t);
  i_objType       const  like(objType_t);
  i_objSrcFile    const  like(file_t);
  i_objSrcLib     const  like(lib_t);
  i_objSrcMbr     const  like(mbr_t);
  i_lib           const  like(lib_t);
  i_obj           const  like(obj_t);
  i_typeCode      const  like(typeCode_t);
  i_srcLib        const  like(lib_t);
  i_srcFile       const  like(file_t);
  i_srcMbr        const  like(mbr_t);
  i_testLib       const  like(lib_t);
  i_testObj       const  like(obj_t);
  i_tgtRls        const  like(tgtRls_t);
  i_frmSrcLib     const  like(lib_t);
  i_frmSrcFile    const  like(file_t);
  i_frmSrcMbr     const  like(mbr_t);
  i_user0         const  like(userParm_t);
  i_user1         const  like(userParm_t);
  i_user2         const  like(userParm_t);
  i_user3         const  like(userParm_t);
  i_user4         const  like(userParm_t);
  i_user5         const  like(userParm_t);
  i_user6         const  like(userParm_t);
  i_user7         const  like(userParm_t);
  i_user8         const  like(userParm_t);
  i_user9         const  like(userParm_t);
  i_stmf          const  like(path_t);
  i_tagsReq       const  like(bool_t);
  i_msgFile       const  like(msg_t.file);
  i_msgFileLib    const  like(msg_t.lib);
  i_pgmCmdExc
       const  like(pgm_t);
  i_libPgmCmdExc
       const  like(lib_t);
  i_option        const  likeds(option_t);
i_libl          const  likeds(inpLibList_t);
i_useLibl       const  like(bool_t);
i_usrDefVars    const  likeds(inpUsrDefVars_t);
i_execOpt       const  likeds(execOpt_t);
i_rnf7031       const  like(rnf7031_t);
end-pr;

dcl-pr sendMsg
       extproc('STRPREPRC2_+
       sendMsg+
       ');
  i_msg           value  likeds(msg_t);
end-pr;

dcl-pr endAbnormal
       extproc('STRPREPRC2_+
       endAbnormal+
       ');
  i_qEventf       const  likeds(qObj_t)
options(*nopass);
end-pr;

