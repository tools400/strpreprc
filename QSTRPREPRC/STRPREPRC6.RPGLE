**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : STRPREPRC                                          *
//  Objekt  . . . : STRPREPRC5                                         *
//  Beschreibung  : Start Pre-Processor - IFS Files                    *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 16.03.2022                                         *
//                                                                     *
// =================================================================== *
//                                                                     *
//  This software is free software, you can redistribute it and/or     *
//  modify it under the terms of the GNU General Public License (GPL)  *
//  as published by the Free Software Foundation.                      *
//                                                                     *
//  See GNU General Public License for details.                        *
//          http://www.opensource.org                                  *
//          http://www.opensource.org/licenses/gpl-license.html        *
//                                                                     *
//=====================================================================*
//  History:                                                           *
//                                                                     *
//  Datum       Name          Änderung                                 *
//  ----------  ------------  ---------------------------------------  *
//  26.03.2022  Th.Raddatz    Added stream file support.               *
//                                                                     *
// =================================================================== *
// >>PRE-COMPILER<<                                                    *
//   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
//                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
//   >>IMPORTANT<<                                                     *
//     >>PARM<< TRUNCNBR(*NO);                                         *
//     >>PARM<< DBGVIEW(*LIST);                                        *
//     >>PARM<< OPTION(*EVENTF);                                       *
//   >>END-IMPORTANT<<                                                 *
//   >>EXECUTE<<                                                       *
// >>END-PRE-COMPILER<<                                                *
// =================================================================== *
ctl-opt nomain bnddir('QC2LE');
/copy QSTRPREPRC,H_SPEC
/copy QSTRPREPRC,COPYRIGHT
// =================================================================== *
dcl-ds SRCFILE likeds(hStmf_t) inz(*likeds);
dcl-ds INCLUDE likeds(hStmf_t) inz(*likeds);

// -------------------------------------------------------------
//  Exportierte Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,PSTRPREPR6

// -------------------------------------------------------------
//  Importierte Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,PSTRPREPR2
/copy QBASICS1,PBASICS1
/copy QSTRPREPRC,TYPES_H

// -------------------------------------------------------------
//  Type Templates
// -------------------------------------------------------------
dcl-ds hStmf_t qualified template;
  fd            like(fd_t) inz(-1);
  isFound       ind inz(cFalse);
  readOffset    int(10);
  currLine      likeds(line_t) inz;
  buffSize      int(10) inz(0);
  buffPos       int(10) inz(0);
  readDirection varchar(10) inz;
  folder        like(path_t) inz;
  stmf          like(path_t) inz;
  buffer        char(4096) inz;
  prvLines      likeds(lines_t) inz;
end-ds;

// required for 7.1, because '%elem(io_hStmf.prvLines.line)'
// does not work. (available since 7.3)
dcl-c NUM_LINES 250;

dcl-ds lines_t qualified template;
  i     int(10);
  count int(10) inz;
  line  likeds(line_t) dim(NUM_LINES) inz;
end-ds;

dcl-ds line_t qualified template;
  lineNbr int(10) inz;
  //*startPos                     10i 0 inz
  length  int(10) inz;
  data    like(srcDta_t);
end-ds;

//  Exported only for iRPGUnit unit tests.
//  Must match size of hStmt.buffer.
dcl-s BUFFER_SIZE int(10) inz(4096) export;
// -------------------------------------------------------------
//  Global Fields and Constants
// -------------------------------------------------------------
dcl-c CR x'0D';
dcl-c LF x'25';

dcl-c RD_UNDEFINED '*N';
dcl-c RD_NEXT 'NEXT';
dcl-c RD_PREVIOUS 'PREV';

// =============================================================
//  Opens an given source file.
// =============================================================
dcl-proc SourceStreamFile_open export;
  dcl-pi *n;
    i_stmf like(path_t) const;
  end-pi;

  SRCFILE = IFSSourceStreamFile_open(i_stmf);

end-proc;

