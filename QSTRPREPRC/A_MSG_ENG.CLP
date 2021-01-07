             PGM        PARM(&LI)

             DCL        VAR(&LI) TYPE(*CHAR) LEN(10)

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0001                    */
     /* Falsche Reihenfolge im Betriebsmodus.                       */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0001) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0001) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Wrong mode sequence.'                                                +
                ) +
                SECLVL(+
'Cause . . . . . :   It is not possible to  switch from mode &1 to -
mode &2 directly. Before changing to mode &2 mode &1 must be ended with -
the corresponding END-xxx tag.' +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 030) +
                    (*CHAR 030) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0002                    */
     /* Verarbeitung in Zeile &1 abgebrochen.                       */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0002) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0002) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Execution canceled in line &1.'                                      +
                ) +
                SECLVL(+
'Information . . :   If the line number is 0,00, then the error occured -
during the creation command was checked.' +
                ) +
                SEV(50) +
                FMT( +
                    (*DEC 006 2) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0003                    */
     /* Parameteranweisung in der Betriebsart &1 unzulässig.        */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0003) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0003) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Parameter tags are not allowed in mode &1.'                     +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR 030) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0004                    */
     /* Die Marke &1 ist außerhalb der Betriebsart &2 nicht erlaubt */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0004) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0004) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'The tag &1 is not allowed outside mode &2.'                      +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR 030) +
                    (*CHAR 030) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0005                    */
     /* Ungültiges Fortsetzungszeichen &1 in Zeile &2 gefunden.     */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0005) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0005) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Unkown continuation character &1 in line &2.'             +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 010) +
                    (*DEC 006 2) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0006                    */
     /* Das Ende des Schlüsselwortes &1 konnte nicht gefunden werde */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0006) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0006) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'End of keyword &1 not found.'                          +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0007                    */
     /* Befehlszeichenfolge ist zu lang.                            */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0007) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0007) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Creation command too long.'                                          +
                ) +
                SECLVL(+
'Information . . :   The maximum length of the creation command is -
 &1 byte.'                                                            +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 010 0) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0008                    */
     /* Das Zeilenendekennzeichen konnte nicht gefunden werden.     */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0008) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0008) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'The end-of-line character could not be found.'                       +
                ) +
                SECLVL(+
'Recovery  . . . . :   Add an end-of-line character in line &1.-
&N &N Valid end-of-line characters are: &B &B '';'' = End-
-of-line &B ''+'' = continuation without blanks &B ''-'' = Cont-
inuation with blanks.'                                                +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 006 2) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0009                    */
     /* Unbekannter Wert "&1" für Fortsetzungszeichen gefunden.     */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0009) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0009) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Unknown continuation character "&1".'                                +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0010                    */
     /* Modus für Marke &1 nicht definiert.                         */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0010) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0010) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Mode for tag &1 not defined.'                                 +
                ) +
                SECLVL(+
'Recovery  . . . . :   Define a mode for tag &1 in-
the internal functiono f_tagToMode.'                                  +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 030) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0011                    */
     /* Die Datensatzlänge der Eingabedatei ist zu lang.            */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0011) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0011) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Record length of source file exceeds maximum.'                       +
                ) +
                SECLVL(+
'Cause . . . . . . :   The record length of file &3/&4 is &1 y-
yte. The maximum record length is &2 byte. &N Recovery-
  . . . . :   Reduce the record length of the source file.' +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 010 0) +
                    (*DEC 010 0) +
                    (*CHAR 010) +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0012                    */
     /* Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.    */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0012) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0012) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Error when opening source file &2/&1, source member &3.'            +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 010) +
                    (*CHAR 010) +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0013                    */
     /* Fehler beim Öffnen der Steuerdatei &2/&1, Teildatei &3.     */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0013) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0013) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Error when opening control file &2/&1, member &3.'             +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 010) +
                    (*CHAR 010) +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0014                    */
     /* Auszuführender Befehl fehlt. Weitere Verarbeitung nicht mög */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0014) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0014) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Missing creation command.'    +
                ) +
                SECLVL(+
'Cause . . . . . . :   There was no creation command passed to STRPREPRC -
and there is no >>CRTCMD<< tag in the source member.-
 &N Recovery  . . . . :   Pass a creation command to STRPREPRC or -
add a >>CRTCMD<< tag to the source file.'                             +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0015                    */
     /* Fehler im Erstellungsbefehl gefunden.                       */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0015) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0015) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Error in the creation command. Execution ended in error.'            +
                ) +
                SECLVL(+
'Creation command:   &1'                                           +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 512) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0016                    */
     /* Der Parameter 'OBJSRCFILE' ist nicht zulässig, wenn CHGOBJD */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0016) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0016) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Parameter ''OBJSRCFILE'' not allowed if CHGOBJD(*NO) has been -
