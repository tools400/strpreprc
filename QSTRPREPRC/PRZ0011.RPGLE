**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : PRZ0011

// Die Datensatzlänge der Eingabedatei ist zu lang.

dcl-ds PRZ0011;
  PRZ00111 packed(010) inz(*zeros);
  PRZ00112 packed(010) inz(*zeros);
  PRZ00113 char(010) inz(*blanks);
  PRZ00114 char(010) inz(*blanks);
end-ds;
dcl-s PRZ0011_LEN bindec(8) inz(0032);

