**free
/if defined(PSTRPREPR6)
/eof
/endif
/define PSTRPREPR6

/copy QSTRPREPRC,TYPES_H

//  Opens an given source file.
dcl-pr SourceStreamFile_open extproc('STRPREPRC6_SourceStreamFile_open');
  i_stmf like(path_t) const;
end-pr;

//  Returns the open status of the source file.
dcl-pr SourceStreamFile_isOpen ind extproc('STRPREPRC6_SourceStreamFile_isOpen');
end-pr;

//  Returns the current line number of the source file.
dcl-pr SourceStreamFile_getLineNbr int(10) extproc('STRPREPRC6_SourceStreamFile_getLineNbr');
end-pr;

//  Returns the length of the data field of the source file.

dcl-pr SourceStreamFile_getDtaLength int(10) extproc('STRPREPRC6_SourceStreamFile_getDtaLength');
end-pr;

//  Returns the folder name of the source file.
dcl-pr SourceStreamFile_getFolder like(path_t) extproc('STRPREPRC6_SourceStreamFile_getFolder');
end-pr;

//  Returns the file name of the source file.
dcl-pr SourceStreamFile_getFile like(path_t) extproc('STRPREPRC6_SourceStreamFile_getFile');
end-pr;

//  Returns the path (folder + file name) of the source file.
dcl-pr SourceStreamFile_getPath like(path_t) extproc('STRPREPRC6_SourceStreamFile_getPath');
end-pr;

//  Reads the next line from the source file.
dcl-pr SourceStreamFile_readLine ind extproc('STRPREPRC6_SourceStreamFile_readLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

//  Reads the previous line from the source file.
dcl-pr SourceStreamFile_readPrvLine ind extproc('STRPREPRC6_SourceStreamFile_readPrvLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

//  Closes the source file.
dcl-pr SourceStreamFile_close extproc('STRPREPRC6_SourceStreamFile_close');
end-pr;

//  Opens an given include file.
dcl-pr IncludeStreamFile_open extproc('STRPREPRC6_IncludeStreamFile_open');
  i_stmf like(path_t) const;
end-pr;

//  Returns the open status of the include file.
dcl-pr IncludeStreamFile_isOpen ind extproc('STRPREPRC6_IncludeStreamFile_isOpen');
end-pr;

//  Returns the current line number of the include file.
dcl-pr IncludeStreamFile_getLineNbr int(10) extproc('STRPREPRC6_IncludeStreamFile_getLineNbr');
end-pr;

//  Returns the length of the data field of the include file.

dcl-pr IncludeStreamFile_getDtaLength int(10) extproc('STRPREPRC6_IncludeStreamFile_getDtaLength');
end-pr;

//  Returns the folder name of the include file.
dcl-pr IncludeStreamFile_getFolder like(path_t) extproc('STRPREPRC6_IncludeStreamFile_getFolder');
end-pr;

//  Returns the file name of the include file.
dcl-pr IncludeStreamFile_getFile like(path_t) extproc('STRPREPRC6_IncludeStreamFile_getFile');
end-pr;

//  Returns the path (folder + file name) of the include file.
dcl-pr IncludeStreamFile_getPath like(path_t) extproc('STRPREPRC6_IncludeStreamFile_getPath');
end-pr;

//  Reads the next line from the include file.
dcl-pr IncludeStreamFile_readLine ind extproc('STRPREPRC6_IncludeStreamFile_readLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

//  Reads the previous line from the include file.
dcl-pr IncludeStreamFile_readPrvLine ind extproc('STRPREPRC6_IncludeStreamFile_readPrvLine');
  io_srcDta like(ds_srcFile_t.srcDta);
end-pr;

//  Closes the include file.
dcl-pr IncludeStreamFile_close extproc('STRPREPRC6_IncludeStreamFile_close');
end-pr;

//  Returns the folder name of a given path.
dcl-pr Path_getFolder like(path_t) extproc('STRPREPRC6_Path_getFolder');
  i_path like(path_t) options(*trim) const;
end-pr;

//  Returns the file name of a given path.
dcl-pr Path_getFile like(path_t) extproc('STRPREPRC6_Path_getFile');
  i_path like(path_t) options(*trim) const;
end-pr;

//  Check existence of a stream file.
dcl-pr StreamFile_exists extproc('STRPREPRC6_StreamFile_exists');
  i_stmf like(path_t) options(*trim) const;
end-pr;

