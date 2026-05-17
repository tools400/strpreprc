**free
/if not defined(SDS)
/define SDS
dcl-ds sds qualified psds;
  pgmName  char(10);
  status   zoned(5);
  prvStat  zoned(5);
  lastSeq  char(8);
  lastSubR char(8);
  numParm  zoned(3);
  msgID    char(7);
  MiInstr  char(4);
  wrkArea  char(30);
  pgmLib   char(10);
  msgText  char(80);
end-ds;
/endif
