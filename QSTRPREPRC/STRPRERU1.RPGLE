**FREE
//=====================================================================*
//  iRPGUnit Test - Cmd Parameter EXECOPT.                             *
//=====================================================================*
//   >>PRE-COMPILER<<                                                  *
//     >>CRTCMD<<  RUCRTTST    TSTPGM(&LI/&OB) +                       *
//                             SRCFILE(&SL/&SF) SRCMBR(&SM);           *
//     >>IMPORTANT<<                                                   *
//       >>PARM<< COPTION(*EVENTF);                                    *
//       >>PARM<< DBGVIEW(*LIST);                                      *
//       >>PARM<< BNDDIR(*N);                                          *
//     >>END-IMPORTANT<<                                               *
//     >>EXECUTE<<                                                     *
//   >>END-PRE-COMPILER<<                                              *
//=====================================================================*
//  Compile options:                                                   *
//    *SrcStmt       - Assign SEU line numbers when compiling the      *
//                     source member. This option is required to       *
//                     position the LPEX editor to the line in error   *
//                     when the source member is opened from the       *
//                     RPGUnit view.                                   *
//    *NoDebugIO     - Do not generate breakpoints for input and       *
//                     output specifications. Optional but useful.     *
//=====================================================================*
ctl-opt NoMain Option(*SrcStmt : *NoDebugIO);

dcl-f SRCFILE DISK(112) usage(*update:*delete:*output)
      usropn extfile(g_useSrcFile.name) extmbr(g_useSrcFile.member);

dcl-ds g_useSrcFile qualified;
  name            varchar(21);
  member          varchar(10);
end-ds;

/include qinclude,TESTCASE                  iRPGUnit Test Suite

dcl-s test1           char(80) dim(17) ctdata;
dcl-s test2           char(80) dim(17) ctdata;
dcl-s test3           char(80) dim(10) ctdata;

dcl-pr setUpSuite
       extproc('setUpSuite');
end-pr;

dcl-pr tearDownSuite
       extproc('tearDownSuite');
end-pr;

dcl-pr setUp
       extproc('setUp');
end-pr;

dcl-pr tearDown
       extproc('tearDown');
end-pr;

