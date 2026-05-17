**free
/if defined(PSTRPREPR5)
/eof
/endif
/define PSTRPREPR5

//  Opens an given source file.
dcl-pr SourceFile_open extproc('STRPREPRC5_SourceFile_open');
  i_lib  like(lib_t) const;
  i_file like(file_t) const;
  i_mbr  like(mbr_t) const;
end-pr;

//  Returns the open status of the source file.
dcl-pr SourceFile_isOpen ind extproc('STRPREPRC5_SourceFile_isOpen');
end-pr;

//  Returns the current line number of the source file.
dcl-pr SourceFile_getLineNbr int(10) extproc('STRPREPRC5_SourceFile_getLineNbr');
end-pr;

//  Returns the length of the data field of the source file.

dcl-pr SourceFile_getDtaLength int(10) extproc('STRPREPRC5_SourceFile_getDtaLength');
end-pr;

//  Returns the library name of the source file.
dcl-pr SourceFile_getLibrary char(10) extproc('STRPREPRC5_SourceFile_getLibrary');
end-pr;

//  Returns the file name of the source file.
dcl-pr SourceFile_getFile char(10) extproc('STRPREPRC5_SourceFile_getFile');
end-pr;

//  Returns the member name of the source file.
dcl-pr SourceFile_getMember char(10) extproc('STRPREPRC5_SourceFile_getMember');
end-pr;

//  Reads the next line from the source file.
dcl-pr SourceFile_readLine ind extproc('STRPREPRC5_SourceFile_readLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

//  Reads the previous line from the source file.
dcl-pr SourceFile_readPrvLine ind extproc('STRPREPRC5_SourceFile_readPrvLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

//  Closes the source file.
dcl-pr SourceFile_close extproc('STRPREPRC5_SourceFile_close');
end-pr;

//  Opens an given include file.
dcl-pr IncludeFile_open extproc('STRPREPRC5_IncludeFile_open');
  i_lib  like(lib_t) const;
  i_file like(file_t) const;
  i_mbr  like(mbr_t) const;
end-pr;

//  Returns the open status of the include file.
dcl-pr IncludeFile_isOpen ind extproc('STRPREPRC5_IncludeFile_isOpen');
end-pr;

//  Returns the current line number of the include file.
dcl-pr IncludeFile_getLineNbr int(10) extproc('STRPREPRC5_IncludeFile_getLineNbr');
end-pr;

//  Returns the length of the data field of the include file.

dcl-pr IncludeFile_getDtaLength int(10) extproc('STRPREPRC5_IncludeFile_getDtaLength');
end-pr;

//  Returns the library name of the include file.
dcl-pr IncludeFile_getLibrary char(10) extproc('STRPREPRC5_IncludeFile_getLibrary');
end-pr;

//  Returns the file name of the include file.
dcl-pr IncludeFile_getFile char(10) extproc('STRPREPRC5_IncludeFile_getFile');
end-pr;

//  Returns the member name of the include file.
dcl-pr IncludeFile_getMember char(10) extproc('STRPREPRC5_IncludeFile_getMember');
end-pr;

//  Reads the next line from the include file.
dcl-pr IncludeFile_readLine ind extproc('STRPREPRC5_IncludeFile_readLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

//  Reads the previous line from the include file.
dcl-pr IncludeFile_readPrvLine ind extproc('STRPREPRC5_IncludeFile_readPrvLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

//  Closes the include file.
dcl-pr IncludeFile_close extproc('STRPREPRC5_IncludeFile_close');
end-pr;

