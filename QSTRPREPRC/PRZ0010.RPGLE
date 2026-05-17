**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : PRZ0010

// Modus für Marke &1 nicht definiert.

dcl-ds PRZ0010;
  PRZ00101 char(030) inz(*blanks);
end-ds;
dcl-s PRZ0010_LEN bindec(8) inz(0030);

