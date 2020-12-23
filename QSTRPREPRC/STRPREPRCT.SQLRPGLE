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
//       >>PARM<< COMPILEOPT('OPTION(*EVENTF) DBGVIEW(*LIST)');
//       >>PARM<< BNDDIR(*N);
//     >>END-COMPILE<<
//     >>EXECUTE<<
//   >>END-PRE-COMPILER<<
//=====================================================================
ctl-opt NoMain Option(*SrcStmt : *NoDebugIO);

/include qinclude,TESTCASE                  iRPGUnit Test Suite

exec sql
  SET OPTION
    NAMING =*SQL, COMMIT = *NONE, CLOSQLCSR = *ENDACTGRP, DATFMT = *ISO, TIMFMT = *ISO,
    DFTRDBCOL = QTEMP, DYNDFTCOL = *YES;

// ------------------------------------------------------------
//  Global Program Status.
// ------------------------------------------------------------

dcl-ds g_status qualified;
  srcSeq int(10);
  sql likeds(sql_status_t) inz(*likeds);
end-ds;

dcl-ds sql_status_t qualified template;
  ignSQLWarn ind inz(*off);
end-ds;

// ------------------------------------------------------------
//  Global type templates.
// ------------------------------------------------------------
dcl-ds errCode_t qualified template;
  bytPrv       int(10) inz(%size(errCode_t));
  bytAvl       int(10) inz;
  excId        char(7) inz;
  reserved_1   char(1) inz;
  excDta       char(100) inz;
end-ds;

// ------------------------------------------------------------
//  Set up test suite.
// ------------------------------------------------------------
dcl-proc setUpSuite export;
  dcl-pi *n extproc(*dclcase) end-pi;

  if (not exist('QTEMP': 'RUNIT_TST': '*FILE'));
    runCmd('CRTSRCPF FILE(QTEMP/RUNIT_TST) RCDLEN(112) MBR(*NONE)');
  endif;

  if (not exist('QTEMP': 'RUNIT_TST': '*FILE': 'TESTCASE'));
    runCmd('ADDPFM FILE(QTEMP/RUNIT_TST) MBR(TESTCASE) +
              TEXT(''STRPREPRD - SelfTest'') SRCTYPE(CLLE)');
  endif;

  exec sql
    CREATE ALIAS qtemp.testmbr FOR qtemp.RUNIT_TST (TESTCASE);
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

  if (exist('QTEMP': 'EVFEVENT': '*FILE'));
    if (exist('QTEMP': 'RUNIT_TST': '*FILE': 'TESTCASE'));
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


end-proc;

// ------------------------------------------------------------
//  *NOEVENTF does not add any job log messages at all.
// ------------------------------------------------------------
dcl-proc test_PreCommand_NOEVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile command.                */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);          */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*NOEVENTF *NOJOBLOG)');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain any entries at all');

end-proc;

// ------------------------------------------------------------
//  *NOEVENTF does not add any job log messages at all.
// ------------------------------------------------------------
dcl-proc test_PreCommand_NOEVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the pre-compile command.                */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*NOEVENTF *NOJOBLOG)');
    fail('STRPREPRC should have thown an error (001)');
  on-error;
  // Exception seen!
  endmon;

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain any entries at all');

end-proc;

// ------------------------------------------------------------
//
// ------------------------------------------------------------
dcl-proc test_PreCommand_EVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile command.                */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE)');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain any entries at all');

end-proc;

// ------------------------------------------------------------
//
// ------------------------------------------------------------
dcl-proc test_PreCommand_EVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the pre-compile command.                */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE)');
    fail('STRPREPRC should have thown an error (002)');
  on-error;
  // Exception seen!
  endmon;

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file should contain job log messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like '%CPF7312 S 30%'    /* File not found */;
  assert(not isSqlError(sqlState));

  assert(count = 1: 'The event file must contain a CPF7312 message');

end-proc;

