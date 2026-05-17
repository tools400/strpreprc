**free
/if not defined(QMHRMVPM)
/define QMHRMVPM

//  Remove Program Message (QMHRMVPM) API
dcl-pr QMHRMVPM extpgm('QMHRMVPM');
  i_callStackE  char(10) const;
  i_callStackC  int(10) const;
  i_msgKey      char(4) const;
  i_msgToRmv    char(10) const;
  i_errCode     char(32767) options(*varsize);
  i_lenCalStkE  int(10) options(*nopass);
  i_calStkEQual char(20) options(*nopass);
  i_rmvExcp     char(10) options(*nopass);
  i_calStkeDTyp char(10) options(*nopass);
end-pr;
/endif