// =============================================================
//  Returns the open status of the source file.
// =============================================================
dcl-proc SourceStreamFile_isOpen export;
  dcl-pi *n ind;
  end-pi;

  return IFSSourceStreamFile_isOpen(SRCFILE);


end-proc;

// =============================================================
//  Returns the current line number of the source file.
// =============================================================
dcl-proc SourceStreamFile_getLineNbr export;
  dcl-pi *n int(10);
  end-pi;

  dcl-s lineNbr int(10);

  lineNbr = IFSSourceStreamFile_getLineNbr(SRCFILE);

  return lineNbr;

end-proc;

// =============================================================
//  Returns the length of the data field of the source file.
// =============================================================
dcl-proc SourceStreamFile_getDtaLength export;
  dcl-pi *n int(10);
  end-pi;

  dcl-s lineLength int(10);

  lineLength = IFSSourceStreamFile_getDtaLength(SRCFILE);

  return lineLength;

end-proc;

// =============================================================
//  Returns the folder name of the source file.
// =============================================================
dcl-proc SourceStreamFile_getFolder export;
  dcl-pi *n like(path_t);
  end-pi;

  dcl-s folder like(path_t);

  folder = IFSSourceStreamFile_getFolder(SRCFILE);

  return folder;

end-proc;

// =============================================================
//  Returns the file name of the source file.
// =============================================================
dcl-proc SourceStreamFile_getFile export;
  dcl-pi *n like(path_t);
  end-pi;

  dcl-s file like(path_t);

  file = IFSSourceStreamFile_getFile(SRCFILE);

  return file;

end-proc;

// =============================================================
//  Returns the path (folder + file name) of the source file.
// =============================================================
dcl-proc SourceStreamFile_getPath export;
  dcl-pi *n like(path_t);
  end-pi;

  dcl-s path like(path_t);

  path = IFSSourceStreamFile_getPath(SRCFILE);

  return path;

end-proc;

// =============================================================
//  Reads the next line from the source input file.
// =============================================================
dcl-proc SourceStreamFile_readLine export;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  return IFSSourceStreamFile_readLine(SRCFILE: io_srcDta);

end-proc;

// =============================================================
//  Reads the pervious line from the source input file.
// =============================================================
dcl-proc SourceStreamFile_readPrvLine export;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  return IFSSourceStreamFile_readPrvLine(SRCFILE: io_srcDta);

end-proc;

// =============================================================
//  Closes the source file.
// =============================================================
dcl-proc SourceStreamFile_close export;
  dcl-pi *n;
  end-pi;

  IFSSourceStreamFile_close(SRCFILE);

end-proc;

// =============================================================
//  Opens an given include file.
// =============================================================
dcl-proc IncludeStreamFile_open export;
  dcl-pi *n;
    i_stmf like(path_t) const;
  end-pi;

  INCLUDE = IFSSourceStreamFile_open(i_stmf);

end-proc;

// =============================================================
//  Returns the open status of the include file.
// =============================================================
dcl-proc IncludeStreamFile_isOpen export;
  dcl-pi *n ind;
  end-pi;

  return IFSSourceStreamFile_isOpen(INCLUDE);

end-proc;

// =============================================================
//  Returns the current line number of the include file.
//  Special values:
//   -1   stream file not open
//    0   end of file
// =============================================================
dcl-proc IncludeStreamFile_getLineNbr export;
  dcl-pi *n int(10);
  end-pi;

  return IFSSourceStreamFile_getLineNbr(INCLUDE);

end-proc;

// =============================================================
//  Returns the length of the data field of the include file.
// =============================================================
dcl-proc IncludeStreamFile_getDtaLength export;
  dcl-pi *n int(10);
  end-pi;

  dcl-s lineLength int(10);

  lineLength = IFSSourceStreamFile_getDtaLength(INCLUDE);

  return lineLength;

end-proc;

