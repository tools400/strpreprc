     /*-----------------------------------------------------------------------*/
     /* STRPREPRC Compile Options:                                            */
     /* >>PRE-COMPILER<<                                                      */
     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI);                    */
     /*   >>CMD<<     CRTBNDCL   PGM(QTEMP/&OB) +                             */
     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
     /*               TEXT('Tool: STRPREPRC  (Start Pre-Processor) Ger');     */
     /*   >>EXECUTE<<                                                         */
     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
     /* >>END-PRE-COMPILER<<                                                  */
     /*-----------------------------------------------------------------------*/
             PGM        PARM(&LIB)

             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJ) TYPE(*CHAR) LEN(10) VALUE('STRPREPRC')

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0001                    */
     /* Falsche Reihenfolge im Betriebsmodus.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Falsche Reihenfolge im Betriebsmodus.'                               +
                ) +
                SECLVL( +
'Hinweis  . . . . :  Aus der Betriebsart &1 kann nicht in die Betriebs-
art &2 umgeschaltet werden.'                                          +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 30) +
                    (*CHAR 30) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0002                    */
     /* Verarbeitung in Zeile &1 abgebrochen.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verarbeitung in Zeile &1 abgebrochen.'                               +
                ) +
                SECLVL( +
'Hinweis  . . . . :  Ist als fehlerhafte Programmzeilenummer 0,00 ange-
geben, so trat der Fehler bei der Prüfung der über gebenen Befehlszeic-
henkette auf.'                                                        +
                ) +
                SEV(50) +
                FMT( +
                    (*DEC 6 2) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0003                    */
     /* Parameteranweisung in der Betriebsart &1 unzulässig.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parameteranweisung in der Betriebsart &1 unzulässig.'                +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 30) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0004                    */
     /* Die Marke &1 ist außerhalb der Betriebsart &2 nicht erlaubt */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Marke &1 ist außerhalb der Betriebsart &2 nicht erlaubt.'        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 30) +
                    (*CHAR 30) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0005                    */
     /* Ungültiges Fortsetzungszeichen &1 in Zeile &2 gefunden.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültiges Fortsetzungszeichen &1 in Zeile &2 gefunden.'             +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 10) +
                    (*DEC 6 2) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0006                    */
     /* Das Ende des Schlüsselwortes &1 konnte nicht gefunden werde */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Das Ende des Schlüsselwortes &1 konnte nicht gefunden werden.'       +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0007                    */
     /* Befehlszeichenfolge ist zu lang.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Befehlszeichenfolge ist zu lang.'                                    +
                ) +
                SECLVL( +
'Hinweis  . . . . :  Die maximale Länge einer Befehlszeichenfolge darf-
 &1 Zeichen nicht überschreiten.'                                     +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 10 0) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0008                    */
     /* Das Zeilenendekennzeichen konnte nicht gefunden werden.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Das Zeilenendekennzeichen konnte nicht gefunden werden.'             +
                ) +
                SECLVL( +
'Fehlerbeseitigung:  Fügen Sie ein Zeilenendekennzeichen in die Zeile -
&1 ein. &N &N Gültige Zeilendenekennzeichen sind: &B &B '';'' = Zeilen-
ende &B ''+'' = Fortsetzungszeile ohne Leerzeichen &B ''-'' = Fortsetz-
ungszeile mit Leerzeichen.'                                           +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 6 2) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0009                    */
     /* Unbekannter Wert "&1" für Fortsetzungszeichen gefunden.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unbekannter Wert "&1" für Fortsetzungszeichen gefunden.'             +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0010                    */
     /* Modus für Marke &1 nicht definiert.                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modus für Marke &1 nicht definiert.'                                 +
                ) +
                SECLVL( +
'Fehlerbeseitigung:  Definieren des Betriebsmodus für die Marke &1 in -
der Funktion f_tagToMode.'                                            +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 30) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0011                    */
     /* Die Datensatzlänge der Eingabedatei ist zu lang.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Datensatzlänge der Eingabedatei ist zu lang.'                    +
                ) +
                SECLVL( +
'Ursache  . . . . :  Die Datensatzlänge der Datei &3/&4 beträgt &1 Byt-
e. Die maximale Datensatzlänge ist auf &2 Byte begrenzt. &N Fehlerbese-
itigung:  Wählen Sie eine Eingabedatei aus, deren Datensatzlänge nicht-
 größer als &2 Byte ist.'                                             +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 10 0) +
                    (*DEC 10 0) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0012                    */
     /* Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.'            +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0013                    */
     /* Fehler beim Öffnen der Steuerdatei &2/&1, Teildatei &3.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fehler beim Öffnen der Steuerdatei &2/&1, Teildatei &3.'             +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0014                    */
     /* Auszuführender Befehl fehlt. Weitere Verarbeitung nicht mög */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Auszuführender Befehl fehlt. Weitere Verarbeitung nicht möglich.'    +
                ) +
                SECLVL( +
'Ursache  . . . . :  Der Parameter CMD() wurde mit Leerzeichen übergeb-
en und es wurde kein Schlüsselwort >>CRTCMD<< in der Quellenteildatei -
gefunden.  &N Fehlerbeseitigung:  Angeben Parameter CMD() oder einfüge-
n Schlüsselwort >>CRTCMD<< in der Quellenteildatei.'                  +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0015                    */
     /* Fehler im Erstellungsbefehl gefunden.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fehler im Erstellungsbefehl gefunden.'                               +
                ) +
                SECLVL( +
'Befehl . . . . . :  &1'                                              +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 512) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0016                    */
     /* Der Parameter 'OBJSRCFILE' ist nicht zulässig, wenn CHGOBJD */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Der Parameter ''OBJSRCFILE'' ist nicht zulässig, wenn CHGOBJD(*NO) an-
gegeben ist.'                                                         +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0017                    */
     /* Der Parameter 'OBJSRCLIB' ist nicht zulässig, wenn CHGOBJD( */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Der Parameter ''OBJSRCLIB'' ist nicht zulässig, wenn CHGOBJD(*NO) ang-
egeben ist.'                                                          +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0018                    */
     /* Der Parameter 'OBJSRCMBR' ist nicht zulässig, wenn CHGOBJD( */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Der Parameter ''OBJSRCMBR'' ist nicht zulässig, wenn CHGOBJD(*NO) ang-
egeben ist.'                                                          +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0019                    */
     /* Der Parameter 'OBJTYPE' ist nicht zulässig, wenn CHGOBJD(*N */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Der Parameter ''OBJTYPE'' ist nicht zulässig, wenn CHGOBJD(*NO) angeg-
eben ist.'                                                            +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0020                    */
     /* Der Parameter 'OBJTYPE' muss angegeben werden, wenn CHGOBJD */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Der Parameter ''OBJTYPE'' muss angegeben werden, wenn CHGOBJD(*YES) a-
ngegeben ist.'                                                        +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0021                    */
     /* Befehl CHGOBJDA nicht gefunden oder unvollständig.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Befehl CHGOBJDA nicht gefunden oder unvollständig.'                  +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0022                    */
     /* Verarbeitung abgebrochen.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verarbeitung abgebrochen.'                                           +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0023                    */
     /* Fehlender Wert für Variable an Position &1 des auszuführend */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fehlender Wert für Variable an Position &1 des auszuführenden Befehls-
.'                                                                    +
                ) +
                SECLVL( +
'Befehl . . . . . :  &2'                                              +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 10 0) +
                    (*CHAR 512) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0024                    */
     /* Keine Pre-Compiler Anweisungen in Quellendatei &2/&1, Teild */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Pre-Compiler Anweisungen in Quellendatei &2/&1, Teildatei &3 ge-
