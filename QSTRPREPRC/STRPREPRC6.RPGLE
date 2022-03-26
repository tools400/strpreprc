      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : STRPREPRC                                          *
      *  Objekt  . . . : STRPREPRC5                                         *
      *  Beschreibung  : Start Pre-Processor - IFS Files                    *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 16.03.2022                                         *
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
      *  26.03.2022  Th.Raddatz    Added stream file support.               *
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
     D SRCFILE         ds                  likeds(hStmf_t) inz(*likeds)
     D INCLUDE         ds                  likeds(hStmf_t) inz(*likeds)

      * -------------------------------------------------------------
      *  Exportierte Prototypen
      * -------------------------------------------------------------
      /copy QSTRPREPRC,PSTRPREPR6

      * -------------------------------------------------------------
      *  Importierte Prototypen
      * -------------------------------------------------------------
      /copy QSTRPREPRC,PSTRPREPR2
      /copy QBASICS1,PBASICS1
      /copy QSTRPREPRC,TYPES_H

      * -------------------------------------------------------------
      *  Type Templates
      * -------------------------------------------------------------
     D hStmf_t         ds                  qualified template
     D  fd                                 like(fd_t) inz(-1)
     D  isFound                        n   inz(cFalse)
     D  readOffset                   10i 0
     D  currLine                           likeds(line_t) inz
     D  buffSize                     10i 0 inz(0)
     D  buffPos                      10i 0 inz(0)
     D  readDirection                10a   varying inz
     D  folder                             like(path_t) inz
     D  stmf                               like(path_t) inz
     D  buffer                     4096a   inz
     D  prvLines                           likeds(lines_t) inz

      // required for 7.1, because '%elem(io_hStmf.prvLines.line)'
      // does not work. (available since 7.3)
     D NUM_LINES       c                   250

     D lines_t         ds                  qualified template
     D  i                            10i 0
     D  count                        10i 0 inz
     D  line                               likeds(line_t) dim(NUM_LINES) inz

     D line_t          ds                  qualified template
     D  lineNbr                      10i 0 inz
     D**startPos                     10i 0 inz
     D  length                       10i 0 inz
     D  data                               like(srcDta_t)

      *  Exported only for iRPGUnit unit tests.
      *  Must match size of hStmt.buffer.
     D BUFFER_SIZE     s             10i 0 inz(4096) export
      * -------------------------------------------------------------
      *  Global Fields and Constants
      * -------------------------------------------------------------
     D CR              c                   x'0D'
     D LF              c                   x'25'

     D RD_UNDEFINED    c                   '*N'
     D RD_NEXT         c                   'NEXT'
     D RD_PREVIOUS     c                   'PREV'

      * =============================================================
      *  Opens an given source file.
      * =============================================================
     P SourceStreamFile_open...
     P                 b                   export
     D                 pi
     D  i_stmf                             const  like(path_t)
      /free

       SRCFILE = IFSSourceStreamFile_open(i_stmf);

      /end-free
     P                 E

      * =============================================================
      *  Returns the open status of the source file.
      * =============================================================
     P SourceStreamFile_isOpen...
     P                 b                   export
     D                 pi              n
      /free

       return IFSSourceStreamFile_isOpen(SRCFILE);


      /end-free
     P                 E

      * =============================================================
      *  Returns the current line number of the source file.
      * =============================================================
     P SourceStreamFile_getLineNbr...
     P                 b                   export
     D                 pi            10i 0

     D lineNbr         s             10i 0
      /free

       lineNbr = IFSSourceStreamFile_getLineNbr(SRCFILE);

       return lineNbr;

      /end-free
     P                 E

      * =============================================================
      *  Returns the length of the data field of the source file.
      * =============================================================
     P SourceStreamFile_getDtaLength...
     P                 b                   export
     D                 pi            10i 0

     D lineLength      s             10i 0
      /free

       lineLength = IFSSourceStreamFile_getDtaLength(SRCFILE);

       return lineLength;

      /end-free
     P                 E

      * =============================================================
      *  Returns the folder name of the source file.
      * =============================================================
     P SourceStreamFile_getFolder...
     P                 b                   export
     D                 pi                  like(path_t)

     D folder          s                   like(path_t)
      /free

       folder = IFSSourceStreamFile_getFolder(SRCFILE);

       return folder;

      /end-free
     P                 E

      * =============================================================
      *  Returns the file name of the source file.
      * =============================================================
     P SourceStreamFile_getFile...
     P                 b                   export
     D                 pi                  like(path_t)

     D file            s                   like(path_t)
      /free

       file = IFSSourceStreamFile_getFile(SRCFILE);

       return file;

      /end-free
     P                 E

      * =============================================================
      *  Returns the path (folder + file name) of the source file.
      * =============================================================
     P SourceStreamFile_getPath...
     P                 b                   export
     D                 pi                  like(path_t)

     D path            s                   like(path_t)
      /free

       path = IFSSourceStreamFile_getPath(SRCFILE);

       return path;

      /end-free
     P                 E

      * =============================================================
      *  Reads the next line from the source input file.
      * =============================================================
     P SourceStreamFile_readLine...
     P                 b                   export
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      /free

       return IFSSourceStreamFile_readLine(SRCFILE: io_srcDta);

      /end-free
     P                 E

      * =============================================================
      *  Reads the pervious line from the source input file.
      * =============================================================
     P SourceStreamFile_readPrvLine...
     P                 b                   export
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      /free

       return IFSSourceStreamFile_readPrvLine(SRCFILE: io_srcDta);

      /end-free
     P                 E

      * =============================================================
      *  Closes the source file.
      * =============================================================
     P SourceStreamFile_close...
     P                 b                   export
     D                 pi
      /free

       IFSSourceStreamFile_close(SRCFILE);

      /end-free
     P                 E

      * =============================================================
      *  Opens an given include file.
      * =============================================================
     P IncludeStreamFile_open...
     P                 b                   export
     D                 pi
     D  i_stmf                             const  like(path_t)
      /free

       INCLUDE = IFSSourceStreamFile_open(i_stmf);

      /end-free
     P                 E

      * =============================================================
      *  Returns the open status of the include file.
      * =============================================================
     P IncludeStreamFile_isOpen...
     P                 b                   export
     D                 pi              n
      /free

       return IFSSourceStreamFile_isOpen(INCLUDE);

      /end-free
     P                 E

      * =============================================================
      *  Returns the current line number of the include file.
      *  Special values:
      *   -1   stream file not open
      *    0   end of file
      * =============================================================
     P IncludeStreamFile_getLineNbr...
     P                 b                   export
     D                 pi            10i 0
      /free

       return IFSSourceStreamFile_getLineNbr(INCLUDE);

      /end-free
     P                 E

      * =============================================================
      *  Returns the length of the data field of the include file.
      * =============================================================
     P IncludeStreamFile_getDtaLength...
     P                 b                   export
     D                 pi            10i 0

     D lineLength      s             10i 0
      /free

       lineLength = IFSSourceStreamFile_getDtaLength(INCLUDE);

       return lineLength;

      /end-free
     P                 E

      * =============================================================
      *  Returns the folder name of the include file.
      * =============================================================
     P IncludeStreamFile_getFolder...
     P                 b                   export
     D                 pi                  like(path_t)

     D folder          s                   like(path_t)
      /free

       folder = IFSSourceStreamFile_getFolder(INCLUDE);

       return folder;

      /end-free
     P                 E

      * =============================================================
      *  Returns the file name of the include file.
      * =============================================================
     P IncludeStreamFile_getFile...
     P                 b                   export
     D                 pi                  like(path_t)

     D file            s                   like(path_t)
      /free

       file = IFSSourceStreamFile_getFile(INCLUDE);

       return file;

      /end-free
     P                 E

      * =============================================================
      *  Returns the path (folder + file name) of the include file.
      * =============================================================
     P IncludeStreamFile_getPath...
     P                 b                   export
     D                 pi                  like(path_t)

     D path            s                   like(path_t)
      /free

       path = IFSSourceStreamFile_getPath(INCLUDE);

       return path;

      /end-free
     P                 E

      * =============================================================
      *  Reads the next line from the include file.
      * =============================================================
     P IncludeStreamFile_readLine...
     P                 b                   export
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      /free

       return IFSSourceStreamFile_readLine(INCLUDE: io_srcDta);

      /end-free
     P                 E

      * =============================================================
      *  Reads the previous line from the include file.
      * =============================================================
     P IncludeStreamFile_readPrvLine...
     P                 b                   export
     D                 pi              n
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)
      /free

       return IFSSourceStreamFile_readPrvLine(INCLUDE: io_srcDta);

      /end-free
     P                 E

      * =============================================================
      *  Closes the include file.
      * =============================================================
     P IncludeStreamFile_close...
     P                 b                   export
     D                 pi
      /free

       IFSSourceStreamFile_close(INCLUDE);

      /end-free
     P                 E

      * =============================================================
      *  Opens a given QSYS file.
      * =============================================================
     P IFSSourceStreamFile_open...
     P                 b
     D                 pi                         likeds(hStmf_t)
     D  i_stmf                             const  like(path_t) options(*trim)

     D hStmf           ds                  likeds(hStmf_t) inz
     D fd              s                   like(fd_t)
     D errorNbr        s             10i 0
     D errorText       s                   like(cErrorText_t)
      /free

      *  ... Datei &1 kann nicht geöffnet werden.
      /COPY QSTRPREPRC,PRZ0041
      /free

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

      /end-free
     P                 E

      * =============================================================
      *  Returns the length of the data field of a IFS source file.
      * =============================================================
     P IFSSourceStreamFile_isOpen...
     P                 b
     D                 pi              n
     D  i_hStmf                            const  likeds(hStmf_t)
      /free

       if (i_hStmf.fd = cERROR);
         return cFalse;
       else;
         return cTrue;
       endif;

      /end-free
     P                 E

      * =============================================================
      *  Returns the current line number of a IFS source file.
      * =============================================================
     P IFSSourceStreamFile_getLineNbr...
     P                 b
     D                 pi            10i 0
     D  i_hStmf                            const  likeds(hStmf_t)

     D lineNbr         s             10i 0
      /free

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

      /end-free
     P                 E

      * =============================================================
      *  Returns the length of the data field of a IFS source file.
      * =============================================================
     P IFSSourceStreamFile_getDtaLength...
     P                 b
     D                 pi            10i 0
     D  i_hStmf                            const  likeds(hStmf_t)
      /free

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

      /end-free
     P                 E

      * =============================================================
      *  Returns the library name of a given IFS source file.
      * =============================================================
     P IFSSourceStreamFile_getFolder...
     P                 b
     D                 pi                  like(path_t)
     D  i_hStmf                            const  likeds(hStmf_t)
      /free

       return i_hStmf.folder;

      /end-free
     P                 E

      * =============================================================
      *  Returns the file name of a given IFS source file.
      * =============================================================
     P IFSSourceStreamFile_getFile...
     P                 b
     D                 pi                  like(path_t)
     D  i_hStmf                            const  likeds(hStmf_t)
     D
      /free

       return i_hStmf.stmf;

      /end-free
     P                 E

      * =============================================================
      *  Returns the path (folder + file name) of a given IFS source file.
      * =============================================================
     P IFSSourceStreamFile_getPath...
     P                 b
     D                 pi                  like(path_t)
     D  i_hStmf                            const  likeds(hStmf_t)
     D
      /free

       if (f_endsWith('/': i_hStmf.folder));
         return i_hStmf.folder + i_hStmf.stmf;
       else;
         return i_hStmf.folder + '/' + i_hStmf.stmf;
       endif;

      /end-free
     P                 E


      * =============================================================
      *  Reads a line of a given IFS source file.
      *  Linefeed rules:
      *    LF   - line feed
      *    CR   - line feed
      *    CRLF - line feed
      *    LFCR - two line feeds (second one is an empty line)
      *  This line feed rules are the rules used by Notepad++.
      * =============================================================
     P IFSSourceStreamFile_readLine...
     P                 b
     D                 pi              n
     D  io_hStmf                                  likeds(hStmf_t)
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

     D bytes           s             10i 0
     D char            s              1a
     D isFound         s               n

      // line must match the size of ds_srcFile_t.srcDta
     D line            s            244a   varying
     D linefeed        s              1a   varying
     D prvCurrLine     ds                  likeds(line_t)
     D i               s             10i 0

      //  ... MSG: Die Datensatzlänge der IFS Datei ist zu lang.
      /COPY QSTRPREPRC,PRZ0042
      /free

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

      /end-free
     P                 E

      * =============================================================
      *  Reads the previous line of a given IFS source file.
      * =============================================================
     P IFSSourceStreamFile_readPrvLine...
     P                 b
     D                 pi              n
     D  io_hStmf                                  likeds(hStmf_t)
     D  io_srcDta                                 like(ds_srcFile_t.srcDta)

     D isFound         s               n
      /free

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

      /end-free
     P                 E

      * =============================================================
      *  Closes a given IFS source file.
      * =============================================================
     P IFSSourceStreamFile_close...
     P                 b
     D                 pi
     D  io_hStmf                                  likeds(hStmf_t)

     D hStmf           ds                  likeds(io_hStmf)
      /free

       if (not IFSSourceStreamFile_isOpen(io_hStmf));
         return;
       endif;

       callp close(io_hStmf.fd);

       reset hStmf;
       hStmf.fd = cERROR;
       hStmf.readDirection = RD_UNDEFINED;

       io_hStmf = hStmf;

      /end-free
     P                 E

      * =============================================================
      *  Returns the folder name of a given path.
      * =============================================================
     P Path_getFolder...
     P                 b                   export
     D                 pi                  like(path_t)
     D  i_path                             const like(path_t) options(*trim)

     D folder          s                   like(path_t)
     D x               s             10i 0
     D y               s             10i 0
     D length          s             10i 0
      /free

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

      /end-free
     P                 E

      * =============================================================
      *  Returns the file name of a given path.
      * =============================================================
     P Path_getFile...
     P                 b                   export
     D                 pi                  like(path_t)
     D  i_path                             const  like(path_t) options(*trim)

     D fileName        s                   like(path_t)

     D pToken          s               *   inz
     D token           s                   like(fileName)  inz
      /free

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

      /end-free
     P                 E

      * =============================================================
      *  Returns cTrue, of a given path is a folder.
      * =============================================================
     P isDirectory...
     P                 b
     D                 pi              n
     D  i_path                             const  like(path_t)
      /free

       if (f_endsWith(cSLASH: i_path) or f_endsWith(cBACKSLASH: i_path));
         return cTrue;
       else;
         return cFalse;
       endif;

      /end-free
     P                 E

      * =============================================================
      *  Returns the last C error.
      * =============================================================
     P C_getError...
     P                 b
     D                 pi            10i 0
     D  o_errorText                               like(cErrorText_t)
     D                                            options(*nopass)

     D errorNbr        s             10i 0 based(pErrorNbr)
     D pErrorText      s               *
     D errorText       s            128a

      *  erno--Set Pointer to Runtime Error Code
     D errno           PR              *                     extproc('__errno')

      *  strerror -- Set Pointer to Runtime Error Message
     D strerror        PR              *                     extproc('strerror')
     D  errno                        10I 0 value
      /free

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

      /end-free
     P                 E

      *===============================================================*
      *  Check existence of a stream file.
      *===============================================================*
     P StreamFile_exists...
     P                 b                   export
     D                 pi
     D  i_stmf                             const  like(path_t) options(*trim)
      *
     D rc              s             10i 0
      *
     D st_stat         ds                  likeds(st_stat_t)
      *
      *  Nachrichten
      *  ... Bibliothek &1 nicht gefunden.
      /COPY QSTRPREPRC,PRZ0043
      /free

         rc = stat(i_stmf: %addr(st_stat));
         if (rc <> 0);
            clear PRZ0043;
            PRZ00431 = i_stmf;
            sendMsg(f_newMsg('PRZ0043': PRZ0043: cTYPE_ESCAPE));
         endif;

      /end-free
     P                 E