// =============================================================
//  Returns the folder name of the include file.
// =============================================================
dcl-proc IncludeStreamFile_getFolder export;
  dcl-pi *n like(path_t);
  end-pi;

  dcl-s folder like(path_t);

  folder = IFSSourceStreamFile_getFolder(INCLUDE);

  return folder;

end-proc;

// =============================================================
//  Returns the file name of the include file.
// =============================================================
dcl-proc IncludeStreamFile_getFile export;
  dcl-pi *n like(path_t);
  end-pi;

  dcl-s file like(path_t);

  file = IFSSourceStreamFile_getFile(INCLUDE);

  return file;

end-proc;

// =============================================================
//  Returns the path (folder + file name) of the include file.
// =============================================================
dcl-proc IncludeStreamFile_getPath export;
  dcl-pi *n like(path_t);
  end-pi;

  dcl-s path like(path_t);

  path = IFSSourceStreamFile_getPath(INCLUDE);

  return path;

end-proc;

// =============================================================
//  Reads the next line from the include file.
// =============================================================
dcl-proc IncludeStreamFile_readLine export;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  return IFSSourceStreamFile_readLine(INCLUDE: io_srcDta);

end-proc;

// =============================================================
//  Reads the previous line from the include file.
// =============================================================
dcl-proc IncludeStreamFile_readPrvLine export;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  return IFSSourceStreamFile_readPrvLine(INCLUDE: io_srcDta);

end-proc;

// =============================================================
//  Closes the include file.
// =============================================================
dcl-proc IncludeStreamFile_close export;
  dcl-pi *n;
  end-pi;

  IFSSourceStreamFile_close(INCLUDE);

end-proc;

// =============================================================
//  Opens a given QSYS file.
// =============================================================
dcl-proc IFSSourceStreamFile_open;
  dcl-pi *n likeds(hStmf_t);
    i_stmf like(path_t) options(*trim) const;
  end-pi;

  dcl-ds hStmf likeds(hStmf_t) inz;
  dcl-s fd like(fd_t);
  dcl-s errorNbr int(10);
  dcl-s errorText like(cErrorText_t);

  //  ... Datei &1 kann nicht geöffnet werden.
/copy QSTRPREPRC,PRZ0041

  reset hStmf;
  hStmf.fd = cERROR;

  fd = open(i_stmf: O_RDONLY + O_TEXTDATA + O_CCSID: 0: 0);

  if (fd < 0);
    errorNbr = C_getError(errorText);
    clear PRZ0041;
    PRZ00411 = i_stmf;
    PRZ00412 = %char(errorNbr);
    PRZ00413 = errorText;
    sendMsg(f_newMsg('PRZ0041': PRZ0041: cTYPE_DIAG));
    endAbnormal();
  endif;

  hStmf.fd = fd;
  hStmf.readDirection = RD_UNDEFINED;
  hStmf.folder = Path_getFolder(i_stmf);
  hStmf.stmf = Path_getFile(i_stmf);

  return hStmf;

end-proc;

// =============================================================
//  Returns the length of the data field of a IFS source file.
// =============================================================
dcl-proc IFSSourceStreamFile_isOpen;
  dcl-pi *n ind;
    i_hStmf likeds(hStmf_t) const;
  end-pi;

  if (i_hStmf.fd = cERROR);
    return cFalse;
  else;
    return cTrue;
  endif;

end-proc;

// =============================================================
//  Returns the current line number of a IFS source file.
// =============================================================
dcl-proc IFSSourceStreamFile_getLineNbr;
  dcl-pi *n int(10);
    i_hStmf likeds(hStmf_t) const;
  end-pi;

  dcl-s lineNbr int(10);

  if (not IFSSourceStreamFile_isOpen(i_hStmf));
    return -1;
  endif;

  if (not i_hStmf.isFound);
    return 0;
  endif;

  select;
  when (i_hStmf.readDirection = RD_NEXT);
    lineNbr = i_hStmf.currLine.lineNbr;
  when (i_hStmf.readDirection = RD_PREVIOUS);
    return i_hStmf.prvLines.line(i_hStmf.prvLines.i).lineNbr;
  other;
    // read direction is undefined
    return 0;
  endsl;

  return lineNbr;

