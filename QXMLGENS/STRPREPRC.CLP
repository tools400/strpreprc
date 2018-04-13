/* -------------------------------------------------------------------------- */
/* STRPREPRC  - SCRIPT MEMBER (German)                                        */
/* Use commands  xmlgenINC (generate text for install pgm)                    */
/*               xmlgenMBR (to define source members                          */
/*               xmlgenCMD (execute qcmdexc at run time                       */
/* Put &TOLIB where you want user selected lib at run time.                   */
   DCL &TOLIB *CHAR 10
/* -------------------------------------------------------------------------- */
             XMLGENINC  XINCLUDE(*YES)

             XMLGENCND  XMSG('Select language (GER, ENG)') +
                          XVALUES(GER ENG) XVAR(&LANG)

             XMLGENCND  XMSG('Default for TAGSREQ(*NO|*YES) Dft: NO') +
                          XVALUES(NO YES) XVAR(&TAGSREQ)

             XMLGENSET  XVAR(&SRCFILE) XVALUE(QSTRPREPRC)

/* ---------------------------------- */
/*  Deploy source member              */
/* ---------------------------------- */
             XMLGENMBR  XMBR(A_INSTALL ) XMBRATR(CLLE ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_MSG_ENG ) XMBRATR(CLP  ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_MSG_GER ) XMBRATR(CLP  ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_README  ) XMBRATR(TXT  ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(COPYRIGHT ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(H_SPEC    ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PROTO_H   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0001   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0002   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0003   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0004   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0005   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0006   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0007   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0008   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0009   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0010   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0011   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0012   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0013   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0014   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0015   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0016   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0017   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0018   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0019   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0020   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0021   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0022   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0023   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0024   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0025   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0026   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0027   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0028   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0029   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(PRZ0030   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QCAPCMD   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QMHRCVPM  ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QMHRTVM   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QUSRMBRD  ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QWCRTVCA  ) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(STRPREPRCP) XMBRATR(PNLGRP) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PNLGRP) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(STRPREPRCQ) XMBRATR(PNLGRP) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*PNLGRP) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(STRPRE1   ) XMBRATR(PF   ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*FILE  ) +
                          XGENCRT(*NO) XPARAM('MAXMBRS(1)')

             XMLGENMBR  XMBR(STRPRE2   ) XMBRATR(PF   ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*FILE  ) +
                          XGENCRT(*NO) XPARAM('MAXMBRS(1)')

             XMLGENMBR  XMBR(STRPREPRC1) XMBRATR(CLLE ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*MODULE) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(STRPREPRC2) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*MODULE) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(STRPREPRC3) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*MODULE) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(STRPREPRC4) XMBRATR(RPGLE) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*MODULE) +
                          XGENCRT(*NO) XPARAM(*BLANK)

             XMLGENMBR  XMBR(STRPREPRCG) XMBRATR(CMD  ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*CMD ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(STRPREPRCE) XMBRATR(CMD  ) +
                          XFROMSRCF(QSTRPREPRC) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QSTRPREPRC) XOBJTYPE(*CMD ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

/* ---------------------------------- */
/*  Create objects                    */
/* ---------------------------------- */
             XMLGENCMD  XCMD(CRTBNDCL PGM(&TOLIB/A_INSTALL) +
                          SRCFILE(&TOLIB/QSTRPREPRC) SRCMBR(*PGM) +
                          DFTACTGRP(*NO) ACTGRP(*NEW) +
                          DBGVIEW(*LIST)) XDLTSPLF(A_INSTALL)

             XMLGENCMD  XCMD(CALL PGM(&TOLIB/A_INSTALL) +
                             PARM('&TGTRLS' '&SRCFILE' '&TOLIB' '&LANG' '&TAGSREQ'))
             XMLGENCMD  XCMD(DLTPGM PGM(&TOLIB/A_INSTALL))

