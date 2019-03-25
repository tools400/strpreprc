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
'Falsche Reihenfolge im Betriebsmodus.'                               +
                ) +
                SECLVL(+
'Hinweis . . . . :   Aus der Betriebsart &1 kann nicht in die Betriebs-
art &2 umgeschaltet werden.'                                          +
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
'Verarbeitung in Zeile &1 abgebrochen.'                               +
                ) +
                SECLVL(+
'Hinweis . . . . :   Ist als fehlerhafte Programmzeilenummer 0,00 ange-
geben, so trat der Fehler bei der Prüfung der über gebenen Befehlszeic-
henkette auf.'                                                        +
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
'Parameteranweisung in der Betriebsart &1 unzulässig.'                +
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
'Die Marke &1 ist außerhalb der Betriebsart &2 nicht erlaubt.'        +
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
'Ungültiges Fortsetzungszeichen &1 in Zeile &2 gefunden.'             +
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
'Das Ende des Schlüsselwortes &1 konnte nicht gefunden werden.'       +
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
'Befehlszeichenfolge ist zu lang.'                                    +
                ) +
                SECLVL(+
'Hinweis . . . . :   Die maximale Länge einer Befehlszeichenfolge darf-
 &1 Zeichen nicht überschreiten.'                                     +
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
'Das Zeilenendekennzeichen konnte nicht gefunden werden.'             +
                ) +
                SECLVL(+
'Fehlerbeseitigung :   Fügen Sie ein Zeilenendekennzeichen in die Zeil-
e &1 ein. &N &N Gültige Zeilendenekennzeichen sind: &B &B '';'' = Zeil-
enende &B ''+'' = Fortsetzungszeile ohne Leerzeichen &B ''-'' = Fortse-
tzungszeile mit Leerzeichen.'                                         +
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
'Unbekannter Wert "&1" für Fortsetzungszeichen gefunden.'             +
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
'Modus für Marke &1 nicht definiert.'                                 +
                ) +
                SECLVL(+
'Fehlerbeseitigung :   Definieren des Betriebsmodus für die Marke &1 i-
n der Funktion f_tagToMode.'                                          +
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
'Die Datensatzlänge der Eingabedatei ist zu lang.'                    +
                ) +
                SECLVL(+
'Ursache . . . . . :   Die Datensatzlänge der Datei &3/&4 beträgt &1 B-
yte. Die maximale Datensatzlänge ist auf &2 Byte begrenzt. &N Fehlerbe-
seitigung :   Wählen Sie eine Eingabedatei aus, deren Datensatzlänge n-
icht größer als &2 Byte ist.'                                         +
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
'Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.'            +
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
'Fehler beim Öffnen der Steuerdatei &2/&1, Teildatei &3.'             +
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
'Auszuführender Befehl fehlt. Weitere Verarbeitung nicht möglich.'    +
                ) +
                SECLVL(+
'Ursache . . . . . :   Der Parameter CMD() wurde mit Leerzeichen überg-
eben und es wurde kein Schlüsselwort >>CRTCMD<< in der Quellenteildate-
i gefunden.  &N Fehlerbeseitigung :   Angeben Parameter CMD() oder ein-
fügen Schlüsselwort >>CRTCMD<< in der Quellenteildatei.'              +
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
'Fehler im Erstellungsbefehl gefunden.'                               +
                ) +
                SECLVL(+
'Fehlerhafter Befehl:   &1'                                           +
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
'Der Parameter ''OBJSRCFILE'' ist nicht zulässig, wenn CHGOBJD(*NO) an-
gegeben ist.'                                                         +
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
'Der Parameter ''OBJSRCLIB'' ist nicht zulässig, wenn CHGOBJD(*NO) ang-
egeben ist.'                                                          +
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
'Der Parameter ''OBJSRCMBR'' ist nicht zulässig, wenn CHGOBJD(*NO) ang-
egeben ist.'                                                          +
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
'Der Parameter ''OBJTYPE'' ist nicht zulässig, wenn CHGOBJD(*NO) angeg-
eben ist.'                                                            +
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
'Der Parameter ''OBJTYPE'' muss angegeben werden, wenn CHGOBJD(*YES) a-
ngegeben ist.'                                                        +
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
'Befehl CHGOBJDA nicht gefunden oder unvollständig.'                  +
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
'Verarbeitung abgebrochen.'                                           +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0023                    */
     /* Fehlender Wert für Variable &1.                             */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0023) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0023) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Fehlender Wert für Variable an Position &1 des auszuführenden -
