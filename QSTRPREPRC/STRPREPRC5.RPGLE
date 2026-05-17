**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : STRPREPRC                                          *
//  Objekt  . . . : STRPREPRC5                                         *
//  Beschreibung  : Start Pre-Processor - QSYS Files                   *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 15.03.2022                                         *
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
//  21.03.2022  Th.Raddatz    Added Member_exists().                   *
//                                                                     *
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
dcl-f SRCFILE_t disk(256) template block(*no);

// -------------------------------------------------------------
//  Verwendete Dateien
// -------------------------------------------------------------
dcl-f SRCFILE likefile(SRCFILE_t) extfile(g_useSrcFile.name) extmbr(g_useSrcFile.member) infds(f1)
  usropn;

dcl-f INCLUDE likefile(SRCFILE_t) extfile(g_useSrcFile.name) extmbr(g_useSrcFile.member) infds(f2)
  usropn;
//                                    extfile(g_include.name)
//                                    extmbr(g_include.member)

dcl-ds g_useSrcFile qualified inz;
  name   varchar(21);
  member varchar(10);
end-ds;

dcl-s f1_srcDtaLen int(10);

dcl-s f1_line_number int(10) inz(-1);

dcl-ds f1 likeds(fileStatus_t);

dcl-s f2_line_number int(10) inz(-1);

dcl-ds f2 likeds(fileStatus_t);

// -------------------------------------------------------------
//  Type Templates
// -------------------------------------------------------------
dcl-ds fileStatus_t qualified template;
  status   zoned(5) pos(11);
  file     char(10) pos(83);
  lib      char(10);
  rcdLen   bindec(4) pos(125);
  mbr      char(10) pos(129);
  nbrOfKey bindec(4) pos(387);
  rcdNbr   bindec(9) pos(397);
end-ds;

// -------------------------------------------------------------
//  Exportierte Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,PSTRPREPR5

// -------------------------------------------------------------
//  Importierte Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,PSTRPREPR2
/copy QBASICS1,PBASICS1
/copy QSTRPREPRC,TYPES_H
/copy QSTRPREPRC,QMHRCVPM
/copy QSTRPREPRC,QMHRMVPM

// -------------------------------------------------------------
//  Globale Variablen
// -------------------------------------------------------------

// =============================================================
//  Opens an given source file.
// =============================================================
dcl-proc SourceFile_open export;
  dcl-pi *n;
    i_lib  like(lib_t) const;
    i_file like(file_t) const;
    i_mbr  like(mbr_t) const;
  end-pi;

  QSYSSourceFile_open(SRCFILE: i_lib: i_file: i_mbr);

  f1_line_number = 0;

end-proc;

// =============================================================
//  Returns the open status of the source file.
// =============================================================
dcl-proc SourceFile_isOpen export;
  dcl-pi *n ind;
  end-pi;

  return %open(SRCFILE);

end-proc;

// =============================================================
//  Returns the current line number of the source file.
// =============================================================
dcl-proc SourceFile_getLineNbr export;
  dcl-pi *n int(10);
  end-pi;

  if (%open(SRCFILE));
    return f1_line_number;
  else;
    return -1;
  endif;

end-proc;

// =============================================================
//  Returns the length of the data field of the source file.
// =============================================================
dcl-proc SourceFile_getDtaLength export;
  dcl-pi *n int(10);
  end-pi;

  dcl-s dtaLen int(10);

  dtaLen = QSYSSourceFile_getDtaLength(f1);

  return dtaLen;

end-proc;

// =============================================================
//  Returns the library name of the source file.
// =============================================================
dcl-proc SourceFile_getLibrary export;
  dcl-pi *n char(10);
  end-pi;

  dcl-s library char(10);

  library = QSYSSourceFile_getLibrary(f1);

  return library;

end-proc;

// =============================================================
//  Returns the file name of the source file.
// =============================================================
dcl-proc SourceFile_getFile export;
  dcl-pi *n char(10);
  end-pi;

  dcl-s file char(10);

  file = QSYSSourceFile_getFile(f1);

  return file;

end-proc;

