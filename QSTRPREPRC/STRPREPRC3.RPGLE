**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : STRPREPRC                                          *
//  Objekt  . . . : STRPREPRC3                                         *
//  Beschreibung  : Start Pre-Processor - Init                         *
//  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
//  Datum . . . . : 21.11.2000                                         *
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
//  18.05.2015  Th.Raddatz    Converted to /free.                      *
//                                                                     *
//  26.04.2020  Th.Raddatz    Added 'INCLUDE' tag.                     *
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
ctl-opt nomain;
/copy QSTRPREPRC,H_SPEC

// -------------------------------------------------------------
//  Verwendete Dateien
// -------------------------------------------------------------
dcl-f STRPRE1 usage(*update: *delete: *output) usropn extfile(g_strpre1.name)
  extmbr(g_strpre1.member) infds(f1);
dcl-f STRPRE2 usage(*update: *delete: *output) usropn extfile(g_strpre2.name)
  extmbr(g_strpre2.member) infds(f2);

dcl-ds g_strpre1 qualified inz;
  name   varchar(21);
  member varchar(10);
end-ds;

dcl-ds g_strpre2 qualified inz;
  name   varchar(21);
  member varchar(10);
end-ds;

dcl-ds f1 qualified;
  status   zoned(5) pos(11);
  file     char(10) pos(83);
  lib      char(10);
  rcdLen   int(5) pos(125);
  mbr      char(10) pos(129);
  numRcd   int(10) pos(156);
  nbrOfKey int(5) pos(387);
  rcdNbr   int(10) pos(397);
end-ds;

dcl-ds f2 likeds(f1);

// -------------------------------------------------------------
//  Exportierte Prototypen
// -------------------------------------------------------------
/copy QSTRPREPRC,PSTRPREPR3

// -------------------------------------------------------------
//  Globale Variablen
// -------------------------------------------------------------
dcl-s ctrlEntry char(60) dim(25) ctdata perrcd(1);
dcl-s msgIDs char(83) dim(25) ctdata perrcd(1);

/copy QSTRPREPRC,SDS

// =============================================================
//  Initialisieren Pre-Prozessor
// =============================================================
dcl-proc initialize export;
  dcl-pi *n;
  end-pi;

  dcl-s x int(10) inz;

  g_strpre1.name = %trim(sds.pgmLib) + '/' + 'STRPRE1';
  g_strpre1.member = '*FIRST';

  open STRPRE1;

  if (f1.numRcd <> %elem(ctrlEntry));

    setll 1 FSTRPRE1;
    dow (%found(STRPRE1));
      read FSTRPRE1;
      if (%eof(STRPRE1));
        leave;
      endif;
      delete FSTRPRE1;
    enddo;

    for x = 1 to %elem(ctrlEntry);
      MODE    = %subst(ctrlEntry(x):  1: 30);
      NEWMODE = %subst(ctrlEntry(x): 31: 30);
      write FSTRPRE1;
    endfor;
  endif;

  close STRPRE1;

  g_strpre2.name = %trim(sds.pgmLib) + '/' + 'STRPRE2';
  g_strpre2.member = '*FIRST';

  open STRPRE2;

  if (f2.numRcd = 0);

    setll 1 FSTRPRE2;
    dow (%found(STRPRE2));
      read FSTRPRE2;
      if (%eof(STRPRE2));
        leave;
      endif;
      delete FSTRPRE2;
    enddo;

    for x = 1 to %elem(msgIDs);
      MSGFILE = %subst(msgIDs(x):  1: 10);
      MSGLIB  = %subst(msgIDs(x): 12: 10);
      MSGID   = %subst(msgIDs(x): 23:  7);
      FMT     = %dec(%subst(msgIDs(x): 31: 2): 2: 0);
      TEXT    = %subst(msgIDs(x): 34: 50);
      write FSTRPRE2;
    endfor;
  endif;

  close STRPRE2;

end-proc;