end-proc;

// =============================================================
//  Returns the length of the data field of a IFS source file.
// =============================================================
dcl-proc IFSSourceStreamFile_getDtaLength;
  dcl-pi *n int(10);
    i_hStmf likeds(hStmf_t) const;
  end-pi;

  if (not i_hStmf.isFound);
    return 0;
  endif;

  select;
  when (i_hStmf.readDirection = RD_NEXT);
    return i_hStmf.currLine.length;
  when (i_hStmf.readDirection = RD_PREVIOUS);
    return i_hStmf.prvLines.line(i_hStmf.prvLines.i).length;
  other;
    // read direction is undefined
    return 0;
  endsl;

end-proc;

// =============================================================
//  Returns the library name of a given IFS source file.
// =============================================================
dcl-proc IFSSourceStreamFile_getFolder;
  dcl-pi *n like(path_t);
    i_hStmf likeds(hStmf_t) const;
  end-pi;

  return i_hStmf.folder;

end-proc;

// =============================================================
//  Returns the file name of a given IFS source file.
// =============================================================
dcl-proc IFSSourceStreamFile_getFile;
  dcl-pi *n like(path_t);
    i_hStmf likeds(hStmf_t) const;
  end-pi;


  return i_hStmf.stmf;

end-proc;

// =============================================================
//  Returns the path (folder + file name) of a given IFS source file.
// =============================================================
dcl-proc IFSSourceStreamFile_getPath;
  dcl-pi *n like(path_t);
    i_hStmf likeds(hStmf_t) const;
  end-pi;


  if (f_endsWith('/': i_hStmf.folder));
    return i_hStmf.folder + i_hStmf.stmf;
  else;
    return i_hStmf.folder + '/' + i_hStmf.stmf;
  endif;

end-proc;


// =============================================================
//  Reads a line of a given IFS source file.
//  Linefeed rules:
//    LF   - line feed
//    CR   - line feed
//    CRLF - line feed
//    LFCR - two line feeds (second one is an empty line)
//  This line feed rules are the rules used by Notepad++.
// =============================================================
dcl-proc IFSSourceStreamFile_readLine;
  dcl-pi *n ind;
    io_hStmf  likeds(hStmf_t);
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  dcl-s bytes int(10);
  dcl-s char char(1);
  dcl-s isFound ind;

  // line must match the size of ds_srcFile_t.srcDta
  dcl-s line varchar(244);
  dcl-s linefeed varchar(1);
  dcl-ds prvCurrLine likeds(line_t);
  dcl-s i int(10);

  //  ... MSG: Die Datensatzlänge der IFS Datei ist zu lang.
