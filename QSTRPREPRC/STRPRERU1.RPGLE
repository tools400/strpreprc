      *=====================================================================*
      *  iRPGUnit Test - Cmd Parameter EXECOPT.                             *
      *=====================================================================*
      *   >>PRE-COMPILER<<                                                  *
      *     >>CRTCMD<<  RUCRTTST    TSTPGM(&LI/&OB) +                       *
      *                             SRCFILE(&SL/&SF) SRCMBR(&SM);           *
      *     >>IMPORTANT<<                                                   *
      *       >>PARM<< COPTION(*EVENTF);                                    *
      *       >>PARM<< DBGVIEW(*LIST);                                      *
      *       >>PARM<< BNDDIR(*N);                                          *
      *     >>END-IMPORTANT<<                                               *
      *     >>EXECUTE<<                                                     *
      *   >>END-PRE-COMPILER<<                                              *
      *=====================================================================*
      *  Compile options:                                                   *
      *    *SrcStmt       - Assign SEU line numbers when compiling the      *
      *                     source member. This option is required to       *
      *                     position the LPEX editor to the line in error   *
      *                     when the source member is opened from the       *
      *                     RPGUnit view.                                   *
      *    *NoDebugIO     - Do not generate breakpoints for input and       *
      *                     output specifications. Optional but useful.     *
      *=====================================================================*
     H NoMain Option(*SrcStmt : *NoDebugIO)

     FSRCFILE   UF A F  112        DISK    usropn
     F                                     extfile(g_useSrcFile.name)
     F                                     extmbr(g_useSrcFile.member)

     D g_useSrcFile    ds                  qualified
     D  name                         21a   varying
     D  member                       10a   varying

      /include qinclude,TESTCASE                  iRPGUnit Test Suite

     D test1           s             80a   dim(17) ctdata
     D test2           s             80a   dim(17) ctdata
     D test3           s             80a   dim(10) ctdata

     D setUpSuite...
     D                 pr                  extproc('setUpSuite')

     D tearDownSuite...
     D                 pr                  extproc('tearDownSuite')

     D setUp...
     D                 pr                  extproc('setUp')

     D tearDown...
     D                 pr                  extproc('tearDown')

     D testStandardHeader...
     D                 pr                  extproc('+
     D                                     testStandardHeader+
     D                                     ')

     D testNoExecuteTag...
     D                 pr                  extproc('+
     D                                     testNoExecuteTag+
     D                                     ')

     D testNoTagsAtAll_1...
     D                 pr                  extproc('+
     D                                     testNoTagsAtAll_1+
     D                                     ')

     D testNoTagsAtAll_2...
     D                 pr                  extproc('+
     D                                     testNoTagsAtAll_2+
     D                                     ')

     D MSGQ_LIB        c                   'QTEMP'
     D MSGQ_NAME       c                   'STRPREPRC'
     D MSGQ_FULL_NAME  c                   'QTEMP/STRPREPRC'

     D BASE_CMD        c                   'STRPREPRC +
     D                                      USESRCFILE(QTEMP/QSTRPREPRC) +
     D                                      USESRCMBR(STRPRERU)'

     D g_startTime     s               z

       // ============================================================
       //  Set up test suite. Executed once per RUCALLTST.
       // ============================================================
     P setUpSuite...
     P                 b                   export
     D                 pi
      /free

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

      /end-free
     P                 e

       // ============================================================
       //  Tear down test suite.
       // ============================================================
     P tearDownSuite...
     P                 b                   export
     D                 pi
      /free

       runCmd('DLTF FILE(QTEMP/QSTRPREPRC)');

       runCmd('DLTMSGQ MSGQ(' + MSGQ_FULL_NAME + ')');

      /end-free
     P                 e

       // ============================================================
       //  Set up test case.
       // ============================================================
     P setUp...
     P                 b                   export
     D                 pi
      /free

       runCmd('CLRPFM FILE(QTEMP/QSTRPREPRC) MBR(STRPRERU)');

       runCmd('CLRMSGQ MSGQ(' + MSGQ_FULL_NAME + ')');

       g_startTime = getFullTimeStamp();

      /end-free
     P                 e

       // ============================================================
       //  Tear down test case.
       // ============================================================
     P tearDown...
     P                 b                   export
     D                 pi
      /free

      /end-free
     P                 e

       // ============================================================
       //  RPGUnit test case.
       // ============================================================
     P testStandardHeader...
     P                 b                   export
     D                 pi

     D i               s             10i 0
     D srcLine         ds                  qualified
     D  srcSeq                        6s 2
     D  srcDat                        6s 0
     D  srcDta                      100a
      /free

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

      /end-free
     P                 e

       // ============================================================
       //  RPGUnit test case.
       // ============================================================
     P testNoExecuteTag...
     P                 b                   export
     D                 pi

     D i               s             10i 0
     D srcLine         ds                  qualified
     D  srcSeq                        6s 2
     D  srcDat                        6s 0
     D  srcDta                      100a
      /free

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

      /end-free
     P                 e

       // ============================================================
       //  RPGUnit test case.
       // ============================================================
     P testNoTagsAtAll_1...
     P                 b                   export
     D                 pi

     D i               s             10i 0
     D srcLine         ds                  qualified
     D  srcSeq                        6s 2
     D  srcDat                        6s 0
     D  srcDta                      100a
      /free

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

      /end-free
     P                 e

       // ============================================================
       //  RPGUnit test case.
       // ============================================================
     P testNoTagsAtAll_2...
     P                 b                   export
     D                 pi

     D i               s             10i 0
     D srcLine         ds                  qualified
     D  srcSeq                        6s 2
     D  srcDat                        6s 0
     D  srcDta                      100a
      /free

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

      /end-free
     P                 e
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