** ctdata(ctrlEntry)
*SCAN                         >>PRE-COMPILER<<
>>COMPILE<<                   >>END-COMPILE<<
>>COMPILE<<                   >>PARM<<
>>COMPILE<<                   >>INCLUDE<<
>>IMPORTANT<<                 >>END-IMPORTANT<<
>>IMPORTANT<<                 >>PARM<<
>>IMPORTANT<<                 >>INCLUDE<<
>>LINK<<                      >>END-LINK<<
>>LINK<<                      >>PARM<<
>>LINK<<                      >>INCLUDE<<
>>PRE-COMPILER<<              *EXIT
>>PRE-COMPILER<<              >>CMD<<
>>PRE-COMPILER<<              >>INCLUDE<<
>>PRE-COMPILER<<              >>COMPILE<<
>>PRE-COMPILER<<              >>IMPORTANT<<
>>PRE-COMPILER<<              >>CRTCMD<<
>>PRE-COMPILER<<              >>EXECUTE<<
>>PRE-COMPILER<<              >>LINK<<
>>PRE-COMPILER<<              >>WIDTH<<
>>PRE-COMPILER<<              >>CURLIB<<
>>PRE-COMPILER<<              >>LIBL<<
>>PRE-COMPILER<<              >>MONMSG<<
>>CMD<<                       >>MONMSG<<
>>MONMSG<<                    >>END-MONMSG<<
>>MONMSG<<                    >>MSGID<<
** ctdata(msgIDs)                12345678901234567890123456789012345678901234567890
QCPFMSG    *LIBL      CPD5CDB 04 The signature of an export block has been trun ...     # 1
QCPFMSG    *LIBL      CPD5CDC 04 The signature of an export block has been padd ...     # 2
QCPFMSG    *LIBL      CPD5CDD 04 If LVLCHK(*NO) is specified on the Start Progr ...     # 3
QCPFMSG    *LIBL      CPD5CDE 04 A syntax error was detected in a signature spe ...     # 4
QCPFMSG    *LIBL      CPD5CDF 04 Signature '&8' was specified on the Start Prog ...     # 5
QCPFMSG    *LIBL      CPD5CD6 04 The wildcard specified, '&8', does not match a ...     # 6
QCPFMSG    *LIBL      CPD5CD7 04 The wildcard specified, '&8', matches &10 symb ...     # 7
QCPFMSG    *LIBL      CPD5CEA 04 An ENDPGMEXP command was expected to end an ex ...     # 8
QCPFMSG    *LIBL      CPD5CEB 04 An export block was not started before the END ...     # 9
QCPFMSG    *LIBL      CPD5CEC 04 An EXPORT binder language command exists outsi ...     #10
QCPFMSG    *LIBL      CPD5CED 04 The current export block of the binder languag ...     #11
QCPFMSG    *LIBL      CPD5CEE 04 No export block of the binder language source  ...     #12
QCPFMSG    *LIBL      CPD5CEF 04 The system has generated identical signatures  ...     #13
QCPFMSG    *LIBL      CPD5CE0 04 Symbol '&8' is specified more than once in a s ...     #14
QCPFMSG    *LIBL      CPD5CE1 04 More than one export block is declared to be t ...     #15
QCPFMSG    *LIBL      CPD5CE2 04 Two or more export blocks in the binder langua ...     #16
QCPFMSG    *LIBL      CPD5CE3 04 The current export block exports fewer symbols ...     #17
QCPFMSG    *LIBL      CPD5CE4 04 Level checking can be disabled only once in a  ...     #18
QCPFMSG    *LIBL      CPD5CE5 04 Symbol '&8' does not exist in the service prog ...     #19
QCPFMSG    *LIBL      CPD5CE6 04 Symbol '&8' is not allowed to be a service pro ...     #20
QCPFMSG    *LIBL      CPD5CE7 04 A syntax error has been found in the binder la ...     #21
QCPFMSG    *LIBL      CPD5CE8 04 If using the EXPORT command, specify a symbol  ...     #22
QCPFMSG    *LIBL      CPD5CE9 04 The end of the binder language source file was ...     #23
QCPFMSG    *LIBL      CPD5CF0 04 A previous export block of the binder language ...     #24
QCPFMSG    *LIBL      CPI433A -1 Unable to retrieve query options file.                 #25
