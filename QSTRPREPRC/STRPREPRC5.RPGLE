      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : STRPREPRC                                          *
      *  Objekt  . . . : STRPREPRC5                                         *
      *  Beschreibung  : Start Pre-Processor - QSYS Files                   *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 15.03.2022                                         *
      *                                                                     *
      * =================================================================== *
      *                                                                     *
      *  This software is free software, you can redistribute it and/or     *
      *  modify it under the terms of the GNU General Public License (GPL)  *
      *  as published by the Free Software Foundation.                      *
      *                                                                     *
      *  See GNU General Public License for details.                        *
      *          http://www.opensource.org                                  *
      *          http://www.opensource.org/licenses/gpl-license.html        *
      *                                                                     *
      *=====================================================================*
      *  History:                                                           *
      *                                                                     *
      *  Datum       Name          Änderung                                 *
      *  ----------  ------------  ---------------------------------------  *
      *                                                                     *
      * =================================================================== *
      * >>PRE-COMPILER<<                                                    *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
      *                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
      *   >>IMPORTANT<<                                                     *
      *     >>PARM<< TRUNCNBR(*NO);                                         *
      *     >>PARM<< DBGVIEW(*LIST);                                        *
      *     >>PARM<< OPTION(*EVENTF);                                       *
      *   >>END-IMPORTANT<<                                                 *
      *   >>EXECUTE<<                                                       *
      * >>END-PRE-COMPILER<<                                                *
      * =================================================================== *
     H NOMAIN BNDDIR('QC2LE')
      /COPY QSTRPREPRC,H_SPEC
      /COPY QSTRPREPRC,COPYRIGHT
      * =================================================================== *
     FSRCFILE_t IF   F  256        DISK    template block(*no)
      *
      * -------------------------------------------------------------
      *  Verwendete Dateien
      * -------------------------------------------------------------
     FSRCFILE                              likefile(SRCFILE_t)
     F                                     extfile(g_useSrcFile.name)
     F                                     extmbr(g_useSrcFile.member)
     F                                     infds(f1)
     F                                     usropn
      *
     FINCLUDE                              likefile(SRCFILE_t)
     F*                                    extfile(g_include.name)
     F*                                    extmbr(g_include.member)
     F                                     extfile(g_useSrcFile.name)
     F                                     extmbr(g_useSrcFile.member)
     F                                     infds(f2)
     F                                     usropn
      *
     D g_useSrcFile    ds                  qualified inz
     D  name                         21a   varying
     D  member                       10a   varying
      *
     D f1_srcDtaLen    s             10i 0
      *
     D f1_line_number  s             10i 0 inz(-1)
      *
     D f1              ds                  likeds(fileStatus_t)
      *
     D f2_line_number  s             10i 0 inz(-1)
      *
     D f2              ds                  likeds(fileStatus_t)
      *
      * -------------------------------------------------------------
      *  Type Templates
      * -------------------------------------------------------------
     D fileStatus_t    ds                  qualified template
     D  status                11     15S 0
     D  file                  83     92A
     D  lib                   93    102A
     D  rcdLen               125    126B 0
     D  mbr                  129    138A
     D  nbrOfKey             387    388B 0
     D  rcdNbr               397    400B 0
      *
      * -------------------------------------------------------------
      *  Exportierte Prototypen
      * -------------------------------------------------------------
      /copy QSTRPREPRC,PSTRPREPR5
      *
      * -------------------------------------------------------------
      *  Importierte Prototypen
      * -------------------------------------------------------------
      /copy QSTRPREPRC,PSTRPREPR2
      /copy QBASICS1,PBASICS1
      /copy QSTRPREPRC,TYPES_H
      /copy QSTRPREPRC,QMHRCVPM
      /copy QSTRPREPRC,QMHRMVPM
      *
      * -------------------------------------------------------------
      *  Globale Variablen
      * -------------------------------------------------------------

      * =============================================================
      *  Opens an given source file.
      * =============================================================
     P SourceFile_open...
     P                 b                   export
     D                 pi
     D  i_lib                              const  like(lib_t)
     D  i_file                             const  like(file_t)
     D  i_mbr                              const  like(mbr_t)
      /free

         QSYSSourceFile_open(SRCFILE: i_lib: i_file: i_mbr);

         f1_line_number = 0;

      /end-free
     P                 E

      * =============================================================
      *  Returns the open status of the source file.
      * =============================================================
     P SourceFile_isOpen...
     P                 b                   export
     D                 pi              n
      /free

         return %open(SRCFILE);

      /end-free
     P                 E

      * =============================================================
      *  Returns the current line number of the source file.
      * =============================================================
     P SourceFile_getLineNbr...
     P                 b                   export
     D                 pi            10i 0
      /free

         if (%open(SRCFILE));
            return f1_line_number;
         else;
            return -1;
         endif;

      /end-free
     P                 E

      * =============================================================
      *  Returns the length of the data field of the source file.
      * =============================================================
     P SourceFile_getDtaLength...
     P                 b                   export
     D                 pi            10i 0

     D dtaLen          s             10i 0
      /free

         dtaLen = QSYSSourceFile_getDtaLength(f1);

         return dtaLen;

      /end-free
     P                 E

      * =============================================================
      *  Returns the library name of the source file.
      * =============================================================
     P SourceFile_getLibrary...
     P                 b                   export
     D                 pi            10a

     D library         s             10a
      /free

         library = QSYSSourceFile_getLibrary(f1);

         return library;

      /end-free
     P                 E

      * =============================================================
      *  Returns the file name of the source file.
      * =============================================================
     P SourceFile_getFile...
     P                 b                   export
     D                 pi            10a

     D file            s             10a
      /free

         file = QSYSSourceFile_getFile(f1);

         return file;

      /end-free
     P                 E

      * =============================================================
      *  Returns the member name of the source file.
      * =============================================================
     P SourceFile_getMember...
     P                 b                   export
     D                 pi            10a

     D member          s             10a
      /free

         member = QSYSSourceFile_getMember(f1);

         return member;

      /end-free
     P                 E

      * =============================================================
      *  Reads the next line from the source input file.
      * =============================================================
     P SourceFile_readLine...
     P                 b                   export
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      /free

         if QSYSSourceFile_readLine(SRCFILE: io_srcDta);
            f1_line_number = f1_line_number + 1;
            return cTrue;
         else;
            return cFalse;
         endif;

      /end-free
     P                 E

      * =============================================================
      *  Reads the pervious line from the source input file.
      * =============================================================
     P SourceFile_readPrvLine...
     P                 b                   export
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      /free

         if (QSYSSourceFile_readPrvLine(SRCFILE: io_srcDta));
            f1_line_number = f1_line_number - 1;
            return cTrue;
         else;
            return cFalse;
         endif;

      /end-free
     P                 E

      * =============================================================
      *  Closes the source file.
      * =============================================================
     P SourceFile_close...
     P                 b                   export
     D                 pi
      /free

         QSYSSourceFile_close(SRCFILE);

      /end-free
     P                 E

      * =============================================================
      *  Opens an given include file.
      * =============================================================
     P IncludeFile_open...
     P                 b                   export
     D                 pi
     D  i_lib                              const  like(lib_t)
     D  i_file                             const  like(file_t)
     D  i_mbr                              const  like(mbr_t)
      /free

         QSYSSourceFile_open(INCLUDE: i_lib: i_file: i_mbr);

         f2_line_number = 0;

      /end-free
     P                 E

      * =============================================================
      *  Returns the open status of the include file.
      * =============================================================
     P IncludeFile_isOpen...
     P                 b                   export
     D                 pi              n
      /free

         return %open(INCLUDE);

      /end-free
     P                 E

      * =============================================================
      *  Returns the current line number of the include file.
      * =============================================================
     P IncludeFile_getLineNbr...
     P                 b                   export
     D                 pi            10i 0
      /free

         if (%open(INCLUDE));
            return f2_line_number;
         else;
            return -1;
         endif;

      /end-free
     P                 E

      * =============================================================
      *  Returns the length of the data field of the include file.
      * =============================================================
     P IncludeFile_getDtaLength...
     P                 b                   export
     D                 pi            10i 0

     D dtaLen          s             10i 0
      /free

         dtaLen = QSYSSourceFile_getDtaLength(f2);

         return dtaLen;

      /end-free
     P                 E

      * =============================================================
      *  Returns the library name of the include file.
      * =============================================================
     P IncludeFile_getLibrary...
     P                 b                   export
     D                 pi            10a

     D library         s             10a
      /free

         library = QSYSSourceFile_getLibrary(f1);

         return library;

      /end-free
     P                 E

      * =============================================================
      *  Returns the file name of the include file.
      * =============================================================
     P IncludeFile_getFile...
     P                 b                   export
     D                 pi            10a

     D file            s             10a
      /free

         file = QSYSSourceFile_getFile(f1);

         return file;

      /end-free
     P                 E

      * =============================================================
      *  Returns the member name of the include file.
      * =============================================================
     P IncludeFile_getMember...
     P                 b                   export
     D                 pi            10a

     D member          s             10a
      /free

         member = QSYSSourceFile_getMember(f1);

         return member;

      /end-free
     P                 E

      * =============================================================
      *  Reads the next line from the include file.
      * =============================================================
     P IncludeFile_readLine...
     P                 b                   export
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      /free

         if (QSYSSourceFile_readLine(INCLUDE: io_srcDta));
            f2_line_number = f2_line_number + 1;
            return cTrue;
         else;
            return cFalse;
         endif;

      /end-free
     P                 E

      * =============================================================
      *  Reads the previous line from the include file.
      * =============================================================
     P IncludeFile_readPrvLine...
     P                 b                   export
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      /free

         if (QSYSSourceFile_readPrvLine(INCLUDE: io_srcDta));
            f2_line_number = f2_line_number - 1;
            return cTrue;
         else;
            return cFalse;
         endif;

      /end-free
     P                 E

      * =============================================================
      *  Closes the include file.
      * =============================================================
     P IncludeFile_close...
     P                 b                   export
     D                 pi
      /free

         QSYSSourceFile_close(INCLUDE);

      /end-free
     P                 E

      * =============================================================
      *  Opens a given QSYS file.
      * =============================================================
     P QSYSSourceFile_open...
     P                 b
     D                 pi
     D  i_qsysFile                                likefile(SRCFILE_t)
     D  i_lib                              const  like(lib_t)
     D  i_file                             const  like(file_t)
     D  i_mbr                              const  like(mbr_t)
      /free

      *  ... Die Datensatzlänge der Eingabedatei ist zu lang.
      /COPY QSTRPREPRC,PRZ0011
      *  ... Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.
      /COPY QSTRPREPRC,PRZ0012
      /free

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

      /end-free
     P                 E

      * =============================================================
      *  Returns the length of the data field of a QSYS source file.
      * =============================================================
     P QSYSSourceFile_getDtaLength...
     P                 b
     D                 pi            10i 0
     D  i_fileStatus                       const  likeds(fileStatus_t)

     D dtaLen          s             10i 0
      /free

         dtaLen =
               i_fileStatus.rcdLen -
               (%size(ds_srcFile_t.srcSeq) + %size(ds_srcFile_t.srcDat));

         return dtaLen;

      /end-free
     P                 E

      * =============================================================
      *  Returns the library name if a given QSYS source file.
      * =============================================================
     P QSYSSourceFile_getLibrary...
     P                 b
     D                 pi            10a
     D  i_fileStatus                       const  likeds(fileStatus_t)

     D library         s             10a
      /free

         library = i_fileStatus.lib;

         return library;

      /end-free
     P                 E

      * =============================================================
      *  Returns the file name if a given QSYS source file.
      * =============================================================
     P QSYSSourceFile_getFile...
     P                 b
     D                 pi            10a
     D  i_fileStatus                       const  likeds(fileStatus_t)

     D file            s             10a
      /free

         file = i_fileStatus.file;

         return file;

      /end-free
     P                 E

      * =============================================================
      *  Returns the member name if a given QSYS source file.
      * =============================================================
     P QSYSSourceFile_getMember...
     P                 b
     D                 pi            10a
     D  i_fileStatus                       const  likeds(fileStatus_t)

     D member          s             10a
      /free

         member = i_fileStatus.mbr;

         return member;

      /end-free
     P                 E

      * =============================================================
      *  Reads a line of a given QSYS source file.
      * =============================================================
     P QSYSSourceFile_readLine...
     P                 b
     D                 pi              n
     D  i_qsysFile                                likefile(SRCFILE_t)
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      *
     D ds_srcFile      ds                  likeds(ds_srcFile_t) inz
      /free

         read i_qsysFile ds_srcFile;
         if (%eof());
            io_srcDta = '';
            return cFalse;
         endif;

         io_srcDta = %subst(ds_srcFile.srcDta: 1: f1_srcDtaLen);

         return cTrue;

      /end-free
     P                 E

      * =============================================================
      *  Reads the previous line of a given QSYS source file.
      * =============================================================
     P QSYSSourceFile_readPrvLine...
     P                 b
     D                 pi              n
     D  i_qsysFile                                likefile(SRCFILE_t)
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      *
     D ds_srcFile      ds                  likeds(ds_srcFile_t) inz
      /free

         readp i_qsysFile ds_srcFile;
         if (%eof());
            io_srcDta = '';
            return cFalse;
         endif;

         io_srcDta = %subst(ds_srcFile.srcDta: 1: f1_srcDtaLen);

         return cTrue;

      /end-free
     P                 E

      * =============================================================
      *  Closes a given QSYS source file.
      * =============================================================
     P QSYSSourceFile_close...
     P                 b
     D                 pi
     D  i_qsysFile                                likefile(SRCFILE_t)
      /free

         if (not %open(i_qsysFile));
            return;
         endif;

         close i_qsysFile;

      /end-free
     P                 E

      *===============================================================*
      *  Remove file open message:
      *  CPF4011 - Buffer length longer than record for member
      *===============================================================*
     P removeFileOpenMessage...
     P                 b
     D                 pi
      *
     D rcvm0100        ds                  likeds(rcvm0100_t)
     D errCode         ds                  likeds(errCode_t)
      /free

       errCode = f_newApiErrCode(cTrue); // ignore errors

       QMHRCVPM(rcvm0100: %size(rcvm0100): 'RCVM0100': '*': 1
                : '*ANY': '': 0: '*SAME': errCode);

       if (not f_isApiError(errCode) and rcvm0100.msgID = 'CPF4011');
          QMHRMVPM('*' : 1: rcvm0100.msgKey: '*BYKEY': errCode);
       endif;


      /end-free
     P                 E