funden.'                                                              +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0025                    */
     /* EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konn */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'EVFEVENT Datei in Bibliothek &1 oder das Job Protokoll konnte nicht g-
eöffnet werden.'                                                      +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0026                    */
     /* EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'EVFEVENT Datei konnte nicht zur Ausgabe vorbereitet werden.'         +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0027                    */
     /* Wenn die Option '*EVENTF' angegeben ist, müssen auch die Pa */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wenn die Option ''*EVENTF'' angegeben ist, müssen auch die Parameter -
LIB() und OBJ() angegeben werden.'                                    +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0028                    */
     /* Erstellungsbefehl nicht gefunden in Quellendatei &2/&1, Tei */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Erstellungsbefehl nicht gefunden in Quellendatei &2/&1, Teildatei &3.-
'                                                                     +
                ) +
                SECLVL( +
'Ursache  . . . . :  Die Teildatei enthält keine Pre-Compiler Anweisun-
gen und es wurde kein Erstellungsbefehl im Parameter ''Auszuführender -
Befehl'' (CMD) angegeben.'                                            +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0029                    */
     /* &1                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'&1'                                                                  +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 70) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0030                    */
     /* Die Option *ADDJOBLOG ist nur in Verbindung mit *EVENTF zul */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Option *ADDJOBLOG ist nur in Verbindung mit *EVENTF zulässig.'   +
                ) +
                SEV(30) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0031                    */
     /* Ungültige INCLUDE Marke in Zeile &1 gefunden.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültige INCLUDE Marke in Zeile &1 gefunden.'                       +
                ) +
                SECLVL( +
'Ursache  . . . . :  Es fehlt entweder die Datei oder die Teildatei. D-
as richtige Format ist:&P >>INCLUDE<< [Bibliothek]/Datei Teildatei;'  +
                ) +
                SEV(30) +
                FMT( +
                    (*DEC 6 2) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0032                    */
     /* Verschachtelte INCLUDE Marke in Zeile &4 der Datei &2/&1, T */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verschachtelte INCLUDE Marke in Zeile &4 der Datei &2/&1, Teildatei &-
