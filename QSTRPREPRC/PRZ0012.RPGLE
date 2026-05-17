**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : PRZ0012

// Fehler beim Öffnen der Quellendatei &2/&1, Teildatei &3.

dcl-ds PRZ0012;
  PRZ00121 char(010) inz(*blanks);
  PRZ00122 char(010) inz(*blanks);
  PRZ00123 char(010) inz(*blanks);
end-ds;
dcl-s PRZ0012_LEN bindec(8) inz(0030);

