**free
//=====================================================================
//  STRPREPRC - SelfTest.
//=====================================================================
//  Command to create the service program:
//  RUCRTRPG TSTPGM(RPGUNIT/STRPREPRCT) SRCFILE(QSTRPREPRC)
//=====================================================================
//  Tools/400 STRPREPRC instructions:
//   >>PRE-COMPILER<<
//     >>CRTCMD<<  RUCRTRPG    TSTPGM(&LI/&OB) +
//                             SRCFILE(&SL/&SF) +
//                             SRCMBR(&SM);
//     >>COMPILE<<
//       >>PARM<< RPGPPOPT(*LVL2);
//       >>PARM<< DBGVIEW(*NONE);
//       >>PARM<< POPTION(*EVENTF);
//       >>PARM<< COMPILEOPT('DBGVIEW(*LIST)');
//       >>PARM<< BNDDIR(*N);
//       >>PARM<< MODULE(&LI/STRPREPRC2 +
//                       &LI/STRPREPRC4 +
//                       &LI/STRPREPRC5 +
//                       &LI/STRPREPRC6) +
//                BNDSRVPGM(&LI/BASICS1 +
//                          &LI/JOBLOG +
//                          &LI/EVENTF);
//     >>END-COMPILE<<
//     >>EXECUTE<<
//   >>END-PRE-COMPILER<<
//=====================================================================
ctl-opt NoMain Option(*SrcStmt : *NoDebugIO);

/include qinclude,TESTCASE                  iRPGUnit Test Suite
/include qbasics1,clib                      C Runtime Library

exec sql
  SET OPTION
    NAMING =*SQL, COMMIT = *NONE, CLOSQLCSR = *ENDACTGRP, DATFMT = *ISO, TIMFMT = *ISO,
    DFTRDBCOL = QTEMP, DYNDFTCOL = *YES;

// ------------------------------------------------------------
//  Imported Prototypes
// ------------------------------------------------------------
/include qstrpreprc,pstrprepr6
/include qbasics1,pbasics1

dcl-s BUFFER_SIZE int(10) import;

// ------------------------------------------------------------
//  Global Program Status.
// ------------------------------------------------------------

dcl-ds g_status qualified;
  srcSeq int(10);
  srcSeq2 int(10);
  sql likeds(sql_status_t) inz(*likeds);
end-ds;

dcl-ds sql_status_t qualified template;
  ignSQLWarn ind inz(*off);
end-ds;

// ------------------------------------------------------------
//  Global type templates.
// ------------------------------------------------------------
dcl-ds local_errCode_t qualified template;
  bytPrv       int(10) inz(%size(local_errCode_t));
  bytAvl       int(10) inz;
  excId        char(7) inz;
  reserved_1   char(1) inz;
  excDta       char(100) inz;
end-ds;

dcl-c STMF_UTF8 '/home/raddatz/temp/strpreprct.utf8';

dcl-c LINE_BEGIN '--- begin of data (LF) ---';
dcl-c LINE_1 '1. line öäü CR (short line)';
dcl-c LINE_2 '2. line öäü LF (longer line)';
dcl-c LINE_3 '3. line öäü CRLF (even longer line)';
dcl-c LINE_4 '4. line öäü LFCR (longest line ever)';
dcl-c LINE_END '---- end of data (./.) ----';

dcl-ds LINES qualified;
  data varchar(244) dim(6);
end-ds;

// ------------------------------------------------------------
//  Local data area (*LDA).
// ------------------------------------------------------------
dcl-ds g_LDA qualified dtaara(*LDA);
  library      char(10);
  object       char(10);
end-ds;