3 gefunden.'                                                          +
                ) +
                SECLVL( +
'Ursache  . . . . :  Mehrfach verschachtelte INCLUDE Marken sind nicht-
 erlaubt.'                                                            +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*DEC 6 2) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0033                    */
     /* STRPREPRC: Objekt erstellt.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'STRPREPRC: Objekt erstellt.'                                         +
                ) +
                SEV(10) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0034                    */
     /* STRPREPRC: Fehlernachricht &1 wurde aufgrund von MONMSG ign */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'STRPREPRC: Fehlernachricht &1 wurde aufgrund von MONMSG ignoriert.'  +
                ) +
                SEV(10) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0035                    */
     /* Bibliothek &1 nicht gefunden.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothek &1 nicht gefunden.'                                       +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0036                    */
     /* Datei &1 in Bibliothek &2 nicht gefunden.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei &1 in Bibliothek &2 nicht gefunden.'                           +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0037                    */
     /* Teildatei &3 von Datei &1 in Bibliothek &2 nicht gefunden.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Teildatei &3 von Datei &1 in Bibliothek &2 nicht gefunden.'          +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0038                    */
     /* Die Parameter USESRCFILE und USESRCMBR können nicht mit dem */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Parameter USESRCFILE und USESRCMBR können nicht mit dem Parameter-
 USESRCSTMF angegeben werden.'                                        +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 70) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0039                    */
     /* Entweder USESRCFILE und USESRCMBR oder USESRCSTMF angeben.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Entweder USESRCFILE und USESRCMBR oder USESRCSTMF angeben.'          +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 70) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0040                    */
     /* Wert *DFT ist unzulässig für SRCFILE, SRCLIB und SRCMBR, we */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert *DFT ist unzulässig für SRCFILE, SRCLIB und SRCMBR, wenn USESRCS-
TMF angegeben ist.'                                                   +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 70) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0041                    */
     /* Datei &1 kann nicht geöffnet werden.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei &1 kann nicht geöffnet werden.'                                +
                ) +
                SECLVL( +
'Hinweis  . . . . :  &2 - &3'                                         +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 512) +
                    (*CHAR 10) +
                    (*CHAR 50) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0042                    */
     /* Die Datensatzlänge der IFS Datei ist zu lang.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Datensatzlänge der IFS Datei ist zu lang.'                       +
                ) +
                SECLVL( +
'Ursache  . . . . :  Die Datensatzlänge der IFS Datei beträgt &1 Byte.-
 Die maximale Datensatzlänge ist auf &2 Byte begrenzt. &N Fehlerbeseit-
igung:  Wählen Sie eine Eingabedatei aus, deren Datensatzlänge nicht g-
rößer als &2 Byte ist. Der Name der Datei ist: &N Datei  . . . . . :  -
&4 &N Verzeichnis  . . :  &4'                                         +
                ) +
                SEV(40) +
                FMT( +
                    (*DEC 10 0) +
                    (*DEC 10 0) +
                    (*CHAR 256) +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0043                    */
     /* Datei nicht gefunden: &1                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei nicht gefunden: &1.'                                           +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

             RCLRSC LVL(*)

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0044                    */
     /* Erstellungsbefehl nicht gefunden in Quellendatei &1         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Erstellungsbefehl nicht gefunden in Quellendatei &1'                 +
                ) +
                SECLVL( +
'Fehlerbeseitigung:  Hinzufügen Erstellungsbefehl. &N Datei  . . . . .-
 :  &2 &N Verzeichnis  . . :  &1'                                     +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 256) +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0045                    */
     /* Keine Pre-Compiler Anweisungen in Quellendatei &2           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Pre-Compiler Anweisungen in Quellendatei &2'                   +
                ) +
                SECLVL( +
'Fehlerbeseitigung:  Hinzufügen Pre-Compiler Anweisungen. &N Datei  . -
. . . . :  &2 &N Verzeichnis  . . :  &1'                              +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 256) +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

             ENDPGM
