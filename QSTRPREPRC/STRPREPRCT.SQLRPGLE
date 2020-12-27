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
  srcSeq2 int(10);
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

  if (not exist('QTEMP': 'RUNIT_TST': '*FILE': 'TESTCASE2'));
    runCmd('ADDPFM FILE(QTEMP/RUNIT_TST) MBR(TESTCASE2) +
              TEXT(''STRPREPRD - SelfTest'') SRCTYPE(CLLE)');
  else;
    runCmd('CLRPFM FILE(QTEMP/RUNIT_TST) MBR(TESTCASE2)');
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

  append2('/* ---------------------------------------------------------------- */': 100);
  append2('/*     Produces an compile error.                                   */');
  append2('/* ---------------------------------------------------------------- */');
  append2('PGM');
  append2('  CHGVAR &LIB ''FOO''');
  append2('ENDPGM');

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


end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_PreCommand_NOEVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

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

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*NOEVENTF *NOJOBLOG) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to STRPREPRC OPTION(*NOEVENTF).
// ------------------------------------------------------------
dcl-proc test_PreCommand_NOEVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

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

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*NOEVENTF *NOJOBLOG) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (001)');
  on-error;
  // Exception seen!
  endmon;

  assertEmpty();

end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_PreCommand_EVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

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

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with job log
//    error messages. (replacement for compile listing)
// ------------------------------------------------------------
dcl-proc test_PreCommand_EVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

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

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (002)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE');
  assertNoJobLog();

  assertMsgID('CPF7312': 'S'); // File not found

end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_PreCommand_EVENTF_ADDJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

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

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with job log
//    error messages. (replacement for compile listing)
// ------------------------------------------------------------
dcl-proc test_PreCommand_EVENTF_ADDJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

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

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE)');
    fail('STRPREPRC should have thown an error (003)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('*NONE'); // *NONE, because parameters SRCLIB, SRCFILE and SRCMBR
  // had not been specified.
  assertNoJobLog();

  assertMsgId('CPF7312': 'S'); // File not found
  assertMsgId('CPF7306': 'T'); // Member not added

end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_Execute_NOEVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
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

end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to STRPREPRC OPTION(*NOEVENTF).
// ------------------------------------------------------------
dcl-proc test_Execute_NOEVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
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
              OPTION(*NOEVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
    fail('STRPREPRC should have thown an error (004)');
  on-error;
  // Exception seen!
  endmon;

  assertEmpty();

end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
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

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with job log
//    error messages. (replacement for compile listing)
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
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
  assertNoJobLog();
  assertMsgID('CPF0821': 'T'); // Module not created
  assertMsgID('PRZ0029': 'S'); // STRPREPRZ messages

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with job log
//    warning messages. (additional job log messages)
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE');
  assertNoJobLog();
  assertMsgID('PRZ0029': 'W'); // STRPREPRZ warning messages,
// due to OPTION(*ADDJOBLOG).

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with job log
//    error messages. (replacement for compile listing)
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
  append('/*                        OUTPUT(*NONE );                           */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
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
  assertNoJobLog();
  assertMsgID('CPF0821': 'T'); // Module not created
  assertMsgID('PRZ0029': 'S'); // STRPREPRZ error messages

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with compile messages.
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
  append('/* >>EXECUTE<<                                                      */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL &LIB *CHAR 10');
  append('  CHKOBJ OBJ(QSYS) OBJTYPE(*LIB)');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE');
  assertNoJobLog();
  assertMsgID('CPD0726': 'W'); // Variable &LIB declared but not referred to
  assertMsgID('CPD0791': 'I'); // No labels used in program

  assertNoMsgId('PRZ0029');

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with compile messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_EVENTF_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 100);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *EVENTF) +      */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
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
  assertNoJobLog();
  assertMsgID('CPD0081': 'S'); // Variable name required for parameter VAR.

  assertNoMsgId('PRZ0029');

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with compile messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_EVENTF_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *EVENTF) +      */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE');
  assertNoJobLog();
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertNoMsgId('PRZ0029');

end-proc;

