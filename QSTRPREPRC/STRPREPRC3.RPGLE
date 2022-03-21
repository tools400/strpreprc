      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : STRPREPRC                                          *
      *  Objekt  . . . : STRPREPRC3                                         *
      *  Beschreibung  : Start Pre-Processor - Init                         *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 21.11.2000                                         *
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
      *  18.05.2015  Th.Raddatz    Converted to /free.                      *
      *                                                                     *
      *  26.04.2020  Th.Raddatz    Added 'INCLUDE' tag.                     *
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
     H NOMAIN
      /COPY QSTRPREPRC,H_SPEC
      *
      * -------------------------------------------------------------
      *  Verwendete Dateien
      * -------------------------------------------------------------
     FSTRPRE1   UF A E             DISK    usropn
     F                                     extfile(g_strpre1.name)
     F                                     extmbr(g_strpre1.member)
     F                                     infds(f1)
     FSTRPRE2   UF A E             DISK    usropn
     F                                     extfile(g_strpre2.name)
     F                                     extmbr(g_strpre2.member)
     F                                     infds(f2)
      *
     D g_strpre1       ds                  qualified inz
     D  name                         21a   varying
     D  member                       10a   varying
      *
     D g_strpre2       ds                  qualified inz
     D  name                         21a   varying
     D  member                       10a   varying
      *
     D f1              DS                  qualified
     D  status                11     15S 0
     D  file                  83     92A
     D  lib                   93    102A
     D  rcdLen               125    126I 0
     D  mbr                  129    138A
     D  numRcd               156    159I 0
     D  nbrOfKey             387    388I 0
     D  rcdNbr               397    400I 0
      *
     D f2              DS                  likeds(f1)
      *
      * -------------------------------------------------------------
      *  Exportierte Prototypen
      * -------------------------------------------------------------
      /copy QSTRPREPRC,PSTRPREPR3
      *
      * -------------------------------------------------------------
      *  Globale Variablen
      * -------------------------------------------------------------
     D ctrlEntry       S             60A   dim(25) ctdata perrcd(1)
     D msgIDs          S             83A   dim(25) ctdata perrcd(1)
      *
      /copy QSTRPREPRC,SDS
      *
      * =============================================================
      *  Initialisieren Pre-Prozessor
      * =============================================================
     P initialize...
     P                 B                   export
     D                 PI
      *
     D x               S             10I 0 inz
      /free

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

      /end-free
     P                 E
      *
** CTDATA(ctrlEntry)
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
** CTDATA(msgIDs)                12345678901234567890123456789012345678901234567890
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
