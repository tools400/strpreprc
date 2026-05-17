**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : PRZ0001

// Falsche Reihenfolge im Betriebsmodus.

dcl-ds PRZ0001;
  PRZ00011 char(030) inz(*blanks);
  PRZ00012 char(030) inz(*blanks);
end-ds;
dcl-s PRZ0001_LEN bindec(8) inz(0060);