/copy QSTRPREPRC,PRZ0042

  io_srcDta = '';
  isFound = cFalse;

  if (io_hStmf.readDirection <> RD_NEXT);
    io_hStmf.readDirection = RD_NEXT;
  endif;

  line = '';
  linefeed = '';

  prvCurrLine = io_hStmf.currLine;

  if (io_hStmf.prvLines.i > 0);

    io_hStmf.prvLines.i -= 1;

    if (io_hStmf.prvLines.i > 0);
      io_srcDta = io_hStmf.prvLines.line(io_hStmf.prvLines.i).data;
    else;
      io_srcDta = io_hStmf.currLine.data;
    endif;

    isFound = cTrue;

    return isFound;
  endif;

  dow '1';

    if (io_hStmf.buffPos > io_hStmf.buffSize);
      // buffer exhausted, clear buffer
      io_hStmf.buffSize = 0;
      io_hStmf.buffPos = 0;
    endif;

    // load buffer, if empty
    if (io_hStmf.buffSize = 0);
      bytes = read(io_hStmf.fd: %addr(io_hStmf.buffer): BUFFER_SIZE);
      if (bytes > 0);
        io_hStmf.buffSize = bytes;
        io_hStmf.buffPos = 1;
      else;
        // EOF, clear buffer
        io_hStmf.buffSize = 0;
        io_hStmf.buffPos = 0;
      endif;
    endif;

    if (io_hStmf.buffSize = 0);
      leave;
    endif;

    isFound = cTrue;

    char = %subst(io_hStmf.buffer: io_hStmf.buffPos: 1);

    if (char = CR or char = LF);
      // consume up to 2 linefeed characters:
      // LF, CR, CRlf and LFCR
      select;
      when (%len(linefeed) = 0);
        linefeed = linefeed + char;
        io_hStmf.buffPos += 1; // consume character
        io_hStmf.readOffset += 1;
        if (char = LF);
          leave; // return line due to the first LF character
        endif;
      when (%len(linefeed) = 1 and char <> linefeed);
        linefeed = linefeed + char;
        io_hStmf.buffPos += 1; // consume character
        io_hStmf.readOffset += 1;
        leave; // return line due to a 2-byte CRLF line ending
      other;
        leave; // return line due more than 2 linefeeds characters in a row
      endsl;
    else;
      if (linefeed <> '');
        leave; // return line due to a 1-char CR linefeed
      else;
        line = line + char;
        io_hStmf.buffPos += 1; // consume character
        io_hStmf.readOffset += 1;
      endif;
    endif;

  enddo;

  if (isFound);

    // Check record length
    if (%len(line) > MAX_RCD_LEN);
      clear PRZ0042;
      PRZ00421 = %len(line);
      PRZ00422 = MAX_RCD_LEN;
      PRZ00423 = IFSSourceStreamFile_getFolder(io_hStmf);
      PRZ00424 = IFSSourceStreamFile_getFile(io_hStmf);
      sendMsg(f_newMsg('PRZ0042': PRZ0042: cTYPE_DIAG));
      endAbnormal();
    endif;

    if (io_hStmf.currLine.lineNbr > 0);
      for i = io_hStmf.prvLines.count downto 2;
        io_hStmf.prvLines.line(i) = io_hStmf.prvLines.line(i - 1);
      endfor;

      if (io_hStmf.prvLines.count < NUM_LINES);
        io_hStmf.prvLines.count += 1;
      endif;

      io_hStmf.prvLines.line(1) = prvCurrLine;
    endif;

    // io_hStmf.currLine.startPos = io_hStmf.readOffset
    //                              - %len(line) - %len(lineFeed) + 1;
    io_hStmf.currLine.lineNbr += 1;
    io_hStmf.currLine.length = %len(line);
    io_hStmf.currLine.data = line;
  endif;

  io_hStmf.isFound = isFound;
  io_srcDta = line;

  return isFound;

end-proc;

// =============================================================
//  Reads the previous line of a given IFS source file.
// =============================================================
dcl-proc IFSSourceStreamFile_readPrvLine;
  dcl-pi *n ind;
    io_hStmf  likeds(hStmf_t);
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  dcl-s isFound ind;

  io_srcDta = '';
  isFound = cFalse;

  if (io_hStmf.readDirection <> RD_PREVIOUS);
    io_hStmf.readDirection = RD_PREVIOUS;
  endif;

  if (io_hStmf.prvLines.i <= io_hStmf.prvLines.count);

    io_hStmf.prvLines.i += 1;

    if (io_hStmf.prvLines.i <= io_hStmf.prvLines.count);
      io_srcDta = io_hStmf.prvLines.line(io_hStmf.prvLines.i).data;
      isFound = cTrue;
    endif;

  endif;

  io_hStmf.isFound = isFound;

  return isFound;

end-proc;

// =============================================================
//  Closes a given IFS source file.
// =============================================================
dcl-proc IFSSourceStreamFile_close;
  dcl-pi *n;
    io_hStmf likeds(hStmf_t);
  end-pi;

  dcl-ds hStmf likeds(io_hStmf);

  if (not IFSSourceStreamFile_isOpen(io_hStmf));
    return;
  endif;

  callp close(io_hStmf.fd);

  reset hStmf;
  hStmf.fd = cERROR;
  hStmf.readDirection = RD_UNDEFINED;

  io_hStmf = hStmf;