// ------------------------------------------------------------
//
// ------------------------------------------------------------
dcl-proc test_PreCommand_EVENTF_ADDJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile command.                */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE)');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain any entries at all');

end-proc;

// ------------------------------------------------------------
//
// ------------------------------------------------------------
dcl-proc test_PreCommand_EVENTF_ADDJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the pre-compile command.                */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE)');
    fail('STRPREPRC should have thown an error (003)');
  on-error;
  // Exception seen!
  endmon;

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file should contain job log messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like '%CPF7312 S 30%'    /* File not found   */
         OR evfevent like '%CPF7306 T 40%'    /* Member not added */;
  assert(not isSqlError(sqlState));

  assert(count = 2: 'The event file must contain CPF7312 and CPF7306 messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like '%PRZ0029 S 30%'    /* STRPREPRC messages   */;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file must contain some PRZ0029 messages');

end-proc;

// ------------------------------------------------------------
//  *NOEVENTF does not add any job log messages at all.
// ------------------------------------------------------------
dcl-proc test_Execute_NOEVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTBNDCL  PGM(&LI/&OB) SRCFILE(&SL/&SF) +           */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF);            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>EXECUTE<<                                                      */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*NOEVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain any entries at all');

end-proc;

// ------------------------------------------------------------
//  *NOEVENTF does not add any job log messages at all.
// ------------------------------------------------------------
dcl-proc test_Execute_NOEVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTBNDCL  PGM(&LI/&OB) SRCFILE(&SL/&SF) +           */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF);            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*NOEVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain any entries at all');

end-proc;

// ------------------------------------------------------------
//
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTBNDCL  PGM(&LI/&OB) SRCFILE(&SL/&SF) +           */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF);            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>EXECUTE<<                                                      */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count = 0: 'The event file must not contain any entries at all');

end-proc;

// ------------------------------------------------------------
//
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTBNDCL  PGM(&LI/&OB) SRCFILE(&SL/&SF) +           */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF);            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file should contain job log messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like '%CPF0820 T 40%'    /* Program not created  */;
  assert(not isSqlError(sqlState));

  assert(count = 1: 'The event file must contain a CPF0820 message');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like '%PRZ0029 S 30%'    /* STRPREPRC messages   */;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file must contain some PRZ0029 messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like 'FILEID     0 001%';
  assert(not isSqlError(sqlState));

  assert(count = 1: 'Error messages must be related to file 001');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like 'FILEID     0 999%';
  assert(not isSqlError(sqlState));

  assert(count = 0: 'Did not expect any error messages related to file 999');

end-proc;

// ------------------------------------------------------------
//
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTBNDCL  PGM(&LI/&OB) SRCFILE(&SL/&SF) +           */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF);            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file should contain job log messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like '%PRZ0029 W 10%'    /* STRPREPRC messages   */;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file must contain some PRZ0029 messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like 'FILEID     0 001%';
  assert(not isSqlError(sqlState));

  assert(count = 1: 'Error messages must be related to file 001');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like 'FILEID     0 999%';
  assert(not isSqlError(sqlState));

  assert(count = 0: 'Did not expect any error messages related to file 999');

end-proc;

