**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : PRZ0005

// Ungültiges Fortsetzungszeichen &1 in Zeile &2 gefunden.

dcl-ds PRZ0005;
  PRZ00051 char(010) inz(*blanks);
  PRZ00052 packed(006: 2) inz(*zeros);
end-ds;
dcl-s PRZ0005_LEN bindec(8) inz(0014);

