     /* =================================================================== */
     /*                                                                     */
     /*  Kurzdokumentation :                                                */
     /*                                                                     */
     /*  Bereich . . . : STRPREPRC                                          */
     /*  Objekt  . . . : STRPREPRC                                          */
     /*  Beschreibung  : Start Pre-Processor - Eng                          */
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

             CMD        PROMPT('Start Pre-Processor')

             PARM       KWD(USESRCFILE) TYPE(QUAL1)        +
                        MIN(1)                             +
                        PROMPT('Source file')

             PARM       KWD(USESRCMBR ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(1)                           +
                          PROMPT('Source member')

             PARM       KWD(CMD       ) TYPE(*CMDSTR)      +
                          LEN(8192)                        +
                          MIN(0)                           +
                          PROMPT('Creation command')

             PARM       KWD(OPTION    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          MAX(2)                           +
                          RSTD(*YES)                       +
                          VALUES(*EVENTF                   +
                                 *NOEVENTF                 +
                                 *ADDJOBLOG                +
                                 *NOJOBLOG)                +
                          PROMPT('Event file options')

             PARM       KWD(CHGOBJD   ) TYPE(*CHAR  )      +
                          LEN(4)                           +
                          MIN(0)                           +
                          DFT(*NO)                         +
                          RSTD(*YES)                       +
                          VALUES(*NO *YES)                 +
                          PROMPT('Change object description')

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
                          PROMPT('Object type')

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
                        PROMPT('Object-Source file')

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
                        PROMPT('Object-Source library')

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
                        PROMPT('Object-Source member')

             PARM       KWD(LIB       ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for library        (&LI)')

             PARM       KWD(OBJ       ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE) (*DFT))           +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for object         (&OB)')

             PARM       KWD(TYPECODE  ) TYPE(*CHAR)        +
                          LEN(6)                           +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for type cde       (&TY)')

             PARM       KWD(SRCLIB    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE) (*DFT))           +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for source library (&SL)')

             PARM       KWD(SRCFILE   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE) (*DFT))           +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for source file    (&SF)')

             PARM       KWD(SRCMBR    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE) (*DFT))           +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for source member  (&SM)')

             PARM       KWD(TESTLIB   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for test library   (&TL)')

             PARM       KWD(TESTOBJ   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for test object    (&TO)')

             PARM       KWD(TGTRLS    ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for target release (&TR)')

             PARM       KWD(FRMSRCLIB ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for from src.lib.  (&FL)')

             PARM       KWD(FRMSRCFILE) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for from src. file (&FF)')

             PARM       KWD(FRMSRCMBR ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for from src. mbr. (&FM)')

             PARM       KWD(USER0     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U0)')

             PARM       KWD(USER1     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U1)')

             PARM       KWD(USER2     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U2)')

             PARM       KWD(USER3     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U3)')

             PARM       KWD(USER4     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U4)')

             PARM       KWD(USER5     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U5)')

             PARM       KWD(USER6     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U6)')

             PARM       KWD(USER7     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U7)')

             PARM       KWD(USER8     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U8)')

             PARM       KWD(USER9     ) TYPE(*CHAR)        +
                          LEN(50)                          +
                          MIN(0)                           +
                          DFT(*NONE)                       +
                          SPCVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Value for user-def. par. (&U9)')

             PARM       KWD(USRDEFVAR ) TYPE(USRDEFVAR)    +
                          MIN(0)                           +
                          MAX(20)                          +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('User defined variables')

             PARM       KWD(LIBL      ) TYPE(LIBL)         +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Library list')

             PARM       KWD(USELIBL   ) TYPE(*LGL)         +
                          LEN(1)                           +
                          MIN(0)                           +
                          DFT(*NO)                         +
                          SPCVAL((*NO  '0')                +
                                 (*YES '1'))               +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Use library list implicitly')

             PARM       KWD(TAGSREQ   ) TYPE(*LGL)         +
                          LEN(1)                           +
                          MIN(0)                           +
                          DFT(*NO)                         +
                          SPCVAL((*NO  '0')                +
                                 (*YES '1'))               +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Pre-Comp. tags required')

             PARM       KWD(MSGF      ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          CONSTANT(STRPREPRC)

             PARM       KWD(EXICMDEXC ) TYPE(QEXICMDEXC)   +
                          DFT(*NONE)                       +
                          SNGVAL((*NONE))                  +
                          PMTCTL(*PMTRQS)                  +
                          PROMPT('Exit Program Command Execution')

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
                          PROMPT('Current library (&CL)')

             ELEM         TYPE(*CHAR)                      +
                          MIN(0)                           +
                          MAX(250)                         +
                          LEN(10)                          +
                          DFT(*NONE)                       +
                          SNGVAL((*NONE))                  +
                          PROMPT('Library list (&LL)')

 QEXICMDEXC: QUAL       TYPE(*NAME)                        +
                          LEN(10)
             QUAL       TYPE(*NAME)                        +
                          LEN(10)                          +
                          SPCVAL((*LIBL) (*CURLIB))        +
                          PROMPT('Library')

 QUAL1:      QUAL       TYPE(*NAME)                        +
                          LEN(10)                          +
                          MIN(1)
             QUAL       TYPE(*NAME)                        +
                          LEN(10)                          +
                          MIN(1)                           +
                          PROMPT('Library')

 PMTCTL1:    PMTCTL     CTL(CHGOBJD) COND((*EQ '*YES'))

 /* ------------------------- */
 /* Check dependencies        */
 /* ------------------------- */

 /* ... Create Event File         */
 /*     ... Option = *EVENTF      */
             DEP        CTL(&OPTION *EQ '*EVENTF') +
                          PARM((&LIB *NE '*NONE')  +
                               (&OBJ *NE '*NONE')) +
                          NBRTRUE(*ALL) MSGID(PRZ0027)

 /* ... Change object description */
 /*     ... Object type           */
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

 /*     ... Object-Source file    */
             DEP        CTL(&CHGOBJD *EQ '*NO') +
                        PARM((&OBJSRCFILE       +
                              *EQ '*SAME'))     +
                        NBRTRUE(*ALL)           +
                        MSGID(PRZ0016)

 /*     ... Object-Source library    */
             DEP        CTL(&CHGOBJD *EQ '*NO') +
                        PARM((&OBJSRCLIB        +
                              *EQ '*SAME'))     +
                        NBRTRUE(*ALL)           +
                        MSGID(PRZ0017)

 /*     ... Object-Source member     */
             DEP        CTL(&CHGOBJD *EQ '*NO') +
                        PARM((&OBJSRCMBR        +
                              *EQ '*SAME'))     +
                        NBRTRUE(*ALL)           +
                        MSGID(PRZ0018)

