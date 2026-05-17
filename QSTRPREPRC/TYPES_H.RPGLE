**free
/if not defined(types_h)
/define types_h

/include QBASICS1,FDMSG
/include QBASICS1,FDQOBJ

// must be equal to size of srcDta_t
dcl-c MAX_RCD_LEN 244;

dcl-c cERROR -1;

dcl-c cTYPE_DIAG '*DIAG';
dcl-c cTYPE_ESCAPE '*ESCAPE';

dcl-c cBACKSLASH '\';
dcl-c cSLASH '/';
dcl-c cDELIMITER ':/\';

dcl-s int4_t int(10) template;
dcl-s cmd_t char(8192) template;
dcl-s cmdLong_t varchar(32702) template;
dcl-s cmdLongFixLen_t char(32702) template;
dcl-s bool_t ind template;
dcl-s mode_t char(30) template;
dcl-s module_t char(10) template;
dcl-s pgm_t char(10) template;
dcl-s proc_t char(64) template;
dcl-s tag_t char(30) template;
dcl-s continue_t char(1) template;
dcl-s keyData_t varchar(4096) template;
dcl-s obj_t char(10) template;
dcl-s tgtRls_t char(10) template;
dcl-s typeCode_t char(6) template;
dcl-s userParm_t char(50) template;
dcl-s chgObjD_t char(4) template;
dcl-s objType_t char(10) template;
dcl-s cErrorText_t varchar(128) template;

dcl-s file_t char(10) template;
dcl-s lib_t char(10) template;
dcl-s mbr_t char(10) template;
dcl-s path_t varchar(4096) template;
dcl-s fd_t int(10) template;

dcl-s srcSeq_t zoned(6: 2) template;
dcl-s srcDat_t zoned(6) template;
dcl-s srcDta_t char(244) template;

dcl-ds ds_srcFile_t qualified template;
  srcSeq like(srcSeq_t);
  srcDat like(srcDat_t);
  srcDta like(srcDta_t);
end-ds;

dcl-c DIM_OPTIONS 5;

dcl-ds option_t template qualified;
  numE   int(5);
  option char(10) dim(DIM_OPTIONS);
end-ds;

dcl-c DIM_USRDEFVARS 20;

dcl-ds inpUsrDefVars_t len(2282) qualified template;
  numElem   int(5);
  offsItems int(5) dim(DIM_USRDEFVARS);
end-ds;

dcl-ds inpUsrDefVar_t qualified template;
  numE  int(5);
  name  char(10);
  value char(100);
end-ds;

dcl-c DIM_EXECOPTS 3;

dcl-ds execOpt_t qualified template;
  numElem int(5);
  execOpt char(10) dim(DIM_EXECOPTS);
end-ds;

dcl-c DIM_LIBLIST 250;

dcl-ds inpLibList_t qualified template;
  numElem     int(5);
  curLib      char(10);
  offsUsrLibl int(5);
  numUsrLiblE int(5);
  lib         char(10) dim(DIM_LIBLIST);
end-ds;

dcl-ds libl_t qualified template;
  numE int(5);
  name like(lib_t) dim(DIM_LIBLIST);
end-ds;

dcl-ds liblList_t qualified template;
  curLib  like(lib_t);
  usrLibl likeds(libl_t);
end-ds;

dcl-ds usrDefVars_t qualified template;
  numE int(5);
  var  likeds(usrDefVar_t) dim(DIM_USRDEFVARS);
end-ds;

dcl-ds usrDefVar_t qualified template;
  name  char(10);
  value char(100);
end-ds;

dcl-ds lineData_t qualified template;
  continue like(continue_t);
  keyData  like(keyData_t);
end-ds;

dcl-ds monMsgIds_t qualified template;
  item like(msgId_t) dim(50);
end-ds;

dcl-ds variables_t qualified template;
  lib        like(lib_t);
  obj        like(obj_t);
  typeCode   like(typeCode_t);
  srcLib     like(lib_t);
  srcFile    like(file_t);
  srcMbr     like(mbr_t);
  testLib    like(lib_t);
  testObj    like(obj_t);
  tgtRls     like(tgtRls_t);
  frmSrcLib  like(lib_t);
  frmSrcFile like(file_t);
  frmSrcMbr  like(mbr_t);
  user0      like(userParm_t);
  user1      like(userParm_t);
  user2      like(userParm_t);
  user3      like(userParm_t);
  user4      like(userParm_t);
  user5      like(userParm_t);
  user6      like(userParm_t);
  user7      like(userParm_t);
  user8      like(userParm_t);
  user9      like(userParm_t);
  stmf       like(path_t);
  folder     like(path_t);
  file       like(path_t);
  libl       likeds(liblList_t);
  usrDefVars likeds(usrDefVars_t);
  useLibl    like(bool_t);
  prvLibl    likeds(liblList_t);
end-ds;

dcl-s rnf7031_t varchar(10) template;
/endif
