     /*-----------------------------------------------------------------------*/
     /* STRPREPRC Compile Options:                                            */
     /* >>PRE-COMPILER<<                                                      */
     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI);                    */
     /*   >>CMD<<     CRTBNDCL   PGM(QTEMP/&OB) +                             */
     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
     /*               TEXT('Tool: STRPREPRC  (Start Pre-Processor) Eng');     */
     /*   >>EXECUTE<<                                                         */
     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
     /* >>END-PRE-COMPILER<<                                                  */
     /*-----------------------------------------------------------------------*/
             PGM        PARM(&LIB)

             DCL        VAR(&LIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJ) TYPE(*CHAR) LEN(10) VALUE('STRPREPRC')

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0001                    */
     /* Wrong mode sequence.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wrong mode sequence.'                                                +
                ) +
                SECLVL( +
'Cause  . . . . . :  It is not possible to  switch from mode &1 to mod-
e &2 directly. Before changing to mode &2 mode &1 must be ended with t-
he corresponding END-xxx tag.'                                        +
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
     /* Execution canceled in line &1.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Execution canceled in line &1.'                                      +
                ) +
                SECLVL( +
'Information  . . :  If the line number is 0,00, then the error occure-
d during the creation command was checked.'                           +
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
     /* Parameter tags are not allowed in mode &1.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parameter tags are not allowed in mode &1.'                          +
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
     /* The tag &1 is not allowed outside mode &2.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'The tag &1 is not allowed outside mode &2.'                          +
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
     /* Unkown continuation character &1 in line &2.                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unkown continuation character &1 in line &2.'                        +
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
     /* End of keyword &1 not found.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'End of keyword &1 not found.'                                        +
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
     /* Creation command too long.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Creation command too long.'                                          +
                ) +
                SECLVL( +
'Information  . . :  The maximum length of the creation command is  &1-
 byte.'                                                               +
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
     /* The end-of-line character could not be found.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'The end-of-line character could not be found.'                       +
                ) +
                SECLVL( +
'Recovery . . . . :  Add an end-of-line character in line &1.&N &N Val-
id end-of-line characters are: &B &B '';'' = End-of-line &B ''+'' = co-
ntinuation without blanks &B ''-'' = Continuation with blanks.'       +
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
     /* Unknown continuation character "&1".                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unknown continuation character "&1".'                                +
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
     /* Mode for tag &1 not defined.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mode for tag &1 not defined.'                                        +
                ) +
                SECLVL( +
'Recovery . . . . :  Define a mode for tag &1 inthe internal functiono-
 f_tagToMode.'                                                        +
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
     /* Record length of source file exceeds maximum.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record length of source file exceeds maximum.'                       +
                ) +
                SECLVL( +
'Cause  . . . . . :  The record length of file &3/&4 is &1 yyte. The m-
aximum record length is &2 byte. &N Recovery . . . . :   Reduce the re-
cord length of the source file.'                                      +
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
     /* Error when opening source file &2/&1, source member &3.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error when opening source file &2/&1, source member &3.'             +
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
     /* Error when opening control file &2/&1, member &3.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error when opening control file &2/&1, member &3.'                   +
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
     /* Missing creation command.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Missing creation command.'                                           +
                ) +
                SECLVL( +
'Cause  . . . . . :  There was no creation command passed to STRPREPRC-
 and there is no >>CRTCMD<< tag in the source member. &N Recovery . . -
. . :  Pass a creation command to STRPREPRC or add a >>CRTCMD<< tag to-
 the source file.'                                                    +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0015                    */
     /* Error in the creation command. Execution ended in error.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error in the creation command. Execution ended in error.'            +
                ) +
                SECLVL( +
'Creation command :  &1'                                              +
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
     /* Parameter 'OBJSRCFILE' not allowed if CHGOBJD(*NO) has been */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parameter ''OBJSRCFILE'' not allowed if CHGOBJD(*NO) has been specifi-
ed.'                                                                  +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0017                    */
     /* Parameter 'OBJSRCLIB' not allowed if CHGOBJD(*NO) has been  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parameter ''OBJSRCLIB'' not allowed if CHGOBJD(*NO) has been specifie-
d.'                                                                   +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0018                    */
     /* Parameter 'OBJSRCMBR' not allowed if CHGOBJD(*NO) has been  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parameter ''OBJSRCMBR'' not allowed if CHGOBJD(*NO) has been specifie-
d.'                                                                   +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0019                    */
     /* Parameter 'OBJTYPE' not allowed if CHGOBJD(*NO) has been sp */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parameter ''OBJTYPE'' not allowed if CHGOBJD(*NO) has been specified.-
'                                                                     +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0020                    */
     /* Parameter 'OBJTYPE' must be entered if CHGOBJD(*YES) has be */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parameter ''OBJTYPE'' must be entered if CHGOBJD(*YES) has been speci-