// =============================================================
//  Returns the member name of the source file.
// =============================================================
dcl-proc SourceFile_getMember export;
  dcl-pi *n char(10);
  end-pi;

  dcl-s member char(10);

  member = QSYSSourceFile_getMember(f1);

  return member;

end-proc;

// =============================================================
//  Reads the next line from the source input file.
// =============================================================
dcl-proc SourceFile_readLine export;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  if QSYSSourceFile_readLine(SRCFILE: io_srcDta);
    f1_line_number = f1_line_number + 1;
    return cTrue;
  else;
    return cFalse;
  endif;

end-proc;

// =============================================================
//  Reads the pervious line from the source input file.
// =============================================================
dcl-proc SourceFile_readPrvLine export;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  if (QSYSSourceFile_readPrvLine(SRCFILE: io_srcDta));
    f1_line_number = f1_line_number - 1;
    return cTrue;
  else;
    return cFalse;
  endif;

end-proc;

// =============================================================
//  Closes the source file.
// =============================================================
dcl-proc SourceFile_close export;
  dcl-pi *n;
  end-pi;

  QSYSSourceFile_close(SRCFILE);

end-proc;

// =============================================================
//  Opens an given include file.
// =============================================================
dcl-proc IncludeFile_open export;
  dcl-pi *n;
    i_lib  like(lib_t) const;
    i_file like(file_t) const;
    i_mbr  like(mbr_t) const;
  end-pi;

  QSYSSourceFile_open(INCLUDE: i_lib: i_file: i_mbr);

  f2_line_number = 0;

end-proc;

// =============================================================
//  Returns the open status of the include file.
// =============================================================
dcl-proc IncludeFile_isOpen export;
  dcl-pi *n ind;
  end-pi;

  return %open(INCLUDE);

end-proc;

// =============================================================
//  Returns the current line number of the include file.
// =============================================================
dcl-proc IncludeFile_getLineNbr export;
  dcl-pi *n int(10);
  end-pi;

  if (%open(INCLUDE));
    return f2_line_number;
  else;
    return -1;
  endif;

end-proc;

// =============================================================
//  Returns the length of the data field of the include file.
// =============================================================
dcl-proc IncludeFile_getDtaLength export;
  dcl-pi *n int(10);
  end-pi;

  dcl-s dtaLen int(10);

  dtaLen = QSYSSourceFile_getDtaLength(f2);

  return dtaLen;

end-proc;

// =============================================================
//  Returns the library name of the include file.
// =============================================================
dcl-proc IncludeFile_getLibrary export;
  dcl-pi *n char(10);
  end-pi;

  dcl-s library char(10);

  library = QSYSSourceFile_getLibrary(f1);

  return library;

end-proc;

// =============================================================
//  Returns the file name of the include file.
// =============================================================
dcl-proc IncludeFile_getFile export;
  dcl-pi *n char(10);
  end-pi;

  dcl-s file char(10);

  file = QSYSSourceFile_getFile(f1);

  return file;

end-proc;

// =============================================================
//  Returns the member name of the include file.
// =============================================================
dcl-proc IncludeFile_getMember export;
  dcl-pi *n char(10);
  end-pi;

  dcl-s member char(10);

  member = QSYSSourceFile_getMember(f1);

  return member;

end-proc;

// =============================================================
//  Reads the next line from the include file.
// =============================================================
dcl-proc IncludeFile_readLine export;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  if (QSYSSourceFile_readLine(INCLUDE: io_srcDta));
    f2_line_number = f2_line_number + 1;
    return cTrue;
  else;
    return cFalse;
  endif;

end-proc;

// =============================================================
//  Reads the previous line from the include file.
// =============================================================
dcl-proc IncludeFile_readPrvLine export;
  dcl-pi *n ind;
    io_srcDta like(ds_srcFile_t.srcDta);
  end-pi;

  if (QSYSSourceFile_readPrvLine(INCLUDE: io_srcDta));
    f2_line_number = f2_line_number - 1;
    return cTrue;
  else;
    return cFalse;
  endif;

end-proc;

// =============================================================
//  Closes the include file.
// =============================================================
dcl-proc IncludeFile_close export;
  dcl-pi *n;
  end-pi;

  QSYSSourceFile_close(INCLUDE);

