     /* =================================================================== */
     /*                                                                     */
     /*  Kurzdokumentation :                                                */
     /*                                                                     */
     /*  Bereich . . . : STRPREPRC                                          */
     /*  Objekt  . . . : STRPREPRC                                          */
     /*  Beschreibung  : Start Pre-Processor - Ger                          */
     /*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
     /*  Datum . . . . : 21.11.2000                                         */
     /*                                                                     */
     /* =================================================================== */
     /*                                                                     */
     /*  This software is free software, you can redistribute it and/or     */
     /*  modify it under the terms of the GNU General Public License (GPL)  */
     /*  as published by the Free Software Foundation.                      */
     /*                                                                     */
     /*  See GNU General Public License for details.                        */
     /*          http://www.opensource.org                                  */
     /*          http://www.opensource.org/licenses/gpl-license.html        */
     /*                                                                     */
     /* =================================================================== */
     /*  History:                                                           */
     /*                                                                     */
     /*  Datum       Name          Änderung                                 */
     /*  ----------  ------------  ---------------------------------------  */
     /*  23.01.2007  Th.Raddatz    Added parameter TAGSREQ(...) to command. */
     /*  09.04.2015  Hildebrandt   Added parameter EXICMDEXC to command.    */
     /*  16.05.2015  Th.Raddatz    Added parameter EVENTF to command.       */
     /*  15.09.2017  Th.Raddatz    Added parameter LIBL to STRPREPRC        */
     /*                            command.                                 */
     /*  16.09.2017  Th.Raddatz    Changed length of parameter CMD from     */
     /*                            2048 to 8192.                            */
     /*  20.09.2017  Th.Raddatz    Added parameter USELIBL to let STRPREPRC */
     /*                            run the XCRTSQLOBJ command of CMOne      */
     /*                            for source members without a STRPREPRC   */
     /*                            header.                                  */
     /*  22.09.2017  Th.Raddatz    Added parameter USRDEFVAR to STRPREPRC   */
     /*                            command.                                 */
     /*  11.02.2019  Th.Raddatz    Added parameters USESRCSTMF and STMF.    */
     /*  07.08.2019  Th.Raddatz    Added parameter EXECOPT.                 */
     /*                                                                     */
     /* =================================================================== */
     /* >>PRE-COMPILER<<                                                    */
     /*   >>CRTCMD<< CRTCMD       CMD(&LI/STRPREPRC) +                      */
     /*                           SRCFILE(&SL/&SF) SRCMBR(&SM);             */
     /*   >>IMPORTANT<<                                                     */
     /*     >>PARM<< PGM(*LIBL/STRPREPRC);                                  */
     /*     >>PARM<< HLPPNLGRP(*LIBL/STRPREPRCP);                           */
     /*     >>PARM<< HLPID(STRPREPRC);                                      */
     /*     >>PARM<< MSGF(*LIBL/STRPREPRC);                                 */
     /*     >>PARM<< PRDLIB(&LI);                                           */
     /*   >>END-IMPORTANT<<                                                 */
     /*   >>EXECUTE<<                                                       */
     /* >>END-PRE-COMPILER<<                                                */
     /* =================================================================== */

             CMD        PROMPT('Pre-Prozessor starten')

             PARM       KWD(USESRCFILE) TYPE(QUAL1)        +
                        MIN(1)                             +
                        PROMPT('Quellendatei')

             PARM       KWD(USESRCMBR ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          PROMPT('Teildatei')

             PARM       KWD(CMD       ) TYPE(*CMDSTR)      +
                          LEN(8192)                        +
                          MIN(0)                           +
                          PROMPT('Auszuführender Befehl')

             PARM       KWD(OPTION    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          MAX(2)                           +
                          RSTD(*YES)                       +
                          VALUES(*EVENTF                   +
                                 *NOEVENTF                 +
                                 *ADDJOBLOG                +
                                 *NOJOBLOG)                +
                          PROMPT('Ereignisdatei Auswahlmögl.')

             PARM       KWD(CHGOBJD   ) TYPE(*CHAR  )      +
                          LEN(4)                           +
                          MIN(0)                           +
                          DFT(*NO)                         +
                          RSTD(*YES)                       +
                          VALUES(*NO *YES)                 +
                          PROMPT('Ändern Objektbeschreibung')

             PARM       KWD(OBJTYPE   ) TYPE(*CHAR  )      +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*PGM)                        +
                          RSTD(*YES)                       +
                          VALUES(                          +
                              *BNDDIR                      +
                              *DTAARA                      +
                              *DTAQ                        +
                              *FILE                        +
                              *JOBD                        +
                              *MSGF                        +
                              *MSGQ                        +
                              *OUTQ                        +
                              *PGM                         +
                              *SRVPGM                      +
                              *TBL                         +
                                )                          +
                          PMTCTL(PMTCTL1)                  +
                          PROMPT('Objekttyp')

             PARM       KWD(OBJSRCFILE)         +
                        TYPE(*NAME)             +
                        LEN(10)                 +
                        MIN(0)                  +
                        DFT(*SAME)              +
                        SPCVAL(                 +
                          (*SAME      )         +
                          (*DFT       )         +
                          (*BLANK ' ' ))        +
                        PMTCTL(PMTCTL1)         +
                        PROMPT('Objekt-Quellendatei')

             PARM       KWD(OBJSRCLIB)          +
                        TYPE(*NAME)             +
                        LEN(10)                 +
                        MIN(0)                  +
                        DFT(*SAME)              +
                        SPCVAL(                 +
                          (*SAME      )         +
                          (*DFT       )         +
                          (*BLANK ' ' ))        +
                        PMTCTL(PMTCTL1)         +
                        PROMPT('Objekt-Quellenbibliothek')

             PARM       KWD(OBJSRCMBR)          +
                        TYPE(*NAME)             +
                        LEN(10)                 +
                        MIN(0)                  +
                        DFT(*SAME)              +
                        SPCVAL(                 +
                          (*SAME      )         +
                          (*DFT       )         +
                          (*BLANK ' ' ))        +
                        PMTCTL(PMTCTL1)         +
                        PROMPT('Objekt-Quellenteildatei')

             PARM       KWD(LIB       ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Bibliothek      (&LI)')

             PARM       KWD(OBJ       ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE) (*DFT))           +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Objekt          (&OB)')

             PARM       KWD(TYPECODE  ) TYPE(*CHAR)        +
                          LEN(6)                           +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Type Code       (&TY)')

             PARM       KWD(SRCLIB    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE) (*DFT))           +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Quellenbibl.    (&SL)')

             PARM       KWD(SRCFILE   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE) (*DFT))           +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Quellendatei    (&SF)')

             PARM       KWD(SRCMBR    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE) (*DFT))           +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Quell.Teildatei (&SM)')

             PARM       KWD(TESTLIB   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Testbibliothek  (&TL)')

             PARM       KWD(TESTOBJ   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Testobjekt      (&TO)')

             PARM       KWD(TGTRLS    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Zielrelease     (&TR)')

             PARM       KWD(FRMSRCLIB ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Von-Quellenbibl.(&FL)')

             PARM       KWD(FRMSRCFILE) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Von-Quellendatei(&FF)')

             PARM       KWD(FRMSRCMBR ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Von-Quell.Teild.(&FM)')

             PARM       KWD(USER0     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U0)')

             PARM       KWD(USER1     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U1)')

             PARM       KWD(USER2     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U2)')

             PARM       KWD(USER3     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U3)')

             PARM       KWD(USER4     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U4)')

             PARM       KWD(USER5     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U5)')

             PARM       KWD(USER6     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U6)')

             PARM       KWD(USER7     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U7)')

             PARM       KWD(USER8     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U8)')

             PARM       KWD(USER9     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Wert für Parameter       (&U9)')

             PARM       KWD(USRDEFVAR ) TYPE(USRDEFVAR)    +
                          MIN(0)                           +
                          MAX(20)                          +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Benutzerdefinierte Variablen')

             PARM       KWD(LIBL      ) TYPE(LIBL)         +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Bibliotheksliste')

             PARM       KWD(USELIBL   ) TYPE(*LGL)         +
                          LEN(1)                           +
                          MIN(0)                           +
                          DFT(*NO)                         +
                          SPCVAL((*NO  '0')                +
                                 (*YES '1'))               +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Verwende Bibl.-Liste implizit')

             PARM       KWD(TAGSREQ   ) TYPE(*LGL)         +
                          LEN(1)                           +
                          MIN(0)                           +
                          DFT(*NO)                         +
                          SPCVAL((*NO  '0')                +
                                 (*YES '1'))               +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Pre-Proz. Marken erforderlich')

             PARM       KWD(MSGF      ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          CONSTANT(STRPREPRC)

             PARM       KWD(EXICMDEXC ) TYPE(QEXICMDEXC)   +
                          DFT(*NONE)                       +
                          SNGVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Exit Program Command Execution')

             PARM       KWD(EXECOPT   ) TYPE(*CHAR)        +
                          DFT(*ALL)                        +
                          SNGVAL(*ALL)                     +
                          LEN(10)                          +
                          MIN(0)                           +
                          MAX(3)                           +
                          RSTD(*YES)                       +
                          VALUES(*ALL                      +
                                 *PRECMDS                  +
                                 *CRTCMD                   +
                                 *POSTCMDS)                +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Befehlsausführungsoptionen')

 USRDEFVAR:  ELEM         TYPE(*CHAR)                      +
                          MIN(1)                           +
                          LEN(10)                          +
                          EXPR(*YES)                       +
                          PROMPT('Name')

             ELEM         TYPE(*CHAR)                      +
                          MIN(1)                           +
                          LEN(100)                         +
                          EXPR(*YES)                       +
                          PROMPT('Value')

 LIBL:       ELEM         TYPE(*CHAR)                      +
                          MIN(0)                           +
                          LEN(10)                          +
                          DFT(*CRTDFT)                     +
                          SPCVAL((*SAME) (*CRTDFT))        +
                          PROMPT('Aktuelle Bibliothek (&CL)')

             ELEM         TYPE(*CHAR)                      +
                          MIN(0)                           +
                          MAX(250)                         +
                          LEN(10)                          +
                          DFT(*NONE)                       +
                          SNGVAL((*NONE))                  +
                          PROMPT('Bibliotheksliste (&LL)')

 QEXICMDEXC: QUAL       TYPE(*NAME)                        +
                          LEN(10)
             QUAL       TYPE(*NAME)                        +
                          LEN(10)                          +
                          SPCVAL((*LIBL) (*CURLIB))        +
                          PROMPT('Bibliothek')

 QUAL1:      QUAL       TYPE(*NAME)                        +
                          LEN(10)                          +
                          MIN(1)
             QUAL       TYPE(*NAME)                        +
                          LEN(10)                          +
                          MIN(1)                           +
                          PROMPT('Bibliothek')

 PMTCTL1:    PMTCTL     CTL(CHGOBJD) COND((*EQ '*YES'))

 /* ------------------------- */
 /* Prüfen der Abhängigkeiten */
 /* ------------------------- */

 /* ... Ausgeben Ereignisdatei          */
 /*     ... Option = *EVENTF            */
             DEP        CTL(&OPTION *EQ '*EVENTF') +
                          PARM((&LIB *NE '*NONE')  +
                               (&OBJ *NE '*NONE')) +
                          NBRTRUE(*ALL) MSGID(PRZ0027)

 /* ... Ändern Objektbeschreibung       */
 /*     ... Objekttyp                   */
             DEP        CTL(&CHGOBJD *EQ '*NO') +
                        PARM((&OBJTYPE          +
                              *EQ '*PGM'))      +
                        NBRTRUE(*ALL)           +
                        MSGID(PRZ0019)

             DEP        CTL(&CHGOBJD *EQ '*YES') +
                        PARM((&OBJTYPE           +
                              *NE ' '))          +
                        NBRTRUE(*ALL)            +
                        MSGID(PRZ0020)

 /*     ... Objekt-Quellendatei         */
             DEP        CTL(&CHGOBJD *EQ '*NO') +
                        PARM((&OBJSRCFILE       +
                              *EQ '*SAME'))     +
                        NBRTRUE(*ALL)           +
                        MSGID(PRZ0016)

 /*     ... Objekt-Quellenbibliothek    */
             DEP        CTL(&CHGOBJD *EQ '*NO') +
                        PARM((&OBJSRCLIB        +
                              *EQ '*SAME'))     +
                        NBRTRUE(*ALL)           +
                        MSGID(PRZ0017)

 /*     ... Objekt-Quellenteildatei     */
             DEP        CTL(&CHGOBJD *EQ '*NO') +
                        PARM((&OBJSRCMBR        +
                              *EQ '*SAME'))     +
                        NBRTRUE(*ALL)           +
                        MSGID(PRZ0018)

