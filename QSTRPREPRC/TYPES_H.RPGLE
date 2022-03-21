      /if not defined(types_h)
      /define types_h

      /include QBASICS1,FDMSG
      /include QBASICS1,FDQOBJ

      // must be equal to size of srcDta_t
     D MAX_RCD_LEN     c                   244

     D cERROR          c                   -1

     D cTYPE_DIAG      c                   '*DIAG'
     D cTYPE_ESCAPE    c                   '*ESCAPE'

     D cBACKSLASH      c                   '\'
     D cSLASH          c                   '/'
     D cDELIMITER      c                   ':/\'

     D int4_t          s             10i 0 template
     D cmd_t           s           8192a   template
     D cmdLong_t       s          32702a   template varying
     D cmdLongFixLen_t...
     D                 s          32702a   template
     D bool_t          s               n   template
     D mode_t          s             30a   template
     D module_t        s             10a   template
     D pgm_t           s             10a   template
     D proc_t          s             64a   template
     D tag_t           s             30a   template
     D continue_t      s              1a   template
     D keyData_t       s           4096a   template varying
     D obj_t           s             10a   template
     D tgtRls_t        s             10a   template
     D typeCode_t      s              6a   template
     D userParm_t      s             50a   template
     D chgObjD_t       s              4a   template
     D objType_t       s             10a   template
     D cErrorText_t    s            128a   template varying

     D file_t          s             10a   template
     D lib_t           s             10a   template
     D mbr_t           s             10a   template
     D path_t          s           4096a   varying template
     D fd_t            s             10i 0 template

     D srcSeq_t        s              6s 2 template
     D srcDat_t        s              6s 0 template
     D srcDta_t        s            244a   template

     D ds_srcFile_t    ds                  qualified template
     D  srcSeq                             like(srcSeq_t)
     D  srcDat                             like(srcDat_t)
     D  srcDta                             like(srcDta_t)
      *
     D DIM_OPTIONS     c                   5
      *
     D option_t        ds                  template qualified
     D  numE                          5i 0
     D  option                       10a   dim(DIM_OPTIONS)
      *
     D DIM_USRDEFVARS  c                   20
      *
     D inpUsrDefVars_t...
     D                 ds          2282    qualified template
     D  numElem                       5i 0
     D  offsItems                     5i 0 dim(DIM_USRDEFVARS)
      *
     D inpUsrDefVar_t...
     D                 ds                  qualified template
     D  numE                          5i 0
     D  name                         10a
     D  value                       100a
      *
     D DIM_EXECOPTS    c                   3
      *
     D execOpt_t       ds                  qualified template
     D  numElem                       5i 0
     D  execOpt                      10a   dim(DIM_EXECOPTS)
      *
     D DIM_LIBLIST     c                   250
      *
     D inpLibList_t    ds                  qualified template
     D  numElem                       5i 0
     D  curLib                       10a
     D  offsUsrLibl                   5i 0
     D  numUsrLiblE                   5i 0
     D  lib                          10a   dim(DIM_LIBLIST)
      *
     D libl_t          ds                  qualified template
     D  numE                          5i 0
     D  name                               like(lib_t) dim(DIM_LIBLIST)
      *
     D liblList_t      ds                  qualified template
     D  curLib                             like(lib_t)
     D  usrLibl                            likeds(libl_t)
      *
     D usrDefVars_t    ds                  qualified template
     D  numE                          5i 0
     D  var                                likeds(usrDefVar_t)
     D                                     dim(DIM_USRDEFVARS)
      *
     D usrDefVar_t     ds                  qualified template
     D  name                         10a
     D  value                       100a
      *
     D lineData_t      ds                  qualified template
     D  continue                           like(continue_t)
     D  keyData                            like(keyData_t)
      *
     D monMsgIds_t     ds                  qualified template
     D  item                               like(msgId_t) dim(50)
      *
     D variables_t     ds                  qualified template
     D  lib                                like(lib_t)
     D  obj                                like(obj_t)
     D  typeCode                           like(typeCode_t)
     D  srcLib                             like(lib_t)
     D  srcFile                            like(file_t)
     D  srcMbr                             like(mbr_t)
     D  testLib                            like(lib_t)
     D  testObj                            like(obj_t)
     D  tgtRls                             like(tgtRls_t)
     D  frmSrcLib                          like(lib_t)
     D  frmSrcFile                         like(file_t)
     D  frmSrcMbr                          like(mbr_t)
     D  user0                              like(userParm_t)
     D  user1                              like(userParm_t)
     D  user2                              like(userParm_t)
     D  user3                              like(userParm_t)
     D  user4                              like(userParm_t)
     D  user5                              like(userParm_t)
     D  user6                              like(userParm_t)
     D  user7                              like(userParm_t)
     D  user8                              like(userParm_t)
     D  user9                              like(userParm_t)
     D  libl                               likeds(liblList_t)
     D  usrDefVars                         likeds(usrDefVars_t)
     D  useLibl                            like(bool_t)
     D  prvLibl                            likeds(liblList_t)

      /endif