dcl-pr testStandardHeader
       extproc('+
       testStandardHeader+
       ');
end-pr;

dcl-pr testNoExecuteTag
       extproc('+
       testNoExecuteTag+
       ');
end-pr;

dcl-pr testNoTagsAtAll_1
       extproc('+
       testNoTagsAtAll_1+
       ');
end-pr;

dcl-pr testNoTagsAtAll_2
       extproc('+
       testNoTagsAtAll_2+
       ');
end-pr;

dcl-c MSGQ_LIB 'QTEMP';
dcl-c MSGQ_NAME 'STRPREPRC';
dcl-c MSGQ_FULL_NAME 'QTEMP/STRPREPRC';

dcl-c BASE_CMD 'STRPREPRC +
 USESRCFILE(QTEMP/QSTRPREPRC) +
 USESRCMBR(STRPRERU)';

dcl-s g_startTime     timestamp;

// ============================================================
//  Set up test suite. Executed once per RUCALLTST.
// ============================================================
dcl-proc setUpSuite export;
  dcl-pi *N;
  end-pi;

  monitor;
    runCmd('DLTF FILE(QTEMP/QSTRPREPRC)');
  on-error;
  // ignore errors
  endmon;

  runCmd('CRTSRCPF FILE(QTEMP/QSTRPREPRC) RCDLEN(112) +
          MBR(STRPRERU) +
          TEXT(''iRPGUnit Test of STRPREPRC Utility'')');

  monitor;
    runCmd('DLTMSGQ MSGQ(' + MSGQ_FULL_NAME + ')');
  on-error;
  // Ignore errors
  endmon;

  runCmd('CRTMSGQ MSGQ(' + MSGQ_FULL_NAME + ') +
          TEXT(''IRPGUnit SelfTest - Tet Message Queue.'')');

end-proc;

// ============================================================
//  Tear down test suite.
// ============================================================
dcl-proc tearDownSuite export;
  dcl-pi *N;
  end-pi;

  runCmd('DLTF FILE(QTEMP/QSTRPREPRC)');

  runCmd('DLTMSGQ MSGQ(' + MSGQ_FULL_NAME + ')');

end-proc;

// ============================================================
//  Set up test case.
// ============================================================
dcl-proc setUp export;
  dcl-pi *N;
  end-pi;

  runCmd('CLRPFM FILE(QTEMP/QSTRPREPRC) MBR(STRPRERU)');

  runCmd('CLRMSGQ MSGQ(' + MSGQ_FULL_NAME + ')');

  g_startTime = getFullTimeStamp();

end-proc;

// ============================================================
//  Tear down test case.
// ============================================================
dcl-proc tearDown export;
  dcl-pi *N;
  end-pi;

end-proc;

// ============================================================
//  RPGUnit test case.
// ============================================================
dcl-proc testStandardHeader export;
  dcl-pi *N;
  end-pi;

  dcl-s i               int(10);
  dcl-ds srcLine qualified;
    srcSeq          zoned(6:2);
    srcDat          zoned(6);
    srcDta          char(100);
  end-ds;

  // Setup test

  g_useSrcFile.name = 'QTEMP/QSTRPREPRC';
  g_useSrcFile.member = 'STRPRERU';

  open SRCFILE;

  for i = 1 to %elem(test1);
    clear srcLine;
    srcLine.srcSeq = i * 100;
    srcLine.srcDat = 0;
    srcLine.srcDta = test1(i);
    write SRCFILE srcLine;
  endfor;

  if (%open(SRCFILE));
    close SRCFILE;
  endif;

  // Run and validate: *ALL

  runCmd(BASE_CMD + ' EXECOPT(*ALL)');

  assertMessageQueueContains(
    MSGQ_NAME : MSGQ_LIB: *omit: '*Pre-command 1*': *omit: g_startTime);
  assertMessageQueueContains(
    MSGQ_NAME : MSGQ_LIB: *omit: '*Pre-command 2*': *omit: g_startTime);

  assertMessageQueueContains(
    MSGQ_NAME : MSGQ_LIB: *omit: '*Create Command*': *omit: g_startTime);

  assertMessageQueueContains(
    MSGQ_NAME : MSGQ_LIB: *omit: '*Post-command 1*': *omit: g_startTime);
  assertMessageQueueContains(
    MSGQ_NAME : MSGQ_LIB: *omit: '*Post-command 2*': *omit: g_startTime);

end-proc;

// ============================================================
//  RPGUnit test case.
// ============================================================
dcl-proc testNoExecuteTag export;
  dcl-pi *N;
  end-pi;

  dcl-s i               int(10);
  dcl-ds srcLine qualified;
    srcSeq          zoned(6:2);
    srcDat          zoned(6);
    srcDta          char(100);
  end-ds;

  // Setup test

  g_useSrcFile.name = 'QTEMP/QSTRPREPRC';
  g_useSrcFile.member = 'STRPRERU';

  open SRCFILE;

  for i = 1 to %elem(test2);
    clear srcLine;
    srcLine.srcSeq = i * 100;
    srcLine.srcDat = 0;
    srcLine.srcDta = test2(i);
    write SRCFILE srcLine;
  endfor;

  if (%open(SRCFILE));
    close SRCFILE;
  endif;

  // Run and validate: *ALL

  runCmd(BASE_CMD + ' EXECOPT(*ALL)');

  assertMessageQueueContains(
    MSGQ_NAME: MSGQ_LIB: *omit: '*Pre-command 1*': *omit: g_startTime);
  assertMessageQueueContains(
    MSGQ_NAME: MSGQ_LIB: *omit: '*Pre-command 2*': *omit: g_startTime);

  monitor;
    assertMessageQueueContains(
      MSGQ_NAME: MSGQ_LIB: *omit: '*Create Command*': *omit: g_startTime);
    fail('testNoExecuteTag must not execute the CRTCMD tag');
  on-error;
  // expeted error seen
  endmon;

  monitor;
    assertMessageQueueContains(
      MSGQ_NAME: MSGQ_LIB: *omit: '*Post-command 1*': *omit: g_startTime);
    fail('testNoExecuteTag must not execute the POST-CMD-1 tag');
  on-error;
  // expeted error seen
  endmon;

  monitor;
    assertMessageQueueContains(
      MSGQ_NAME: MSGQ_LIB: *omit: '*Post-command 2*': *omit: g_startTime);
    fail('testNoExecuteTag must not execute the POST-CMD-2 tag');
  on-error;
  // expeted error seen
  endmon;

end-proc;

// ============================================================
//  RPGUnit test case.
// ============================================================
dcl-proc testNoTagsAtAll_1 export;
  dcl-pi *N;
  end-pi;

  dcl-s i               int(10);
  dcl-ds srcLine qualified;
    srcSeq          zoned(6:2);
    srcDat          zoned(6);
    srcDta          char(100);
  end-ds;

  // Setup test

  g_useSrcFile.name = 'QTEMP/QSTRPREPRC';
  g_useSrcFile.member = 'STRPRERU';

  open SRCFILE;

  for i = 1 to %elem(test3);
    clear srcLine;
    srcLine.srcSeq = i * 100;
    srcLine.srcDat = 0;
    srcLine.srcDta = test3(i);
    write SRCFILE srcLine;
  endfor;

  if (%open(SRCFILE));
    close SRCFILE;
  endif;

  // Run and validate: *ALL

  runCmd(BASE_CMD + ' EXECOPT(*ALL) +
         CMD(SNDMSG MSG(''MAIN: External Create Command'') +
         TOMSGQ(QTEMP/STRPREPRC))');

  monitor;
    assertMessageQueueContains(
      MSGQ_NAME: MSGQ_LIB: *omit: '*Pre-command*': *omit: g_startTime);
    fail('testNoTagsAtAll_1 must not execute any pre commands');
  on-error;
  // expeted error seen
  endmon;

  assertMessageQueueContains(
    MSGQ_NAME : MSGQ_LIB: *omit: '*External Create*': *omit: g_startTime);

  monitor;
    assertMessageQueueContains(
      MSGQ_NAME: MSGQ_LIB: *omit: '*Post-command*': *omit: g_startTime);
    fail('testNoTagsAtAll_1 must not execute any post commands');
  on-error;
  // expeted error seen
  endmon;

end-proc;

// ============================================================
//  RPGUnit test case.
// ============================================================
dcl-proc testNoTagsAtAll_2 export;
  dcl-pi *N;
  end-pi;

  dcl-s i               int(10);
  dcl-ds srcLine qualified;
    srcSeq          zoned(6:2);
    srcDat          zoned(6);
    srcDta          char(100);
  end-ds;

  // Setup test

  g_useSrcFile.name = 'QTEMP/QSTRPREPRC';
  g_useSrcFile.member = 'STRPRERU';

  open SRCFILE;

  for i = 1 to %elem(test3);
    clear srcLine;
    srcLine.srcSeq = i * 100;
    srcLine.srcDat = 0;
    srcLine.srcDta = test3(i);
    write SRCFILE srcLine;
  endfor;

  if (%open(SRCFILE));
    close SRCFILE;
  endif;

  // Run and validate: *ALL

  runCmd(BASE_CMD + ' EXECOPT(*PRECMDS *POSTCMDS) +
         CMD(DLYJOB DLY(1))');

  assertMessageQueueContains(
    MSGQ_NAME: MSGQ_LIB: '*EMPTY': *omit: *omit: g_startTime);

end-proc;
** test1
      * ===================================================================== *
      * RPGUnit test:  Standard STRPREPRC header.                             *
      * ===================================================================== *
      * Expected behavior:  a) Execute pre-commands.                          *
      *                     b) Execute create-command.                        *
      *                     c) Execute post-commands.                         *
      * ===================================================================== *
      * >>PRE-COMPILER<<                                                      *
      *   >>CRTCMD<<  SNDMSG MSG('MAIN: Create Command') +                    *
      *                 TOMSGQ(QTEMP/STRPREPRC);                              *
      *   >>CMD<<  SNDMSG MSG('PRE: Pre-command 1') TOMSGQ(QTEMP/STRPREPRC);  *
      *   >>CMD<<  SNDMSG MSG('PRE: Pre-command 2') TOMSGQ(QTEMP/STRPREPRC);  *
      *   >>EXECUTE<<                                                         *
      *   >>CMD<<  SNDMSG MSG('POST: Post-command 1') TOMSGQ(QTEMP/STRPREPRC);*
      *   >>CMD<<  SNDMSG MSG('POST: Post-command 2') TOMSGQ(QTEMP/STRPREPRC);*
      * >>END-PRE-COMPILER<<                                                  *
      * ===================================================================== *
** test2
      * ===================================================================== *
      * RPGUnit test:  STRPREPRC header where the EXECUTE tag is missing.     *
      * ===================================================================== *
      * Expected behavior:  a) Execute pre-commands.                          *
      *                     b) Never execute create-command                   *
      *                        since the EXECUTE tag is missing.              *
      *                     c) Never execute post-commands                    *
      *                        since they are missing, due to the             *
      *                        missing execute tag.                           *
      * ===================================================================== *
      * >>PRE-COMPILER<<                                                      *
      *   >>CRTCMD<<  SNDMSG MSG('MAIN: Create Command') +                    *
      *                 TOMSGQ(QTEMP/STRPREPRC);                              *
      *   >>CMD<<  SNDMSG MSG('PRE: Pre-command 1') TOMSGQ(QTEMP/STRPREPRC);  *
      *   >>CMD<<  SNDMSG MSG('PRE: Pre-command 2') TOMSGQ(QTEMP/STRPREPRC);  *
      * >>END-PRE-COMPILER<<                                                  *
      * ===================================================================== *
** test3
      * ===================================================================== *
      * RPGUnit test:  STRPREPRC header is missing, so all we might have is   *
      *                the command specified at parameter CMD.                *
      * ===================================================================== *
      * Expected behavior:  a) Never execute-pre commands                     *
      *                        since they are missing.                        *
      *                     b) Execute create-command implicitly.             *
      *                     c) Never execute post-commands                    *
      *                        since they are missing.                        *
      * ===================================================================== *