end-proc;

// =============================================================
//  Opens a given QSYS file.
// =============================================================
dcl-proc QSYSSourceFile_open;
  dcl-pi *n;
    i_qsysFile likefile(SRCFILE_t);
    i_lib      like(lib_t) const;
    i_file     like(file_t) const;
    i_mbr      like(mbr_t) const;
  end-pi;

  //  ... Die Datensatzlänge der Eingabedatei ist zu lang.
/copy QSTRPREPRC,PRZ0011
  //  ... Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.
/copy QSTRPREPRC,PRZ0012

  // Does not work, because CHKOBJ does not resolve members
  // as 'open' does.
  // Member_exists(i_file: i_lib: i_mbr);

  g_useSrcFile.name = %trim(i_lib) + '/' + %trim(i_file);
  g_useSrcFile.member = %trim(i_mbr);

  open(E) i_qsysFile;
  if (%error());
    clear PRZ0012;
    PRZ00121 = i_file;
    PRZ00122 = i_lib;
    PRZ00123 = i_mbr;
    sendMsg(f_newMsg('PRZ0012': PRZ0012: cTYPE_DIAG));
    endAbnormal();
  endif;

  removeFileOpenMessage();

  f1_srcDtaLen =
        f1.rcdLen -
        (%size(ds_srcFile_t.srcSeq) + %size(ds_srcFile_t.srcDat));

  // Prüfen der Datensatzlänge
  if (f1.rcdLen > MAX_RCD_LEN);
    clear PRZ0011;
    PRZ00111 = f1.rcdLen;
    PRZ00112 = MAX_RCD_LEN;
    PRZ00113 = f1.lib;
    PRZ00114 = f1.file;
    sendMsg(f_newMsg('PRZ0011': PRZ0011: cTYPE_DIAG));
    endAbnormal();
  endif;

end-proc;

// =============================================================
//  Returns the length of the data field of a QSYS source file.
// =============================================================
dcl-proc QSYSSourceFile_getDtaLength;
  dcl-pi *n int(10);
    i_fileStatus likeds(fileStatus_t) const;
  end-pi;

  dcl-s dtaLen int(10);

  dtaLen =
        i_fileStatus.rcdLen -
        (%size(ds_srcFile_t.srcSeq) + %size(ds_srcFile_t.srcDat));

  return dtaLen;

end-proc;

// =============================================================
//  Returns the library name if a given QSYS source file.
// =============================================================
dcl-proc QSYSSourceFile_getLibrary;
  dcl-pi *n char(10);
    i_fileStatus likeds(fileStatus_t) const;
  end-pi;

  dcl-s library char(10);

  library = i_fileStatus.lib;

  return library;

end-proc;

// =============================================================
//  Returns the file name if a given QSYS source file.
// =============================================================
dcl-proc QSYSSourceFile_getFile;
  dcl-pi *n char(10);
    i_fileStatus likeds(fileStatus_t) const;
  end-pi;

  dcl-s file char(10);

  file = i_fileStatus.file;

  return file;

end-proc;

// =============================================================
//  Returns the member name if a given QSYS source file.
// =============================================================
dcl-proc QSYSSourceFile_getMember;
  dcl-pi *n char(10);
    i_fileStatus likeds(fileStatus_t) const;
  end-pi;

  dcl-s member char(10);

  member = i_fileStatus.mbr;

  return member;

end-proc;

// =============================================================
//  Reads a line of a given QSYS source file.
// =============================================================
dcl-proc QSYSSourceFile_readLine;
  dcl-pi *n ind;
    i_qsysFile likefile(SRCFILE_t);
    io_srcDta  like(ds_srcFile_t.srcDta);
  end-pi;

  dcl-ds ds_srcFile likeds(ds_srcFile_t) inz;

  read i_qsysFile ds_srcFile;
  if (%eof());
    io_srcDta = '';
    return cFalse;
  endif;

  io_srcDta = %subst(ds_srcFile.srcDta: 1: f1_srcDtaLen);

  return cTrue;

end-proc;

