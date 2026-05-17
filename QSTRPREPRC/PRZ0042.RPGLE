**free
// ---------------------------------------------------------------
//  Data structure for message ID: PRZ0042
//  Record length of IFS source file exceeds maximum.
dcl-ds PRZ0042;
  PRZ00421 packed(10) inz(*zeros);
  PRZ00422 packed(10) inz(*zeros);
  PRZ00423 char(256) inz(*blanks);
  PRZ00424 char(256) inz(*blanks);
end-ds;
dcl-s PRZ0042_SIZE int(10) inz(524);
