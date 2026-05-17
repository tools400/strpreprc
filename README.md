# STRPREPRC - A Tools/400 Utility

STRPREPRC is utility for retrieving object creation parameters from the
source member that is compiled and building and executing the final
object creation command.

## Dependencies

Dependencies:

- BASICS1
- EVENTF
- JOBLOG

## Installation

Compile members with the following PDM option:

   STRPREPRC USESRCFILE(&L/&F) USESRCMBR(&N) OPTION(*EVENTF) CHGOBJD(*NO)
     LIB(&O) OBJ(&N) SRCLIB(&L) SRCFILE(&F) SRCMBR(&N) USER0(&X)
     USER1(*LIST) USER2(*FULL)

Members of type MAKPGM or BND are used for linking programs (MAKPGM)
and service programs (BND).

---

2018, Thomas Raddatz
