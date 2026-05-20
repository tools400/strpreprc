**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : PRZ0013

// Fehler beim Öffnen der Steuerdatei &2/&1, Teildatei &3.

dcl-ds PRZ0013;
  PRZ00131 char(010) inz(*blanks);
  PRZ00132 char(010) inz(*blanks);
  PRZ00133 char(010) inz(*blanks);
end-ds;
dcl-s PRZ0013_LEN bindec(8) inz(0030);

