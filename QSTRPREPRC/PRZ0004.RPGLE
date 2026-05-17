**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : PRZ0004

// Die Marke &1 ist außerhalb der Betriebsart &2 nicht erlaubt

dcl-ds PRZ0004;
  PRZ00041 char(030) inz(*blanks);
  PRZ00042 char(030) inz(*blanks);
end-ds;
dcl-s PRZ0004_LEN bindec(8) inz(0060);