fied.'                                                                +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0021                    */
     /* Command CHGOBJDA not found.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command CHGOBJDA not found.'                                         +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0022                    */
     /* Execution canceled. See joblog for details.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Execution canceled. See joblog for details.'                         +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0023                    */
     /* Missing value for replacement variable at position &1 of co */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Missing value for replacement variable at position &1 of command stri-
ng.'                                                                  +
                ) +
                SECLVL( +
'Creation command :  &2'                                              +
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
     /* No Pre-Compiler instructions found in source file &2/&1, so */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No Pre-Compiler instructions found in source file &2/&1, source membe-
r &3.'                                                                +
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
     /* Could not open EVFEVENT file in library &1 or job log.      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Could not open EVFEVENT file in library &1 or job log.'              +
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
     /* Could not prepare the event file.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Could not prepare the event file.'                                   +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0027                    */
     /* When option '*EVENTF' is specified, parameters LIB() and OB */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'When option ''*EVENTF'' is specified, parameters LIB() and OBJ() must-
 be specified, too.'                                                  +
                ) +
                SEV(40) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0028                    */
     /* Object creation command not found in member &3 of file &2/& */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Object creation command not found in member &3 of file &2/&1.'       +
                ) +
                SECLVL( +
'Cause  . . . . . :  The source member does not contain pre-compiler t-
ags and no creation command had been specified at parameter ''Creation-
 command'' (CMD).'                                                    +
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
     /* Option *ADDJOBLOG can only be used in conjunction with *EVE */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Option *ADDJOBLOG can only be used in conjunction with *EVENTF.'     +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 70) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0031                    */
     /* Invalid INCLUDE tag found in line &1.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid INCLUDE tag found in line &1.'                               +
                ) +
                SECLVL( +
'Cause  . . . . . :  Either the file or der member name is missing. Th-
e expected format is: &P >>INCLUDE<< [Library]/File Member;'          +
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
     /* Nested INCLUDE tag found in line &4 of file &2/&3, member & */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nested INCLUDE tag found in line &4 of file &2/&3, member &3.'       +
                ) +
                SECLVL( +
'Cause  . . . . . :  Nested INCLUDE tags are not allowed.'            +
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
     /* STRPREPRC: Object created.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'STRPREPRC: Object created.'                                          +
                ) +
                SEV(10) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0034                    */
     /* STRPREPRC: Error message &1 ignored due to MONMSG.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'STRPREPRC: Error message &1 ignored due to MONMSG.'                  +
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
     /* Library &1 not found.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Library &1 not found.'                                               +
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
     /* File &1 in library &2 not found.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File &1 in library &2 not found.'                                    +
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
     /* Member &3 file &1 in library &2 not found.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Member &3 file &1 in library &2 not found.'                          +
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
     /* The USESRCFILE and USESRCMBR parameters cannot be specified */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'The USESRCFILE and USESRCMBR parameters cannot be specified with the -
USESRCSTMF parameter.'                                                +
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
     /* Either USESRCFILE and USESRCMBR or USESRCSTMF must be speci */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Either USESRCFILE and USESRCMBR or USESRCSTMF must be specified.'    +
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
     /* Value *DFT is not allowed for SRCFILE, SRCLIB and SRCMBR wh */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Value *DFT is not allowed for SRCFILE, SRCLIB and SRCMBR when USESRCS-
TMF is specified.'                                                    +
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
     /* Unable to open file &1.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to open file &1.'                                             +
                ) +
                SECLVL( +
'Cause  . . . . . :  &2 - &3'                                         +
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
     /* Record length of IFS source file exceeds maximum.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record length of IFS source file exceeds maximum.'                   +
                ) +
                SECLVL( +
'Cause  . . . . . :  The record length of file &3/&4 is &1 byte. The m-
aximum record length is &2 byte. &N Recovery   . . . :  Select an inpu-
t file whose record length does not exceed &2 byte. &N File . . . . . -
. :  &4 &N Folder . . . . . :  &3'                                    +
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
     /* Stream file not found: &1                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Stream file not found &1.'                                           +
                ) +
                SEV(30) +
                FMT( +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PRZ0044                    */
     /* Object creation command not found in stream file: &2        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PRZ0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PRZ0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Object creation command not found in stream file: &2'                +
                ) +
                SECLVL( +
'Recovery   . . . :  Add object creation command. &N File . . . . . . -
:  &2 &N Folder . . . . . :  &1'                                      +
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
'No Pre-Compiler instructions found in source file &2'                +
                ) +
                SECLVL( +
'Recovery . . . . :  Add pre-compiler instructions. &N File  . . . . .-
 :  &2 &N Folder . . . . . :  &1'                                     +
                ) +
                SEV(40) +
                FMT( +
                    (*CHAR 256) +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(65535) +
                /*  -EOF-  */

             RCLRSC LVL(*)

             ENDPGM
