**free
//---------------------------------------------------------------
// Datenstruktur für Message-ID : PRZ0023

// Fehlender Wert für Variable an Position &1 des auszuführend

dcl-ds PRZ0023;
  PRZ00231 packed(010) inz(*zeros);
  PRZ00232 char(512) inz(*blanks);
end-ds;
dcl-s PRZ0023_LEN bindec(8) inz(0518);

