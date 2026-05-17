**free
// ---------------------------------------------------------------
//  Data structure for message ID: PRZ0031

//  Verschachtelte INCLUDE Marke in Zeile &4 der Datei &2/&1, Teil

dcl-ds PRZ0032;
  PRZ00321 char(010) inz(*blanks);
  PRZ00322 char(010) inz(*blanks);
  PRZ00323 char(010) inz(*blanks);
  PRZ00324 packed(006: 2) inz(*zeros);
end-ds;
dcl-s PRZ0032_SIZE bindec(8) inz(0036);