Befehls.'                                                             +
                ) +
                SECLVL(+
'Fehlerhafter Befehl:   &2'                                           +
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
     /* Keine Pre-Compiler Anweisungen in Quellendatei &2/&1, Teild */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0024) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0024) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Keine Pre-Compiler Anweisungen in Quellendatei &2/&1, Teildatei &3 ge+
funden.'                                                              +
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
'EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konnte nicht g+
eöffnet werden.'                                                      +
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
'EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.'          +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0027                    */
     /* Wenn die Option '*EVENTF' angegeben ist, müssen auch die Pa */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0027) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0027) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Wenn die Option ''*EVENTF'' angegeben ist, müssen auch die Parameter -
LIB() und OBJ() angegeben werden.'                                    +
                ) +
                SEV(40) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0028                    */
     /* Erstellungsbefehl nicht gefunden in Quellendatei &2/&1, Tei */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0028) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0028) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Erstellungsbefehl nicht gefunden in Quellendatei &2/&1, Teildatei &3.-
'                                                                     +
                ) +
                SECLVL(+
'Ursache . . . . . :   Die Teildatei enthält keine Pre-Compiler Anweis-
ungen und es wurde kein Erstellungsbefehl im Parameter ''Auszuführende-
r Befehl'' (CMD) angegeben.'                                          +
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
'Die Option *ADDJOBLOG ist nur in Verbindung mit *EVENTF zulässig.'   +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0070) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0031                    */
     /* Die Parameter USESRCFILE und USESRCMBR können nicht mit dem */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0031) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0031) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Die Parameter USESRCFILE und USESRCMBR können nicht mit dem Parameter-
 USESRCSTMF angegeben werden.'                                        +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0070) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0032                    */
     /* Entweder USESRCFILE und USESRCMBR oder USESRCSTMF angeben.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0032) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0032) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Entweder USESRCFILE und USESRCMBR oder USESRCSTMF angeben.'          +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0070) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0033                    */
     /* Wert *DFT ist unzulässig für SRCFILE, SRCLIB und SRCMBR, we */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0033) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0033) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Wert *DFT ist unzulässig für SRCFILE, SRCLIB und SRCMBR, wenn USESRCS-
TMF angegeben ist.'                                                   +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0070) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0034                    */
     /* Datei &1 kann nicht geöffnet werden.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0034) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0034) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Datei &1 kann nicht geöffnet werden.'                                +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 0512) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0035                    */
     /* Bibliothek &1 nicht gefunden.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0035) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0035) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Bibliothek &1 nicht gefunden.'                                       +
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
     /* Datei &1 in Bibliothek &2 nicht gefunden.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0036) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0036) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Datei &1 in Bibliothek &2 nicht gefunden.'                           +
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
     /* Teildatei &3 von Datei &1 in Bibliothek &2 nicht gefunden.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0037) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0037) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Teildatei &3 von Datei &1 in Bibliothek &2 nicht gefunden.'          +
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

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0038                    */
     /* Keine Pre-Compiler Anweisungen in Quellendatenstromdatei &1 */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(PRZ0038) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0038) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Keine Pre-Compiler Anweisungen in Quellendatenstromdatei &1 gefunden.-
'                                                                     +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 512) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0039                    */
     /* Object creation command not found in member &3 of file &2/& */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0039) MSGF(&LI/STRPREPRC)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0039) +
                MSGF(&LI/STRPREPRC) +
                MSG(+
'Erstellungsbefehl nicht gefunden in Quellendatenstromdatei &1.'      +
                ) +
                SECLVL(+
'Ursache . . . . . :   Die Quellendatenstromdatei enthält keine Pre-Co-
mpiler Anweisungen und es wurde kein Erstellungsbefehl im Parameter ''-
Auszuführender Befehl'' (CMD) angegeben.'                             +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 512) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

             ENDPGM
