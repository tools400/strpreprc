      /if defined(PSTRPREPR6)
      /eof
      /endif
      /define PSTRPREPR6

      /copy QSTRPREPRC,TYPES_H

      *  Opens an given source file.
     D SourceStreamFile_open...
     D                 pr
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_open+
     D                                     ')
     D  i_stmf                             const  like(path_t)

      *  Returns the open status of the source file.
     D SourceStreamFile_isOpen...
     D                 pr              n
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_isOpen+
     D                                     ')

      *  Returns the current line number of the source file.
     D SourceStreamFile_getLineNbr...
     D                 pr            10i 0
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_getLineNbr+
     D                                     ')

      *  Returns the length of the data field of the source file.
     D SourceStreamFile_getDtaLength...
     D
     D                 pr            10i 0
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_getDtaLength+
     D                                     ')

      *  Returns the folder name of the source file.
     D SourceStreamFile_getFolder...
     D                 pr                  like(path_t)
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_getFolder+
     D                                     ')

      *  Returns the file name of the source file.
     D SourceStreamFile_getFile...
     D                 pr                  like(path_t)
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_getFile+
     D                                     ')

      *  Returns the path (folder + file name) of the source file.
     D SourceStreamFile_getPath...
     D                 pr                  like(path_t)
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_getPath+
     D                                     ')

      *  Reads the next line from the source file.
     D SourceStreamFile_readLine...
     D                 pr              n
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_readLine+
     D                                     ')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

      *  Reads the previous line from the source file.
     D SourceStreamFile_readPrvLine...
     D                 pr              n
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_readPrvLine+
     D                                     ')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

      *  Closes the source file.
     D SourceStreamFile_close...
     D                 pr
     D                                     extproc('STRPREPRC6_+
     D                                     SourceStreamFile_close+
     D                                     ')

      *  Opens an given include file.
     D IncludeStreamFile_open...
     D                 pr
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_open+
     D                                     ')
     D  i_stmf                             const  like(path_t)

      *  Returns the open status of the include file.
     D IncludeStreamFile_isOpen...
     D                 pr              n
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_isOpen+
     D                                     ')

      *  Returns the current line number of the include file.
     D IncludeStreamFile_getLineNbr...
     D                 pr            10i 0
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_getLineNbr+
     D                                     ')

      *  Returns the length of the data field of the include file.
     D IncludeStreamFile_getDtaLength...
     D
     D                 pr            10i 0
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_getDtaLength+
     D                                     ')

      *  Returns the folder name of the include file.
     D IncludeStreamFile_getFolder...
     D                 pr                  like(path_t)
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_getFolder+
     D                                     ')

      *  Returns the file name of the include file.
     D IncludeStreamFile_getFile...
     D                 pr                  like(path_t)
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_getFile+
     D                                     ')

      *  Returns the path (folder + file name) of the include file.
     D IncludeStreamFile_getPath...
     D                 pr                  like(path_t)
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_getPath+
     D                                     ')

      *  Reads the next line from the include file.
     D IncludeStreamFile_readLine...
     D                 pr              n
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_readLine+
     D                                     ')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

      *  Reads the previous line from the include file.
     D IncludeStreamFile_readPrvLine...
     D                 pr              n
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_readPrvLine+
     D                                     ')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

      *  Closes the include file.
     D IncludeStreamFile_close...
     D                 pr
     D                                     extproc('STRPREPRC6_+
     D                                     IncludeStreamFile_close+
     D                                     ')

      *  Returns the folder name of a given path.
     D Path_getFolder...
     D                 pr                  like(path_t)
     D                                     extproc('STRPREPRC6_+
     D                                     Path_getFolder+
     D                                     ')
     D  i_path                             const like(path_t) options(*trim)

      *  Returns the file name of a given path.
     D Path_getFile...
     D                 pr                  like(path_t)
     D                                     extproc('STRPREPRC6_+
     D                                     Path_getFile+
     D                                     ')
     D  i_path                             const  like(path_t) options(*trim)

      *  Check existence of a stream file.
     D StreamFile_exists...
     D                 pr
     D                                     extproc('STRPREPRC6_+
     D                                     StreamFile_exists+
     D                                     ')
     D  i_stmf                             const  like(path_t) options(*trim)