specified.'                                                           +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0017                    */
     /* Der Parameter 'OBJSRCLIB' ist nicht zulässig, wenn CHGOBJD( */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0017) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0017) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Parameter ''OBJSRCLIB'' not allowed if CHGOBJD(*NO) has been -
specified.'                                                           +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0018                    */
     /* Der Parameter 'OBJSRCMBR' ist nicht zulässig, wenn CHGOBJD( */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0018) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0018) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Parameter ''OBJSRCMBR'' not allowed if CHGOBJD(*NO) has been -
specified.'                                                           +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0019                    */
     /* Der Parameter 'OBJTYPE' ist nicht zulässig, wenn CHGOBJD(*N */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0019) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0019) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Parameter ''OBJTYPE'' not allowed if CHGOBJD(*NO) has been -
specified.'                                                           +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0020                    */
     /* Der Parameter 'OBJTYPE' muss angegeben werden, wenn CHGOBJD */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0020) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0020) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Parameter ''OBJTYPE'' must be entered if CHGOBJD(*YES) has been -
specified.'                                                           +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0021                    */
     /* Befehl CHGOBJDA nicht gefunden oder unvollständig.          */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0021) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0021) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Command CHGOBJDA not found.'                                          +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0022                    */
     /* Verarbeitung abgebrochen.                                   */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0022) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0022) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Execution canceled. See joblog for details.'                         +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0023                    */
     /* Missing value for replacement variable &1.                  */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0023) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0023) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Missing value for replacement variable at position &1 of command -
string.'                                                              +
                ) +
                SECLVL(+
'Creation command:   &2'                                           +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 010 0) +
                    (*CHAR 512) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0024                    */
     /* No Pre-Compiler instructions found in source file &2/&1, so */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0024) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0024) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'No Pre-Compiler instructions found in source file &2/&1, source membe+
r &3.'                                                                +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 010) +
                    (*CHAR 010) +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0025                    */
     /* Could not open EVFEVENT file or job log.                    */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0025) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0025) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Could not open EVFEVENT file in library &1 or job log.'              +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0026                    */
     /* Could not prepare the event file.                           */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0026) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0026) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Could not prepare the event file.'                                   +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0027                    */
     /* When option '*EVENTF' is specified, parameters LIB() and OB */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0027) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0027) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'When option ''*EVENTF'' is specified, parameters LIB() and OBJ() must-
 be specified, too.'                                                  +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0028                    */
     /* Object creation command not found in member &3 of file &2/& */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0028) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0028) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Object creation command not found in member &3 of file &2/&1.'       +
                ) +
                SECLVL(+
'Cause . . . . . . :   The source member does not contain pre-compiler-
 tags and no creation command had been specified at parameter ''Creati-
on command'' (CMD).'                                                  +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 0010) +
                    (*CHAR 0010) +
                    (*CHAR 0010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0029                    */
     /* &1                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0029) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0029) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'&1'                                                                  +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0070) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0030                    */
     /* &1                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0030) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0030) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Option *ADDJOBLOG can only be used in conjunction with *EVENTF.'     +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0070) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0031                    */
     /* Invalid INCLUDE tag found in line &1.                       */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0031) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0031) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Invalid INCLUDE tag found in line &1.'                               +
                ) +
                SECLVL(+
'Cause . . . . . :   Either the file or der member name is missing. Th-
e expected format is: &P >>INCLUDE<< [Library]/File Member;'          +
                ) +
                SEV(30) +
                FMT( +
                    (*DEC 006 2) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0032                    */
     /* Nested INCLUDE tag found in line &4 of file &2/&1, member & */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0032) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0032) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Nested INCLUDE tag found in line &4 of file &2/&3, member &3.'       +
                ) +
                SECLVL(+
'Cause . . . . . :   Nested INCLUDE tags are not allowed.'            +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 010) +
                    (*CHAR 010) +
                    (*CHAR 010) +
                    (*DEC 006 2) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0033                    */
     /* STRPREPRC: Object created.                                  */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0033) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0033) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'STRPREPRC: Object created.'                                          +
                ) +
                SEV(10) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0034                    */
     /* STRPREPRC: Error message &1 ignored due to MONMSG.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0034) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0034) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'STRPREPRC: Error message &1 ignored due to MONMSG.'                  +
                ) +
                SEV(10) +
                FMT( +
                    (*CHAR 0010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0035                    */
     /* Library &1 not found.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0035) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0035) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Library &1 not found.'                                               +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0036                    */
     /* File &1 in library &2 not found.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0036) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0036) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'File &1 in library &2 not found.'                                    +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0010) +
                    (*CHAR 0010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0037                    */
     /* Member &3 file &1 in library &2 not found.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0037) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0037) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Member &3 file &1 in library &2 not found.'                          +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0010) +
                    (*CHAR 0010) +
                    (*CHAR 0010) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

             ENDPGM