// =============================================================
//  Reads the previous line of a given QSYS source file.
// =============================================================
dcl-proc QSYSSourceFile_readPrvLine;
  dcl-pi *n ind;
    i_qsysFile likefile(SRCFILE_t);
    io_srcDta  like(ds_srcFile_t.srcDta);
  end-pi;

  dcl-ds ds_srcFile likeds(ds_srcFile_t) inz;

  readp i_qsysFile ds_srcFile;
  if (%eof());
    io_srcDta = '';
    return cFalse;
  endif;

  io_srcDta = %subst(ds_srcFile.srcDta: 1: f1_srcDtaLen);

  return cTrue;

end-proc;

// =============================================================
//  Closes a given QSYS source file.
// =============================================================
dcl-proc QSYSSourceFile_close;
  dcl-pi *n;
    i_qsysFile likefile(SRCFILE_t);
  end-pi;

  if (not %open(i_qsysFile));
    return;
  endif;

  close i_qsysFile;

end-proc;

//===============================================================*
//  Remove file open message:
//  CPF4011 - Buffer length longer than record for member
//===============================================================*
dcl-proc removeFileOpenMessage;
  dcl-pi *n;
  end-pi;

  dcl-ds rcvm0100 likeds(rcvm0100_t);
  dcl-ds errCode likeds(errCode_t);

  errCode = f_newApiErrCode(cTrue); // ignore errors

  QMHRCVPM(rcvm0100: %size(rcvm0100): 'RCVM0100': '*': 1
           : '*ANY': '': 0: '*SAME': errCode);

  if (not f_isApiError(errCode) and rcvm0100.msgID = 'CPF4011');
    QMHRMVPM('*' : 1: rcvm0100.msgKey: '*BYKEY': errCode);
  endif;


end-proc;

//===============================================================*
//  Check existence of a source member.
//===============================================================*
dcl-proc Member_exists;
  dcl-pi *n;
    i_file char(10) const;
    i_lib  char(10) const;
    i_mbr  char(10) const;
  end-pi;

  dcl-s rc int(10);

  //  system -- Execute a Command
  //     Return value       Meaning
  //     ----------------   --------------------------------------
  //     0                  the command is successful
  //     -1                 for a NULL pointer
  //     1                  the command fails
  dcl-pr system int(10) extproc('system');
    i_clCommand pointer options(*string) value;
  end-pr;

  //  Nachrichten
  //  ... Bibliothek &1 nicht gefunden.
/copy QSTRPREPRC,PRZ0035
  //  ... Datei &1 in Bibliothek &2 nicht gefunden.
/copy QSTRPREPRC,PRZ0036
  //  ... Teildatei &3 von Datei &1 in Bibliothek &2 nicht gefunden.
/copy QSTRPREPRC,PRZ0037

  if (%subst(i_lib: 1: 1) <> '*');
    rc = system('CHKOBJ OBJ(' + %trim(i_lib) + ') OBJTYPE(*LIB)');
    if (rc <> 0);
      clear PRZ0035;
      PRZ00351 = i_lib;
      sendMsg(f_newMsg('PRZ0035': PRZ0035: cTYPE_ESCAPE));
    endif;
  endif;

  rc = system('CHKOBJ OBJ(' + %trim(i_lib) + '/' +
                              %trim(i_file) + ') OBJTYPE(*FILE)');
  if (rc <> 0);
    clear PRZ0036;
    PRZ00361 = i_file;
    PRZ00362 = i_lib;
    sendMsg(f_newMsg('PRZ0036': PRZ0036: cTYPE_ESCAPE));
  endif;

  rc = system('CHKOBJ OBJ(' + %trim(i_lib) + '/' +
                              %trim(i_file) + ') OBJTYPE(*FILE) ' +
                              'MBR(' + %trim(i_mbr) + ')');
  if (rc <> 0);
    clear PRZ0037;
    PRZ00371 = i_file;
    PRZ00372 = i_lib;
    PRZ00373 = i_mbr;
    sendMsg(f_newMsg('PRZ0037': PRZ0037: cTYPE_ESCAPE));
  endif;

end-proc;

