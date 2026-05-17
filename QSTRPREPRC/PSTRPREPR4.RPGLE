**free
/if defined(PSTRPREPR4)
/eof
/endif
/define PSTRPREPR4

dcl-pr enableEventFile extproc('STRPREPRC4_enableEventFile');
end-pr;

dcl-pr isEmptyEventFile ind extproc('STRPREPRC4_isEmptyEventFile');
  i_lib char(10) const;
  i_obj char(10) const;
end-pr;

dcl-pr clearEventFile extproc('STRPREPRC4_clearEventFile');
  i_obj char(10) const;
  i_lib char(10) const;
end-pr;

dcl-pr prepareEventFile extproc('STRPREPRC4_prepareEventFile');
end-pr;

dcl-pr openEventFile ind extproc('STRPREPRC4_openEventFile');
  i_obj    char(10) const;
  i_lib    char(10) const;
  i_append ind const;
end-pr;

dcl-pr updateLDA extproc('STRPREPRC4_updateLDA');
  i_lib char(10) const;
  i_obj char(10) const;
end-pr;

dcl-pr writeEventFile extproc('STRPREPRC4_writeEventFile');
  i_srcFile    like(path_t) const;
  i_srcLib     char(10) const;
  i_srcMbr     char(10) const;
  i_lineNumber int(10) const;
  i_isAbnEnd   ind const;
end-pr;

dcl-pr closeEventFile extproc('STRPREPRC4_closeEventFile');
end-pr;

dcl-pr copyEventFile extproc('STRPREPRC4_copyEventFile');
  i_fromLib char(10) const;
  i_fromMbr char(10) const;
  i_toLib   char(10) const;
  i_toMbr   char(10) const;
end-pr;