// ------------------------------------------------------------
//    FILEID 001 for member TESTCASE with compile messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_EVENTF_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Produces an error in the main command.                       */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *EVENTF) +      */');
  append('/*                        OUTPUT(*NONE );                           */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('  DCL LIB *CHAR 10');
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
  assertNoJobLog();
  assertMsgID('CPD0081': 'S'); // Variable name required for parameter VAR.

  assertNoMsgId('PRZ0029');

end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_OK_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertEmpty();

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with job log messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_OK_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE'); // Added due to *ADDJOBLOG and *NOEVENTF
  assertNoJobLog();
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertMsgID('PRZ0029': 'W'); // STRPREPRZ messages

end-proc;

// ------------------------------------------------------------
//  Expected:
//    Empty EVFEVENT file, due to no errors.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_NOJOBLOG_OK_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *NOEVENTF) +    */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *NOJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE'); // Added due to *ERROR in *POSTCMD
  assertNoJobLog();

  assertMsgID('CPF7312': 'S'); // File not found
  assertMsgId('CPF7306': 'T'); // Member not added

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with compile messages.
//    FILEID 999 for *JOBLOG with *POSTCMD error messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_EVENTF_OK_ERROR export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *EVENTF) +      */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<   ADDPFM FILE(QTEMP/RUNIT_ERR) MBR(DUMMY);             */');
  append('/*   >>CMD<<   RMVM   FILE(QTEMP/RUNIT_TST) MBR(DUMMY);             */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE'); // Added due to *ERROR in *POSTCMD
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertFileID_999('*JOBLOG'); // Job log of *POSTCMD
  assertMsgID('CPF7312': 'S'); // File not found
  assertMsgId('CPF7306': 'T'); // Member not added

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with compile messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_EVENTF_OK_OK export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *EVENTF) +      */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
            OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
            SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');

  assertFileID_001('TESTCASE'); // Added due to *ERROR in *POSTCMD
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.
  assertNoJobLog();

end-proc;

// ------------------------------------------------------------
//  Expected:
//    FILEID 001 for member TESTCASE with compile messages.
//    FILEID 999 for *JOBLOG with *POSTCMD joblog  messages.
// ------------------------------------------------------------
dcl-proc test_Execute_EVENTF_ADDJOBLOG_EVENTF_OK_ERROR_COPY export;
  dcl-pi *n extproc(*dclcase) end-pi;

  append('/* ---------------------------------------------------------------- */': 1);
  append('/*     Succesfully executes the pre-compile and main commands.      */');
  append('/* ---------------------------------------------------------------- */');
  append('/* >>PRE-COMPILER<<                                                 */');
  append('/*   >>CRTCMD<< CRTCLMOD  MODULE(&LI/&OB) SRCFILE(&SL/&SF) +        */');
  append('/*                        SRCMBR(&SM) OPTION(*GEN   *EVENTF) +      */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/*   >>CMD<<    CHKOBJ OBJ(QTEMP/RUNIT_TST) OBJTYPE(*FILE);         */');
  append('/*   >>EXECUTE<<                                                    */');
  append('/*   >>CMD<<   CRTCLMOD   MODULE(&LI/TESTCASE2) SRCFILE(&SL/&SF) +  */');
  append('/*                        SRCMBR(TESTCASE2) OPTION(*EVENTF) +       */');
  append('/*                        OUTPUT(*NONE);                            */');
  append('/* >>END-PRE-COMPILER<<                                             */');
  append('PGM');
  append('ENDPGM');

  monitor;
    runCmd('STRPREPRC USESRCFILE(QTEMP/RUNIT_TST) USESRCMBR(TESTCASE) +
              OPTION(*EVENTF *ADDJOBLOG) LIB(QTEMP) OBJ(TESTCASE) +
              SRCLIB(*DFT) SRCFILE(*DFT) SRCMBR(*DFT)');
  on-error;
  // Exception seen!
  endmon;

  assertFileID_001('TESTCASE'); // Added due to *ERROR in *POSTCMD
  assertMsgID('CPD0729': 'W'); // No executable commands found in source file.

  assertFileID_999('*JOBLOG'); // Job log of *POSTCMD
  assertMsgID('CPF0821': 'T'); // Module TESTCASE2 not created.

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
//  Appends a row to member 'testcase2' of file.
// ------------------------------------------------------------
dcl-proc append2 export;
  dcl-pi *n extproc(*dclcase);
    i_data varchar(100) const;
    i_srcSeq int(10) options(*nopass) const;
  end-pi;

  dcl-s isPrepared ind inz(*off) static;

  dcl-s srcSeq zoned(6:2);
  dcl-s data like(i_data);

  if (%parms() >= %parmnum(i_srcSeq));
    g_status.srcSeq2 = i_srcSeq;
  endif;

  if (not isPrepared);
    exec sql
      prepare append_row from
        'INSERT INTO testmbr2 (SRCSEQ, SRCDTA, SRCDAT) VALUES(?, ?, 0)';
    assert(not isSqlError(sqlState));
    isPrepared = *on;
  endif;

  srcSeq = g_status.srcSeq2;
  data = i_data;

  exec sql
    EXECUTE append_row USING :srcSeq, :data;
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

  dcl-ds errCode likeds(errCode_t) inz(*likeds);

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