end-proc;

// =============================================================
//  Returns the folder name of a given path.
// =============================================================
dcl-proc Path_getFolder export;
  dcl-pi *n like(path_t);
    i_path like(path_t) options(*trim) const;
  end-pi;

  dcl-s folder like(path_t);
  dcl-s x int(10);
  dcl-s y int(10);
  dcl-s length int(10);

  if (isDirectory(i_path));
    // ... then it does not contain a file name
    folder = i_path;
  else;
    // ... else search for the last delimiter of the path
    for x = 1 to %len(i_path);
      y = %scan(%subst(i_path: x: 1): cDELIMITER);
      if (y > 0);
        length = x;
      endif;
    endfor;
    if (length > 0);
      folder = %subst(i_path: 1: length);
    endif;
  endif;

  folder = f_replace('\': '/': folder);

  return folder;

end-proc;

// =============================================================
//  Returns the file name of a given path.
// =============================================================
dcl-proc Path_getFile export;
  dcl-pi *n like(path_t);
    i_path like(path_t) options(*trim) const;
  end-pi;

  dcl-s fileName like(path_t);

  dcl-s pToken pointer inz;
  dcl-s token like(fileName) inz;

  if (isDirectory(i_path));
    // ... then it does not contain a file name
    fileName = '';
  else;
    // ... else search for the last token of the path
    pToken = strtok(i_path: cDELIMITER);
    dow (pToken <> *NULL);
      token  = %str(pToken);
      pToken = strtok(*NULL: cDELIMITER);
    enddo;

    fileName = token;
  endif;

  fileName = f_replace('\': '/': fileName);

  return fileName;

end-proc;

// =============================================================
//  Returns cTrue, of a given path is a folder.
// =============================================================
dcl-proc isDirectory;
  dcl-pi *n ind;
    i_path like(path_t) const;
  end-pi;

  if (f_endsWith(cSLASH: i_path) or f_endsWith(cBACKSLASH: i_path));
    return cTrue;
  else;
    return cFalse;
  endif;

end-proc;

// =============================================================
//  Returns the last C error.
// =============================================================
dcl-proc C_getError;
  dcl-pi *n int(10);
    o_errorText like(cErrorText_t) options(*nopass);
  end-pi;

  dcl-s errorNbr int(10) based(pErrorNbr);
  dcl-s pErrorText pointer;
  dcl-s errorText char(128);

  //  erno--Set Pointer to Runtime Error Code
  dcl-pr errno pointer extproc('__errno');
  end-pr;

  //  strerror -- Set Pointer to Runtime Error Message
  dcl-pr strerror pointer extproc('strerror');
    errno int(10) value;
  end-pr;

  pErrorNbr = errno();
  if (errorNbr <> 0);
    pErrorText = strerror(errorNbr);
    if (pErrorText <> *null);
      errorText = %str(pErrorText);
    endif;
  endif;

  if (%parms() >= %parmnum(o_errorText));
    o_errorText = errorText;
  endif;

  return errorNbr;

end-proc;

//===============================================================*
//  Check existence of a stream file.
//===============================================================*
dcl-proc StreamFile_exists export;
  dcl-pi *n;
    i_stmf like(path_t) options(*trim) const;
  end-pi;

  dcl-s rc int(10);

  dcl-ds st_stat likeds(st_stat_t);

  //  Nachrichten
  //  ... Bibliothek &1 nicht gefunden.
/copy QSTRPREPRC,PRZ0043

  rc = stat(i_stmf: %addr(st_stat));
  if (rc <> 0);
    clear PRZ0043;
    PRZ00431 = i_stmf;
    sendMsg(f_newMsg('PRZ0043': PRZ0043: cTYPE_ESCAPE));
  endif;

end-proc;