// ------------------------------------------------------------
//  Set up test suite.
// ------------------------------------------------------------
dcl-proc setUpSuite export;
  dcl-pi *n extproc(*dclcase) end-pi;

  clear LINES;
  LINES.data(1) = LINE_BEGIN;
  LINES.data(2) = LINE_1;
  LINES.data(3) = LINE_2;
  LINES.data(4) = LINE_3;
  LINES.data(5) = LINE_4;
  LINES.data(6) = LINE_END;

  p_setAppMsgFile('STRPREPRC': '*LIBL');

  if (not exist('QTEMP': 'RUNIT_TST': '*FILE'));
    runCmd('CRTSRCPF FILE(QTEMP/RUNIT_TST) RCDLEN(112) MBR(*NONE)');
  endif;

  // Compilable source member
  if (not exist('QTEMP': 'RUNIT_TST': '*FILE': 'TESTCASE'));
    runCmd('ADDPFM FILE(QTEMP/RUNIT_TST) MBR(TESTCASE) +
              TEXT(''STRPREPRD - SelfTest'') SRCTYPE(CLLE)');
  else;
    runCmd('CLRPFM FILE(QTEMP/RUNIT_TST) MBR(TESTCASE)');
  endif;

  // Helper source member
  if (not exist('QTEMP': 'RUNIT_TST': '*FILE': 'TESTCASE2'));
    runCmd('ADDPFM FILE(QTEMP/RUNIT_TST) MBR(TESTCASE2) +
              TEXT(''STRPREPRD - SelfTest'') SRCTYPE(CLLE)');
  else;
    runCmd('CLRPFM FILE(QTEMP/RUNIT_TST) MBR(TESTCASE2)');
  endif;

  if (exist('QTEMP': 'RUNIT_ERR': '*FILE'));
    runCmd('DLTF FILE(QTEMP/RUNIT_ERR)');
  endif;

  if (not exist('QTEMP': 'EVFEVENT': '*FILE'));
    runCmd('CRTPF FILE(QTEMP/EVFEVENT) RCDLEN(400) MAXMBRS(*NOMAX) CCSID(*HEX)');
    runCmd('RMVM FILE(QTEMP/EVFEVENT) MBR(*ALL)');
  endif;

  exec sql
    CREATE ALIAS qtemp.testmbr FOR qtemp.RUNIT_TST (TESTCASE);
  assert(not isSqlError(sqlState));

  exec sql
    CREATE ALIAS qtemp.testmbr2 FOR qtemp.RUNIT_TST (TESTCASE2);
  assert(not isSqlError(sqlState));

  exec sql
    CREATE ALIAS qtemp.eventfile FOR qtemp.EVFEVENT (TESTCASE);
  assert(not isSqlError(sqlState));

end-proc;

// ------------------------------------------------------------
//  Tear down test case.
// ------------------------------------------------------------
dcl-proc tearDownSuite export;
  dcl-pi *n extproc(*dclcase) end-pi;

  exec sql
    DROP ALIAS qtemp.testmbr;

  exec sql
    DROP ALIAS qtemp.testmbr2;

  exec sql
    DROP ALIAS qtemp.eventfile;

end-proc;

// ------------------------------------------------------------
//  Set up test case.
// ------------------------------------------------------------
dcl-proc setUp export;
  dcl-pi *n extproc(*dclcase) end-pi;

  exec sql
    DELETE FROM testmbr;
  setIgnSQLWarn(*on);
  assert(not isSqlError(sqlState));

  exec sql
    DELETE FROM testmbr2;
  setIgnSQLWarn(*on);
  assert(not isSqlError(sqlState));

  if (exist('QTEMP': 'EVFEVENT': '*FILE'));
    if (exist('QTEMP': 'EVFEVENT': '*FILE': 'TESTCASE'));
      exec sql
        DELETE FROM eventfile;
      setIgnSQLWarn(*on);
      assert(not isSqlError(sqlState));
    endif;
  endif;

  if (exist('QTEMP': 'RUNIT_TST': '*FILE'));
    if (exist('QTEMP': 'RUNIT_TST': '*FILE': 'DUMMY'));
      runCmd('RMVM FILE(QTEMP/RUNIT_TST) MBR(DUMMY)');
    endif;
  endif;

  clearLDA();

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF
//  Pre-command:
//    error + monmsg
//  Compile command:
//    *NONE
//  Post-command:
//    *NONE
//  Expected:
//    Empty EVFEVENT file, due to no errors (error ignored).
// ------------------------------------------------------------
dcl-proc test_MONMSG export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<     ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);           */');
  append('/*   >>MONMSG<<                                                     */');
  append('/*     >>MSGID<<   CPF7306;    /* Member not added */               */');
  append('/*   >>END-MONMSG<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

  assertLDA('': ''); // Job log entries are not added to the event file
                     // for pre- and post commands. Therefore no event file
                     // is created.

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *NOEVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    *NONE
//  Post-command:
//    *NONE
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_PreCmd_NOEVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*NOEVENTF *NOJOBLOG) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

  assertLDA('': '');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *NOEVENTF, *NOJOBLOG
//  Pre-command:
//    error
//  Compile command:
//    *NONE
//  Post-command:
//    *NONE
//  Expected:
//    Empty EVFEVENT file, due to STRPREPRC OPTION(*NOEVENTF).
// ------------------------------------------------------------
dcl-proc test_PreCmd_NOEVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*NOEVENTF *NOJOBLOG) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (001)');
  on-error;
  // Exception seen!
  endmon;

  assertEmpty();

  assertLDA('': '');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    *NONE
//  Post-command:
//    *NONE
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_PreCmd_EVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

  assertLDA('': ''); // Job log entries are not added to the event file
                     // for pre- and post commands. Therefore no event file
                     // is created.

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    error
//  Compile command:
//    *NONE
//  Post-command:
//    *NONE
//  Expected:
//    FILEID 001 (TESTCASE) with job log of pre-command.
// ------------------------------------------------------------
dcl-proc test_PreCmd_EVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (002)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPF7312': 'S'); // File not found

  assertNoJobLog();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    mo error
//  Compile command:
//    *NONE
//  Post-command:
//    *NONE
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_PreCmd_EVENTF_ADDJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

  assertLDA('': ''); // Job log entries are not added to the event file
                     // for pre- and post commands. Therefore no event file
                     // is created.

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    error
//  Compile command:
//    *NONE
//  Post-command:
//    *NONE
//  Expected:
//    FILEID 001 (TESTCASE) with job log of pre-command.
// ------------------------------------------------------------
dcl-proc test_PreCmd_EVENTF_ADDJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE)');
    fail('STRPREPRC should have thown an error (003)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('*NONE'); // *NONE, because of missing parameters SRCLIB, SRCFILE and SRCMBR
  assertMsgId('CPF7312': 'S'); // File not found
  assertMsgId('CPF7306': 'T'); // Member not added

  assertNoJobLog();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *NOEVENTF, *NOJOBLOG
//  Pre-command:
//    no error, no event file
//  Compile command:
//    error, no event file
//  Post-command:
//    *NONE
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_Execute_NOEVENTF_NOJOBLOG_NOEVENTF_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>EXECUTE<<                                                      */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*NOEVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

  assertLDA('': '');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *NOEVENTF, *NOJOBLOG
//  Pre-command:
//    no error, no event file
//  Compile command:
//    error, no event file
//  Post-command:
//    *NONE
//  Expected:
//    Empty EVFEVENT file, due to STRPREPRC OPTION(*NOEVENTF).
// ------------------------------------------------------------
dcl-proc test_Execute_NOEVENTF_NOJOBLOG_NOEVENTF_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*NOEVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  assertEmpty();

  assertLDA('': '');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, no event file
//  Post-command:
//    *NONE
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_NOEVENTF_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>EXECUTE<<                                                      */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    error, no event file
//  Post-command:
//    *NONE
//  Expected:
//    FILEID 001 (TESTCASE) with job log of compile command.
//    (replacement for compile listing)
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_NOEVENTF_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPF0821': 'T'); // Module not created
  assertMsgID('PRZ0029': 'S'); // STRPREPRZ messages

  assertNoJobLog();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// -----------------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, no event file
//  Post-command:
//    *NONE
//  Expected:
//    FILEID 001 (TESTCASE) with job log of compile command.
//    (replacement for compile listing)
// -----------------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_NOEVENTF_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE');
  assertMsgID('PRZ0029': 'W'); // STRPREPRZ warning messages, due to OPTION(*ADDJOBLOG).
  assertMsgID('PRZ0033': 'W'); // Object created.

  assertNoJobLog();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    error, no event file
//  Post-command:
//    *NONE
//  Expected:
//    FILEID 001 (TESTCASE) with job log of compile command.
//    (replacement for compile listing)
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_NOEVENTF_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE );                           */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPF0821': 'T'); // Module not created
  assertMsgID('PRZ0029': 'S'); // STRPREPRZ error messages

  assertNoJobLog();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, event file
