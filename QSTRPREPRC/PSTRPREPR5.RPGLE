      /if defined(PSTRPREPR5)
      /eof
      /endif
      /define PSTRPREPR5

      *  Opens an given source file.
     D SourceFile_open...
     D                 pr
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_open+
     D                                     ')
     D  i_lib                              const  like(lib_t)
     D  i_file                             const  like(file_t)
     D  i_mbr                              const  like(mbr_t)

      *  Returns the open status of the source file.
     D SourceFile_isOpen...
     D                 pr              n
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_isOpen+
     D                                     ')

      *  Returns the current line number of the source file.
     D SourceFile_getLineNbr...
     D                 pr            10i 0
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_getLineNbr+
     D                                     ')

      *  Returns the length of the data field of the source file.
     D SourceFile_getDtaLength...
     D
     D                 pr            10i 0
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_getDtaLength+
     D                                     ')

      *  Returns the library name of the source file.
     D SourceFile_getLibrary...
     D                 pr            10a
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_getLibrary+
     D                                     ')

      *  Returns the file name of the source file.
     D SourceFile_getFile...
     D                 pr            10a
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_getFile+
     D                                     ')

      *  Returns the member name of the source file.
     D SourceFile_getMember...
     D                 pr            10a
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_getMember+
     D                                     ')

      *  Reads the next line from the source file.
     D SourceFile_readLine...
     D                 pr              n
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_readLine+
     D                                     ')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

      *  Reads the previous line from the source file.
     D SourceFile_readPrvLine...
     D                 pr              n
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_readPrvLine+
     D                                     ')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

      *  Closes the source file.
     D SourceFile_close...
     D                 pr
     D                                     extproc('STRPREPRC5_+
     D                                     SourceFile_close+
     D                                     ')

      *  Opens an given include file.
     D IncludeFile_open...
     D                 pr
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_open+
     D                                     ')
     D  i_lib                              const  like(lib_t)
     D  i_file                             const  like(file_t)
     D  i_mbr                              const  like(mbr_t)

      *  Returns the open status of the include file.
     D IncludeFile_isOpen...
     D                 pr              n
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_isOpen+
     D                                     ')

      *  Returns the current line number of the include file.
     D IncludeFile_getLineNbr...
     D                 pr            10i 0
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_getLineNbr+
     D                                     ')

      *  Returns the length of the data field of the include file.
     D IncludeFile_getDtaLength...
     D
     D                 pr            10i 0
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_getDtaLength+
     D                                     ')

      *  Returns the library name of the include file.
     D IncludeFile_getLibrary...
     D                 pr            10a
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_getLibrary+
     D                                     ')

      *  Returns the file name of the include file.
     D IncludeFile_getFile...
     D                 pr            10a
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_getFile+
     D                                     ')

      *  Returns the member name of the include file.
     D IncludeFile_getMember...
     D                 pr            10a
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_getMember+
     D                                     ')

      *  Reads the next line from the include file.
     D IncludeFile_readLine...
     D                 pr              n
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_readLine+
     D                                     ')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

      *  Reads the previous line from the include file.
     D IncludeFile_readPrvLine...
     D                 pr              n
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_readPrvLine+
     D                                     ')
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

      *  Closes the include file.
     D IncludeFile_close...
     D                 pr
     D                                     extproc('STRPREPRC5_+
     D                                     IncludeFile_close+
     D                                     ')