// ------------------------------------------------------------
//
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  dcl-s count int(10);

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTBNDCL  PGM(&LI/&OB) SRCFILE(&SL/&SF) +           */');
  append('/*                        SRCMBR(&SM) OPTION(*NOEVENTF);            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
  append('ENDPGM');

  if (not hasEventFile());
    return;
  endif;

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file should contain job log messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like '%CPF0820 T 40%'    /* Program not created  */;
  assert(not isSqlError(sqlState));

  assert(count = 1: 'The event file must contain a CPF0820 message');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like '%PRZ0029 S 30%'    /* STRPREPRC messages   */;
  assert(not isSqlError(sqlState));

  assert(count > 0: 'The event file must contain some PRZ0029 messages');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like 'FILEID     0 001%';
  assert(not isSqlError(sqlState));

  assert(count = 1: 'Error messages must be related to file 001');

  exec sql
    SELECT count(evfevent) INTO :count FROM eventfile
      WHERE evfevent like 'FILEID     0 999%';
  assert(not isSqlError(sqlState));

  assert(count = 0: 'Did not expect any error messages related to file 999');

end-proc;

// ------------------------------------------------------------
//  Appends a row to member 'testcase' of file.
// ------------------------------------------------------------
dcl-proc append export;
  dcl-pi *n extproc(*dclcase);
    i_data varchar(100) const;
    i_srcSeq int(10) options(*nopass) const;
  end-pi;

  dcl-s isPrepared ind inz(*off) static;

  dcl-s srcSeq zoned(6:2);
  dcl-s data like(i_data);

  if (%parms() >= %parmnum(i_srcSeq));
    g_status.srcSeq = i_srcSeq;
  endif;

  if (not isPrepared);
    exec sql
      prepare append_row from
        'INSERT INTO testmbr (SRCSEQ, SRCDTA, SRCDAT) VALUES(?, ?, 0)';
    assert(not isSqlError(sqlState));
    isPrepared = *on;
  endif;

  srcSeq = g_status.srcSeq;
  data = i_data;

  exec sql
    EXECUTE append_row USING :srcSeq, :data;
  assert(not isSqlError(sqlState));

  g_status.srcSeq += 100;

end-proc;

// ------------------------------------------------------------
//  Returns *on, when the last SQL statement ended with an
//  error, else *off;
// ------------------------------------------------------------
dcl-proc setIgnSQLWarn export;
  dcl-pi *n extproc(*dclcase);
    i_ignore ind const;
  end-pi;

  g_status.sql.ignSQLWarn = i_ignore;

end-proc;

// ------------------------------------------------------------
//  Returns *on, when the last SQL statement ended with an
//  error, else *off;
// ------------------------------------------------------------
dcl-proc isSQLError export;
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

  dcl-ds errCode likeds(errCode_t) inz(*likeds);

  QUSRJOBI(jobi0900: %size(jobi0900): 'JOBI0900': '*': '': errCode);

  if (jobi0900.stmtSize > 0);
    pStatement = %addr(jobi0900) + jobi0900.offSetCurStmt;
    return %subst(statement.value: 1: jobi0900.stmtSize);
  else;
    return 'SQL statement could not be retri.';
  endif;

end-proc;

// ------------------------------------------------------------
//  Returns *on, when the EVFEVENT file with member TESTCASE
//  exists in QTEMP, else *off.
// ------------------------------------------------------------
dcl-proc hasEventFile export;
  dcl-pi *n ind extproc(*dclcase) end-pi;

  if (not exist('QTEMP': 'RUNIT_TST': '*FILE'));
    return *off;
  endif;

  if (not exist('QTEMP': 'RUNIT_TST': '*FILE': 'TESTCASE'));
    return *off;
  endif;

  return *on;

end-proc;

// ------------------------------------------------------------
//  Returns *ON, when the specified object exists, eöse *OFF.
// ------------------------------------------------------------
dcl-proc exist export;
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

  dcl-ds errCode likeds(errCode_t) inz(*likeds);

  dcl-ds qObj qualified;
    name         char(10);
    lib          char(10);
  end-ds;

  clear qObj;
  qObj.name = i_obj;
  qObj.lib = i_lib;

  if (i_type = '*FILE');
    if (%parms() >= %parmnum(i_mbr));
      QUSRMBRD(mbrd0100: %size(mbrd0100): 'MBRD0100': qObj: i_mbr: '0': errCode);
    else;
      QUSRMBRD(mbrd0100: %size(mbrd0100): 'MBRD0100': qObj: '*FIRST': '0': errCode);
    endif;
  else;
    QUSROBJD(objd0100: %size(objd0100): 'OBJD0100': qObj: i_type: errCode);
  endif;

  return errCode.bytAvl = 0;

end-proc;