//  Post-command:
//    *NONE
//  Expected:
//    FILEID 001 (TESTCASE) with compile messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_EVENTF_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0726': 'W'); // Variable &LIB declared but not referred to
  assertMsgID('CPD0791': 'I'); // No labels used in program

  assertNoJobLog();

  assertNoMsgId('PRZ0029');

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    error, event file
//  Post-command:
//    *NONE
//  Expected:
//    FILEID 001 (TESTCASE) with compile messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_EVENTF_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0081': 'S'); // Variable name required for parameter VAR.

  assertNoJobLog();

  assertNoMsgId('PRZ0029');

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    error, no event file
//  Post-command:
//    *NONE
//  Specials:
//    Module name has been overridden in STRPREPRC header.
//    Event file must be copied from TEST to TESTCASE.
//  Expected:
//    FILEID 001 (TESTCASE) with job log of compile command.
//    (replacement for compile listing)
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_EVENTF_ERROR_COPY export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>IMPORTANT<<                                                  */');
  append('/*     >>PARM<<  MODULE(&LI/TEST);                                  */');
  append('/*   >>END-IMPORTANT<<                                              */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0081': 'S'); // Variable name required for parameter VAR.

  assertNoJobLog();

  assertNoMsgId('PRZ0029');

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    error, no event file
//  Post-command:
//    *NONE
//  Specials:
//    Uses a different member for retrieving the STRPREPRC header and
//    module name has been overridden in STRPREPRC header.
//    Event file must be copied from TEST to TESTCASE.
//  Expected:
//    FILEID 001 (TESTCASE) with job log of compile command.
//    (replacement for compile listing)
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_EVENTF_OK_COPY export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append2('/* ---------------------------------------------------------------- */': 100);
  append2('/*     STRPREPRC header with compile instructions.                  */');
  append2('/* ---------------------------------------------------------------- */');
  append2('/* >>PRE-COMPILER<<                                                 */');
  append2('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append2('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append2('/*                        OUTPUT(*NONE);                            */');
  append2('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append2('/*   >>IMPORTANT<<                                                  */');
  append2('/*     >>PARM<<  MODULE(&LI/TEST);                                  */');
  append2('/*   >>END-IMPORTANT<<                                              */');
  append2('/*   >>EXECUTE<<                                                    */');
  append2('/* >>END-PRE-COMPILER<<                                             */');

  append('PGM': 100);
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');


  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE2) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(TESTCASE)');

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0726': 'W'); // Variable &LIB declared but not referred to

  assertNoJobLog();

  assertNoMsgId('PRZ0029');

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, event file
//  Post-command:
//    *NONE
//  Expected:
//    FILEID 001 (TESTCASE) with compile messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_EVENTF_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  /* No executable commands found in source file. */');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertNoJobLog();

  assertNoMsgId('PRZ0029');

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    error, event file
//  Post-command:
//    no error
//  Expected:
//    FILEID 001 (TESTCASE) with compile messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_EVENTF_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append('/*                        OUTPUT(*NONE );                           */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0081': 'S'); // Variable name required for parameter VAR.

  assertNoJobLog();

  assertNoMsgId('PRZ0029');

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// ------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, no event file
//  Post-command:
//    no error
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_PostCmd_EVENTF_NOJOBLOG_NOEVENTF_OK_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// -----------------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, no event file
//  Post-command:
//    no error
//  Expected:
//    FILEID 001 (TESTCASE) with job log of compile command.
// -----------------------------------------------------------------------
dcl-proc test_PostCmd_EVENTF_ADDJOBLOG_NOEVENTF_OK_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  /* No executable commands found in source file. */');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertNoJobLog();

  assertMsgID('PRZ0029': 'W'); // STRPREPRZ messages

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// -----------------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *NOJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, no event file
//  Post-command:
//    error
//  Expected:
//    FILEID 001 (TESTCASE) with job log of post-command.
// -----------------------------------------------------------------------
dcl-proc test_PostCmd_EVENTF_NOJOBLOG_NOEVENTF_OK_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPF7312': 'S'); // File not found
  assertMsgId('CPF7306': 'T'); // Member not added

  assertNoJobLog();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// -----------------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, no event file
//  Post-command:
//    error
//  Expected:
//    FILEID 001 (TESTCASE) with job log of compile command.
//    FILEID 999 (*JOBLOG) with job log of post-command.
// -----------------------------------------------------------------------
dcl-proc test_PostCmd_EVENTF_ADDJOBLOG_NOEVENTF_OK_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF) +           */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPC0816': 'I'); // Module TESTCASE created in library QTEMP.
  assertMsgID('PRZ0033': 'W'); // Objekt erstellt.

  assertFileID_999('*JOBLOG'); // Job log of *POSTCMD, due to error in post-command.
  assertMsgID('CPF7312': 'S'); // File not found
  assertMsgId('CPF7306': 'T'); // Member not added

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// -----------------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, produces event file
//  Post-command:
//    error
//  Expected:
//    FILEID 001 (TESTCASE) with compile messages.
//    FILEID 999 (*JOBLOG) with job log of post-command.
// -----------------------------------------------------------------------
dcl-proc test_PostCmd_EVENTF_ADDJOBLOG_EVENTF_OK_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  /* No executable commands found in source file. */');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertFileID_999('*JOBLOG'); // Job log of *POSTCMD, due to error in post-command.
  assertMsgID('CPF7312': 'S'); // File not found
  assertMsgId('CPF7306': 'T'); // Member not added

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// -----------------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, produces event file
//  Post-command:
//    no error
//  Expected:
//    FILEID 001 (TESTCASE) with compile messages.
// -----------------------------------------------------------------------
dcl-proc test_PostCmd_EVENTF_ADDJOBLOG_EVENTF_OK_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');
  append('PGM');
  append('  /* No executable commands found in source file. */');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertNoJobLog();

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// -----------------------------------------------------------------------
//  STRPREPRC options:
//    *EVENTF, *ADDJOBLOG
//  Pre-command:
//    no error
//  Compile command:
//    no error, produces event file
//  Post-command:
//    error, produces event file
//  Specials:
//    Uses a different member for retrieving the STRPREPRC header and
//    module name has been overridden in STRPREPRC header.
//  Expected:
//    FILEID 001 (TESTCASE) with compile messages.
//    FILEID 999 (*JOBLOG) with job log of post-command.
// -----------------------------------------------------------------------
dcl-proc test_PostCmd_EVENTF_ADDJOBLOG_EVENTF_OK_ERROR_2 export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*EVENTF) +             */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<   CRTCLMOD   MODULE(&LI/TESTCASE2) SRCFILE(&SL/&SF) +  */');
  append('/*                        SRCMBR(TESTCASE2) OPTION(*EVENTF) +       */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('/* ---------------------------------------------------------------- */');

  append2('/* ---------------------------------------------------------------- */': 100);
  append2('/*     Produces an compile error.                                   */');
  append2('/* ---------------------------------------------------------------- */');
  append2('PGM');
  append2('  CHGVAR &LIB ''FOO''');
  append2('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertFileID_999('*JOBLOG'); // Job log of *POSTCMD, due to error in post-command.
  assertMsgID('CPF0821': 'T'); // Module TESTCASE2 not created.

  assertLDA('QTEMP': 'TESTCASE');

end-proc;

// -----------------------------------------------------------------------
//    Test: stream file never opened.
// -----------------------------------------------------------------------
dcl-proc test_Source_StreamFile_not_open export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s isOpen ind;
  dcl-s lineNbr int(10);
  dcl-s length int(10);

  isOpen = SourceStreamFile_isOpen();
  assert(not isOpen: 'Stream file never opened. Should return isOpen as cFalse');

  lineNbr = SourceStreamFile_getLineNbr();
  assert(lineNbr = -1: 'Stream file never opened. Should return line number -1');

  length = SourceStreamFile_getDtaLength();
  assert(length = 0: 'Stream file never opened. Should return line length 0');

end-proc;

// -----------------------------------------------------------------------
//    Test: open/close stream file.
// -----------------------------------------------------------------------
dcl-proc test_open_close_Source_StreamFile export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s isOpen ind;
  dcl-s srcDta like(srcDta_t);
  dcl-s isEOF ind;
  dcl-s lineNbr int(10);
  dcl-s length int(10);

  createStreamFile(STMF_UTF8: 1208);

  SourceStreamFile_open(STMF_UTF8);

  isOpen = SourceStreamFile_isOpen();
  assert(isOpen: 'Stream file is open. Should return isOpen as cTrue');

  lineNbr = SourceStreamFile_getLineNbr();
  assert(lineNbr = 0: 'Stream file is open. Should return line number 0');

  isEOF = not SourceStreamFile_readLine(srcDta);
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (begin)');
  lineNbr = SourceStreamFile_getLineNbr();
  assert(lineNbr = 1: 'First line has been red. Should return line number 1');

on-exit;
  SourceStreamFile_close();

  isOpen = SourceStreamFile_isOpen();
  assert(not isOpen: 'Stream file closed. Should return isOpen as cFalse');

  lineNbr = SourceStreamFile_getLineNbr();
  assert(lineNbr = -1: 'Stream file closed. Should return line number -1');

  length = SourceStreamFile_getDtaLength();
  assert(length = 0: 'Stream file closed. Should return line length 0');

  deleteStreamFile(STMF_UTF8);

end-proc;

// -----------------------------------------------------------------------
//    Test: reading stream file.
// -----------------------------------------------------------------------
dcl-proc test_Read_Source_StreamFile export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s srcDta like(srcDta_t);
  dcl-s isEOF ind;
  dcl-s lineNbr int(10);
  dcl-s length int(10);
  dcl-s i int(10);

  BUFFER_SIZE = 10;

  createStreamFile(STMF_UTF8: 1208);

  SourceStreamFile_open(STMF_UTF8);

  for i = 1 to 5;

    // test
    isEOF = not SourceStreamFile_readLine(srcDta);
    lineNbr = SourceStreamFile_getLineNbr();
    length = SourceStreamFile_getDtaLength();

    // assertions
    assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse for line #' + %char(i));
    assert(lineNbr = i: 'Line number ' + %char(lineNbr)
           + ' does not match expected value ' + %char(i));
    assert(length = %len(LINES.data(i)): 'Length ' + %char(length) + ' of line #' + %char(i)
           + ' does not match expected value ' + %char(%len(LINES.data(i))));

  endfor;

  // next line is empty, because of the CR after the LF of line #4
  // that is the same LFCR interpreting as of Notepad++

  // test
  isEOF = not SourceStreamFile_readLine(srcDta);
  lineNbr = SourceStreamFile_getLineNbr();
  length = SourceStreamFile_getDtaLength();

  // assertions
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse for line #6' + %char(i));
  assert(lineNbr = 6: 'Line number ' + %char(lineNbr)
         + ' does not match expected value 6');
  assert(length = 0: 'Length ' + %char(length) + ' of line #6'
         + ' does not match expected value 0');

  // read last line.

  // test
  isEOF = not SourceStreamFile_readLine(srcDta);
  lineNbr = SourceStreamFile_getLineNbr();
  length = SourceStreamFile_getDtaLength();

  // assertions
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse for line #7' + %char(i));
  assert(lineNbr = 7: 'Line number ' + %char(lineNbr)
         + ' does not match expected value 7');
  assert(length = %len(LINES.data(6)): 'Length ' + %char(length) + ' of line #7'
         + ' does not match expected value ' + %char(%len(LINES.data(6))));

on-exit;
  SourceStreamFile_close();

  deleteStreamFile(STMF_UTF8);

end-proc;

// -----------------------------------------------------------------------
//    Test: reading stream file forth and back.
// -----------------------------------------------------------------------
dcl-proc test_ReadPrv_Source_StreamFile export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s srcDta like(srcDta_t);
  dcl-s isOpen ind;
  dcl-s isEOF ind;
  dcl-s lineNbr int(10);
  dcl-s length int(10);

  createStreamFile(STMF_UTF8: 1208);

  BUFFER_SIZE = 10;

  SourceStreamFile_open(STMF_UTF8);

  isOpen = SourceStreamFile_isOpen();
  assert(isOpen: 'Stream file is open. Must return cTrue');

  isEOF = not SourceStreamFile_readLine(srcDta); // begin

  isEOF = not SourceStreamFile_readLine(srcDta); // Line 1

  isEOF = not SourceStreamFile_readLine(srcDta); // Line 2

  isEOF = not SourceStreamFile_readLine(srcDta); // Line 3

  isEOF = not SourceStreamFile_readLine(srcDta); // Line 4

  isEOF = not SourceStreamFile_readPrvLine(srcDta); // Line 3
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (line 3)'); // CRLF
  length = SourceStreamFile_getDtaLength();
  lineNbr = SourceStreamFile_getLineNbr();
  assert(%trimr(srcDta) = LINE_3 : 'Unexpected content in ine 3');
  assert(length = %len(LINE_3): 'Invalid line length of (line 3)');
  assert(lineNbr = 4: 'Read previous line. Should return line number 4');

  isEOF = not SourceStreamFile_readPrvLine(srcDta); // Line 2
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (line 2)'); // CRLF
  length = SourceStreamFile_getDtaLength();
  lineNbr = SourceStreamFile_getLineNbr();
  assert(%trimr(srcDta) = LINE_2 : 'Unexpected content in ine 2');
  assert(length = %len(LINE_2): 'Invalid line length of (line 2)');
  assert(lineNbr = 3: 'Read previous line. Should return line number 3');

  isEOF = not SourceStreamFile_readLine(srcDta); // Line 3
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (line 3)'); // CRLF
  assert(%trimr(srcDta) = LINE_3 : 'Unexpected content in ine 3');

  isEOF = not SourceStreamFile_readLine(srcDta); // Line 4
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (line 4)'); // CRLF
  assert(%trimr(srcDta) = LINE_4 : 'Unexpected content in ine 4');

  isEOF = not SourceStreamFile_readLine(srcDta); // empty
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (empty line)');
  assert(%trimr(srcDta) = '' : 'Unexpected content in ine 5');

  isEOF = not SourceStreamFile_readLine(srcDta); // end
  lineNbr = SourceStreamFile_getLineNbr();
  assert(lineNbr = 7: 'Read previous line. Should return line number 7');

on-exit;
  SourceStreamFile_close();

  deleteStreamFile(STMF_UTF8);

end-proc;

// -----------------------------------------------------------------------
//    Test: reding stream file past the last line.
// -----------------------------------------------------------------------
dcl-proc test_Read_EOF_Source_StreamFile export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s srcDta like(srcDta_t);
  dcl-s isEOF ind;
  dcl-s lineNbr int(10);
  dcl-s length int(10);
  dcl-s count int(10);

  createStreamFile(STMF_UTF8: 1208);

  BUFFER_SIZE = 10;

  SourceStreamFile_open(STMF_UTF8);

  count = 0;

  dou (isEOF);
    isEOF = not SourceStreamFile_readLine(srcDta);
    lineNbr = SourceStreamFile_getLineNbr();
    length = SourceStreamFile_getDtaLength();
    if (not isEOF);
      count += 1;
    endif;
  enddo;

  assert(count = 7: 'Expected to have seen 7 lines.');

  // test EOF values

  assert(lineNbr = 0: 'Line number must be -1');
  assert(length = 0: 'Length must be 0');
  assert(srcDta = '': 'srcDta must be empty');
  assert(isEOF: 'isEOF must be cTrue');

  // read past the last line a second time;

  isEOF = not SourceStreamFile_readLine(srcDta);
  lineNbr = SourceStreamFile_getLineNbr();
  length = SourceStreamFile_getDtaLength();

  assert(lineNbr = 0: 'Line number must be -1');
  assert(length = 0: 'Length must be 0');
  assert(srcDta = '': 'srcDta must be empty');
  assert(isEOF: 'isEOF must be cTrue');

on-exit;
  SourceStreamFile_close();

  deleteStreamFile(STMF_UTF8);

end-proc;

// -----------------------------------------------------------------------
//    Test: reding stream file before first line.
// -----------------------------------------------------------------------
dcl-proc test_ReadPrv_EOF_Source_StreamFile export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s srcDta like(srcDta_t);
  dcl-s isEOF ind;
  dcl-s lineNbr int(10);

  createStreamFile(STMF_UTF8: 1208);

  BUFFER_SIZE = 10;

  SourceStreamFile_open(STMF_UTF8);

  isEOF = not SourceStreamFile_readLine(srcDta); // begin
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (begin)');

  isEOF = not SourceStreamFile_readLine(srcDta); // 1. line
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (line 1)');

  isEOF = not SourceStreamFile_readPrvLine(srcDta); // begin
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (begin)');

  isEOF = not SourceStreamFile_readPrvLine(srcDta); // EOF
  lineNbr = SourceStreamFile_getLineNbr();
  assert(isEOF: 'SourceStreamFile_readLine() must return cTrue (EOF #1)');
  assert(lineNbr = 0: 'Stream is at EOF #1. Should return line number 0');
  assert(%trimr(srcDta) = '' : 'EOF #1. Line data mut be empty');

  isEOF = not SourceStreamFile_readPrvLine(srcDta); // EOF
  lineNbr = SourceStreamFile_getLineNbr();
  assert(isEOF: 'SourceStreamFile_readLine() must return cTrue (EOF #2)');
  assert(lineNbr = 0: 'Stream is at EOF #2. Should return line number 0');
  assert(%trimr(srcDta) = '' : 'EOF #2. Line data mut be empty');

  isEOF = not SourceStreamFile_readLine(srcDta); // begin
  assert(not isEOF: 'SourceStreamFile_readLine() must return cFalse (begin)');
  assert(%trimr(srcDta) = LINE_BEGIN : 'Unexpected content in ine 1');

on-exit;
  SourceStreamFile_close();

  deleteStreamFile(STMF_UTF8);

end-proc;

// ------------------------------------------------------------
//  Creates a stream file with test data.
// ------------------------------------------------------------
dcl-proc createStreamFile;
  dcl-pi *n extproc(*dclcase);
    i_stmf   varchar(200) options(*trim) const;
    i_ccsid  int(10) const;
  end-pi;

  dcl-s fd int(10);
  dcl-s text varchar(200);

  dcl-c CR x'0D';
  dcl-c CRLF x'0D25';
  dcl-c LF x'25';
  dcl-c LFCR x'250D';

  fd = open(i_stmf
            : O_CREAT + O_WRONLY + O_SHARE_RDONLY +
              O_TEXTDATA + O_CCSID + O_TRUNC + O_TEXT_CREAT
            : S_IRUSR + S_IWUSR +       // Owner:     read/write
              S_IRGRP + S_IWGRP +       // Group:     read/write
              S_IROTH + S_IWOTH         // Public:    read/write
            : i_ccsid: 0);              // create CCSID / write data CCSID (= job)

  text = lines.data(1) + LF;
  callp write(fd: %addr(text: *data): %len(text));

  text = lines.data(2) + CR;
  callp write(fd: %addr(text: *data): %len(text));

  text = lines.data(3) + LF;
  callp write(fd: %addr(text: *data): %len(text));

  text = lines.data(4) + CRLF;
  callp write(fd: %addr(text: *data): %len(text));

  text = lines.data(5) + LFCR;
  callp write(fd: %addr(text: *data): %len(text));

  text = lines.data(6);
  callp write(fd: %addr(text: *data): %len(text));

  callp close(fd);

end-proc;

// ------------------------------------------------------------
//  Deletes the stream file identified by a given path.
// ------------------------------------------------------------
dcl-proc deleteStreamFile;
  dcl-pi *n extproc(*dclcase);
    i_stmf varchar(200) options(*trim) const;
  end-pi;

  dcl-ds st_stat likeds(st_stat_t);

  if (stat(i_stmf: %addr(st_stat)) <> -1);
    unlink(i_stmf);
  endif;

end-proc;

// ------------------------------------------------------------
//  Assert that the event file is empty.
// ------------------------------------------------------------
dcl-proc assertEmpty;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain any entries at all');

end-proc;

// ------------------------------------------------------------
//  Assert that the event file does not contain any *JOBLOG
//  entries.
// ------------------------------------------------------------
dcl-proc assertNoJobLog;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like 'FILEID % *JOBLOG %';
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain a FILEID for *JOBLOG');

end-proc;

// ------------------------------------------------------------
//  Asserts that the event file contains a file ID 001 section.
// ------------------------------------------------------------
dcl-proc assertFileID_001;
  dcl-pi *n extproc(*dclcase);
    i_section  varchar(10) const;
  end-pi;

  dcl-s argument varchar(100);
  dcl-s count int(10);

  argument = 'FILEID     0 001 %(' + i_section + ')%';

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like :argument;
  assert(not isSqlError(sqlState));

  assert(count = 1: 'Error messages must be related to file ID 001');

end-proc;

// ------------------------------------------------------------
//  Asserts that the event file contains a file ID 999 section.
// ------------------------------------------------------------
dcl-proc assertFileID_999;
  dcl-pi *n extproc(*dclcase);
    i_section  varchar(10) const;
  end-pi;

  dcl-s argument varchar(100);
  dcl-s count int(10);

  argument = 'FILEID     0 999 % ' + i_section + ' %';

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like :argument;
  assert(not isSqlError(sqlState));

  assert(count = 1: 'Error messages must be related to file ID 999 (job log)');

end-proc;

// ------------------------------------------------------------
//  Asserts that the event file contains a message
//  with the specified message id.
// ------------------------------------------------------------
dcl-proc assertMsgID;
  dcl-pi *n extproc(*dclcase);
    i_msgID  varchar(7) const;
    i_severity char(1) options(*nopass) const;
  end-pi;

  dcl-s argument varchar(100);
  dcl-s count int(10);

  if (%parms() >= %parmnum(i_severity));
    argument = 'ERROR % ' + i_msgID + ' ' + i_severity + ' %';
  else;
    argument = 'ERROR % ' + i_msgID + ' %';
  endif;

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like :argument;

  assert(not isSqlError(sqlState));

  assert(count >= 1: 'Event file must contain a message with ID: ' + i_msgID);

end-proc;

// ------------------------------------------------------------
//  Asserts that the local data area (*LDA) was updated.
// ------------------------------------------------------------
dcl-proc assertLDA;
  dcl-pi *n extproc(*dclcase);
    i_lib  char(10) const;
    i_obj  char(10) const;
  end-pi;

  dcl-ds lda likeds(g_LDA);

  lda = retrieveLDA();

  assert(lda.library = i_lib: 'Library name [' + %trim(lda.library) +
                              '] in *LDA does not match: ' + %trim(i_lib));

  assert(lda.object = i_obj: 'Object name [' + %trim(lda.object) +
                             '] in *LDA does not match: ' + %trim(i_obj));

end-proc;

// ------------------------------------------------------------
//  Asserts that the event file does not contains a message
//  with the specified message id.
// ------------------------------------------------------------
dcl-proc assertNoMsgID;
  dcl-pi *n extproc(*dclcase);
    i_msgID  varchar(7) const;
    i_severity char(1) options(*nopass) const;
  end-pi;

  dcl-s argument varchar(100);
  dcl-s count int(10);

  if (%parms() >= %parmnum(i_severity));
    argument = 'ERROR % ' + i_msgID + ' ' + i_severity + ' %';
  else;
    argument = 'ERROR % ' + i_msgID + ' %';
  endif;

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like :argument;

  assert(not isSqlError(sqlState));

  assert(count = 0: 'Event file must not contain a message with ID: ' + i_msgID);

end-proc;

// ------------------------------------------------------------
//  Appends a row to member 'testcase' of file.
// ------------------------------------------------------------
dcl-proc append export;
  dcl-pi *n extproc(*dclcase);
    i_data varchar(100) const;
    i_srcSeq int(10) options(*nopass) const;
  end-pi;

  dcl-s isPrepared1 ind inz(*off) static;

  dcl-s srcSeq zoned(6:2);
  dcl-s data like(i_data);

  if (%parms() >= %parmnum(i_srcSeq));
    g_status.srcSeq = i_srcSeq;
  endif;

  if (not isPrepared1);
    exec sql
      prepare append_row1 from
        'INSERT INTO testmbr (SRCSEQ, SRCDTA, SRCDAT) VALUES(?, ?, 0)';
    assert(not isSqlError(sqlState));
    isPrepared1 = *on;
  endif;

  srcSeq = g_status.srcSeq;
  data = i_data;

  exec sql
    EXECUTE append_row1 USING :srcSeq, :data;
  assert(not isSqlError(sqlState));

  g_status.srcSeq += 100;

end-proc;

// ------------------------------------------------------------
//  Appends a row to member 'testcase2' of file.
// ------------------------------------------------------------
dcl-proc append2 export;
  dcl-pi *n extproc(*dclcase);
    i_data varchar(100) const;
    i_srcSeq int(10) options(*nopass) const;
  end-pi;

  dcl-s isPrepared2 ind inz(*off) static;

  dcl-s srcSeq zoned(6:2);
  dcl-s data like(i_data);

  if (%parms() >= %parmnum(i_srcSeq));
    g_status.srcSeq2 = i_srcSeq;
  endif;

  if (not isPrepared2);
    exec sql
      prepare append_row2 from
        'INSERT INTO testmbr2 (SRCSEQ, SRCDTA, SRCDAT) VALUES(?, ?, 0)';
    assert(not isSqlError(sqlState));
    isPrepared2 = *on;
  endif;

  srcSeq = g_status.srcSeq2;
  data = i_data;

  exec sql
    EXECUTE append_row2 USING :srcSeq, :data;
  assert(not isSqlError(sqlState));

  g_status.srcSeq2 += 100;

end-proc;

// ------------------------------------------------------------
//  Returns *on, when the last SQL statement ended with an
//  error, else *off;
// ------------------------------------------------------------
dcl-proc setIgnSQLWarn;
  dcl-pi *n extproc(*dclcase);
    i_ignore ind const;
  end-pi;

  g_status.sql.ignSQLWarn = i_ignore;

end-proc;

// ------------------------------------------------------------
//  Returns *on, when the last SQL statement ended with an
//  error, else *off;
// ------------------------------------------------------------
dcl-proc isSQLError;
  dcl-pi *n ind extproc(*dclcase);
    i_state   char(5) const;
  end-pi;

  dcl-ds sqlState qualified;
    class char(2);
    qualifier char(3);
  end-ds;

  dcl-ds sql likeds(sql_status_t);

  sqlState = i_state;
  sql = g_status.sql;

  reset g_status.sql;

  select;
  // SQL code 00: Unqualified Successful Completion
  when (sqlState = '00000');
    // Execution of the operation was successful and did not
    // result in any type of warning or exception condition.
    return *off;

  // SQL code 01: Warning
  When (sqlState.class = '01');
    // Valid warning SQLSTATEs returned by an SQL routine.
    // Also used for RAISE_ERROR and SIGNAL.
    if (sql.ignSQLWarn);
      return *off;
    else;
      return *on;
    endif;

  // SQL code 02: No data
  When (sqlState = '02000');
    return *off;

  other;
    // Other problem or error
    return *on;
  endsl;

end-proc;

// ------------------------------------------------------------
//  Returns the SQL statement that was executed at last.
// ------------------------------------------------------------
dcl-proc getLastSqlStmt;
  dcl-pi *n varchar(1024) extproc(*dclcase) end-pi;

  dcl-pr QUSRJOBI extpgm('QUSRJOBI');
    o_rcvVar     char(65535) options(*varsize);
    i_lenRcvVar  int(10)     const;
    i_format     char(8)     const;
    i_qJob       char(26)    const;
    i_intJobId   char(16)    const;
    io_errCode   char(65535) options(*nopass: *varsize);
  End-Pr;

  dcl-ds jobi0900 qualified;
    bytRtn        int(10);
    bytAvl        int(10);
    offSetCurStmt int(10) pos(77);
    stmtSize      int(10) pos(81);
    status        int(10) pos(85);
    ccsid         int(10) pos(89);
    reserved_1    char(1024);
  End-Ds;

  dcl-ds statement qualified based(pStatement);
    value char(1024);
  end-ds;

  dcl-ds errCode likeds(local_errCode_t) inz(*likeds);

  QUSRJOBI(jobi0900: %size(jobi0900): 'JOBI0900': '*': '': errCode);

  if (jobi0900.stmtSize > 0);
    pStatement = %addr(jobi0900) + jobi0900.offSetCurStmt;
    return %subst(statement.value: 1: jobi0900.stmtSize);
  else;
    return 'SQL statement could not be retri.';
  endif;

end-proc;

// ------------------------------------------------------------
//  Returns *ON, when the specified object exists, eöse *OFF.
// ------------------------------------------------------------
dcl-proc exist;
  dcl-pi *n ind extproc(*dclcase);
    i_lib varchar(10) const;
    i_obj varchar(10) const;
    i_type varchar(10) const;
    i_mbr varchar(10) options(*nopass: *omit) const;
  end-pi;

  // Retrieve Object Description (QUSROBJD) API
  dcl-pr QUSROBJD extpgm('QUSROBJD');
    o_rcvVar     char(65535) options(*varsize);
    i_lenRcvVar  int(10)     const;
    i_format     char(8)     const;
    i_qObj       char(20)    const;
    i_type       char(10)    const;
    io_errCode   char(65535) options(*nopass: *varsize);
  end-pr;

  dcl-ds objd0100 qualified;
    bytRet       int(10);
    bytAvl       int(10);
    name         char(10);
    lib          char(10);
    type         char(10);
    rtnLib       char(10);
    auxStgP      int(10);
    owner        char(10);
    domain       char(2);
    crtDatTim    char(13);
    chgDatTim    char(13);
  end-ds;

  // Retrieve Member Description (QUSRMBRD) API
  dcl-pr QUSRMBRD extpgm('QUSRMBRD');
    o_rcvVar     char(65535) options(*varsize);
    i_lenRcvVar  int(10)     const;
    i_format     char(8)     const;
    i_qFile      char(20)    const;
    i_mbr        char(10)    const;
    i_ovrPrc     char(1)     const;
    io_errCode   char(65535) options(*nopass: *varsize);
  end-pr;

  dcl-ds mbrd0100 qualified;
    bytRet       int(10);
    bytAvl       int(10);
    file         char(10);
    lib          char(10);
    mbr          char(10);
    attr         char(10);
    srcType      char(10);
    crtDatTim    char(13);
    srcChgDatTim char(13);
    text         char(50);
    isSrcFile    char(1);
  end-ds;

  dcl-ds errCode likeds(local_errCode_t) inz(*likeds);

  dcl-ds qObj qualified;
    name         char(10);
    lib          char(10);
  end-ds;

  clear qObj;
  qObj.name = i_obj;
  qObj.lib = i_lib;

  if (i_type = '*FILE' and %parms() >= %parmnum(i_mbr));
    QUSRMBRD(mbrd0100: %size(mbrd0100): 'MBRD0100': qObj: i_mbr: '0': errCode);
  else;
    QUSROBJD(objd0100: %size(objd0100): 'OBJD0100': qObj: i_type: errCode);
  endif;

  return errCode.bytAvl = 0;

end-proc;

// ------------------------------------------------------------
//  Clear local data area (*LDA).
// ------------------------------------------------------------
dcl-proc clearLDA;
  dcl-pi *n extproc(*dclcase) end-pi;

  monitor;
    in g_LDA;
    g_LDA.library = '';
    g_LDA.object = '';
    out g_LDA;
  on-error;
  endmon;
end-proc;

// ------------------------------------------------------------
//  Retrieve local data area (*LDA).
// ------------------------------------------------------------
dcl-proc retrieveLDA;
  dcl-pi *n likeds(g_lda) extproc(*dclcase) end-pi;

  clear g_LDA;

  monitor;
    in g_LDA;
  on-error;
  endmon;

  return g_LDA;

end-proc;

