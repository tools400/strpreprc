      /if not defined(proto_h)
      /define proto_h

     D enableEventFile...
     D                 pr
     D                                     extproc('STRPREPRC4_+
     D                                     enableEventFile+
     D                                     ')

     D isEmptyEventFile...
     D                 pr              n
     D                                     extproc('STRPREPRC4_+
     D                                     isEmptyEventFile+
     D                                     ')
     D  i_lib                        10a   const
     D  i_obj                        10a   const

     D clearEventFile...
     D                 pr
     D                                     extproc('STRPREPRC4_+
     D                                     clearEventFile+
     D                                     ')
     D  i_obj                        10a   const
     D  i_lib                        10a   const

     D prepareEventFile...
     D                 pr
     D                                     extproc('STRPREPRC4_+
     D                                     prepareEventFile+
     D                                     ')

     D openEventFile...
     D                 pr              n
     D                                     extproc('STRPREPRC4_+
     D                                     openEventFile+
     D                                     ')
     D  i_obj                        10a   const
     D  i_lib                        10a   const
     D  i_append                       n   const

     D writeEventFile...
     D                 pr                  extproc('STRPREPRC4_+
     D                                     writeEventFile+
     D                                     ')
     D  i_srcFile                    10a   const
     D  i_srcLib                     10a   const
     D  i_srcMbr                     10a   const
     D  i_lineNumber                 10i 0 const
     D  i_isAbnEnd                     n   const

     D closeEventFile...
     D                 pr                  extproc('STRPREPRC4_+
     D                                     closeEventFile+
     D                                     ')

     D copyEventFile...
     D                 pr                  extproc('STRPREPRC4_+
     D                                     copyEventFile+
     D                                     ')
     D  i_fromLib                    10a   const
     D  i_fromMbr                    10a   const
     D  i_toLib                      10a   const
     D  i_toMbr                      10a   const

      /endif
