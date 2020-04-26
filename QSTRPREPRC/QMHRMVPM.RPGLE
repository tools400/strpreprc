      /if not defined(QMHRMVPM)
      /define QMHRMVPM
     d QMHRMVPM...
     d                 PR                         extpgm('QMHRMVPM')
     d  i_callStackE                 10a   const
     d  i_callStackC                 10i 0 const
     d  i_msgKey                      4a   const
     d  i_msgToRmv                   10a   const
     d  i_errCode                 32767a         options(*varsize)
     d  i_lenCalStkE                 10i 0       options(*nopass)
     d  i_calStkEQual                20a         options(*nopass)
     d  i_rmvExcp                    10a         options(*nopass)
     d  i_calStkeDTyp                10a         options(*nopass)
      /endif
