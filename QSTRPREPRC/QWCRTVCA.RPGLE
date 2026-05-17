**free
/if not defined(QWCRTVCA)
/define QWCRTVCA

//  Retrieve Current Attributes (QWCRTVCA) API
dcl-pr QWCRTVCA extpgm('QWCRTVCA');
  o_rcvVar     char(65535) options(*varsize);
  i_lenRcvVar  int(10) const;
  i_format     char(8) const;
  i_numAttrRtn int(10) const;
  i_keyAttrRtn int(10) dim(100) const;
  io_errCode   char(65535) options(*varsize);
end-pr;

dcl-ds QWCRTVCA_attrInf_t qualified based(pDummy);
  lenAttr    int(10);
  key        int(10);
  dataType   char(1);
  reserved_1 char(3);
  lenData    int(10);
//   data         CHAR(*)
//   reserved     CHAR(*)
end-ds;

//  RTVC0100 Format
dcl-ds rtvc0100_t qualified based(pDummy);
  numAttrRtn int(10);
//   attrInf      Array (*) of QWCRTVCA_attrInf_t
end-ds;

dcl-s QWCRTVCA_libName_t char(11);

//  RTVC0200 Format
dcl-ds rtvc0200_t qualified based(pDummy);
  bytRet       int(10);
  bytAvl       int(10);
  numSysLiblE  int(10);
  numPrdLiblE  int(10);
  curLibExists int(10);
  numUsrLiblE  int(10);
//   library list Array (*) of CHAR(11)
end-ds;

dcl-ds QWCRTVCA_aspGrpInfE_t qualified based(pDummy);
  name char(10);
//   reserved     CHAR(*)
end-ds;

//  RTVC0300 Format
dcl-ds rtvc0300_t qualified based(pDummy);
  bytRet        int(10);
  bytAvl        int(10);
  offsAspGrpInf int(10);
  numAspGrpInfE int(10);
  lenAspGrpInfE int(10);
//   ASP group information entry Array (*) of CHAR(11)
end-ds;

dcl-c CURLIB_MISSING 0;
dcl-c CURLIB_EXISTS 1;

// Keys of format RTVC0100
dcl-c KEY_ALLOW_MULTIPLE_THREADS 0102; // CHAR(1)
dcl-c KEY_BREAK_MESSAGE_HANDLING 0201; // CHAR(10)
dcl-c KEY_CANCEL_KEY 0301; // CHAR(1)
dcl-c KEY_CODED_CHARACTER_SET_ID 0302; // BINARY(4)
dcl-c KEY_COUNTRY_OR_REGION_ID 0303; // CHAR(2)
dcl-c KEY_CURRENT_USER_PROFILE 0305; // CHAR(10)
dcl-c KEY_CURRENT_SYSTEM_POOL_IDENTIFIER 0307; // BINARY(4)
dcl-c KEY_CHARACTER_IDENTIFIER_CONTROL 0311; // CHAR(10)
dcl-c KEY_DATE_AND_TIME_JOB_BECAME_ACTIVE 0401; // CHAR(13)
dcl-c KEY_DATE_AND_TIME_JOB_ENTERED_SYSTEM 0402; // CHAR(13)
dcl-c KEY_DATE_AND_TIME_JOB_WAS_SCHEDULED_TO_RUN 0403; // CHAR(8)
dcl-c KEY_DATE_FORMAT 0405; // CHAR(4)
dcl-c KEY_DATE_SEPARATOR 0406; // CHAR(1)
dcl-c KEY_DBCS_CAPABLE 0407; // CHAR(1)
dcl-c KEY_DDM_CONVERSATION_HANDLING 0408; // CHAR(10)
dcl-c KEY_DEFAULT_WAIT 0409; // BINARY(4)
dcl-c KEY_DEVICE_RECOVERY_ACTION 0410; // CHAR(13)
dcl-c KEY_DEFAULT_CODED_CHARACTER_SET_IDENTIFIER 0412; // BINARY(4)
dcl-c KEY_DECIMAL_FORMAT 0413; // CHAR(1)
dcl-c KEY_END_SEVERITY 0501; // BINARY(4)
dcl-c KEY_END_STATUS 0502; // CHAR(1)
dcl-c KEY_EXIT_KEY 0503; // CHAR(1)
dcl-c KEY_GROUP_PROFILE_NAME 0702; // CHAR(10)
dcl-c KEY_GROUP_PROFILE_NAME_SUPPLEMENTAL 0703; // CHAR(105)
dcl-c KEY_INQUIRY_MESSAGE_REPLY 0901; // CHAR(10)
dcl-c KEY_INTERNAL_JOB_ID 0902; // CHAR(16)
dcl-c KEY_INITIAL_THREAD 0903; // CHAR(1)
dcl-c KEY_JOB_ACCOUNTING_CODE 1001; // CHAR(15)
dcl-c KEY_JOB_DATE 1002; // CHAR(7)
dcl-c KEY_JOB_QUEUE_NAME_QUALIFIED 1004; // CHAR(20)
dcl-c KEY_JOB_QUEUE_PRIORITY 1005; // CHAR(2)
dcl-c KEY_JOB_SWITCHES 1006; // CHAR(8)
dcl-c KEY_JOB_MESSAGE_QUEUE_FULL_ACTION 1007; // CHAR(10)
dcl-c KEY_JOB_MESSAGE_QUEUE_MAXIMUM_SIZE 1008; // BINARY(4)
dcl-c KEY_JOB_NAME 1009; // CHAR(26)
dcl-c KEY_JOB_TYPE 1010; // CHAR(1)
dcl-c KEY_JOB_SUBTYPE 1011; // CHAR(1)
dcl-c KEY_JOB_LOCAL_TIME 1017; // CHAR(8)
dcl-c KEY_JOB_LOG_OUTPUT 1018; // CHAR(10)
dcl-c KEY_LANGUAGE_ID 1201; // CHAR(3)
dcl-c KEY_LOGGING_LEVEL 1202; // CHAR(1)
dcl-c KEY_LOGGING_OF_CL_PROGRAMS 1203; // CHAR(10)
dcl-c KEY_LOGGING_SEVERITY 1204; // BINARY(4)
dcl-c KEY_LOGGING_TEXT 1205; // CHAR(10)
dcl-c KEY_MAXIMUM_THREADS 1304; // BINARY(4)
dcl-c KEY_OUTPUT_QUEUE_NAME_QUALIFIED 1501; // CHAR(20)
dcl-c KEY_OUTPUT_QUEUE_PRIORITY 1502; // CHAR(2)
dcl-c KEY_PRINT_KEY_FORMAT 1601; // CHAR(10)
dcl-c KEY_PRINT_TEXT 1602; // CHAR(30)
dcl-c KEY_PRINTER_DEVICE_NAME 1603; // CHAR(10)
dcl-c KEY_PURGE 1604; // CHAR(10)
dcl-c KEY_RUN_PRIORITY 1802; // BINARY(4)
dcl-c KEY_SORT_SEQUENCE_TABLE_QUALIFIED 1901; // CHAR(20)
dcl-c KEY_STATUS_MESSAGE_HANDLING 1902; // CHAR(10)
dcl-c KEY_SUBMITTER_JOB_NAME_QUALIFIED 1904; // CHAR(26)
dcl-c KEY_SUBMITTER_MESSAGE_QUEUE_NAME_QUALIFIED 1905; // CHAR(20)
dcl-c KEY_SYSTEM_POOL_IDENTIFIER 1907; // BINARY(4)
dcl-c KEY_SPOOLED_FILE_ACTION 1982; // CHAR(10)
dcl-c KEY_TIME_SEPARATOR 2001; // CHAR(1)
dcl-c KEY_TIME_SLICE 2002; // BINARY(4)
dcl-c KEY_TIME_SLICE_END_POOL 2003; // CHAR(10)
dcl-c KEY_THREAD_COUNT 2008; // BINARY(4)
dcl-c KEY_TIME_ZONE_CURRENT_ABBREVIATED_NAME 2020; // CHAR(10)
dcl-c KEY_TIME_ZONE_CURRENT_FULL_NAME 2021; // CHAR(50)
dcl-c KEY_TIME_ZONE_CURRENT_MESSAGE_IDENTIFIER 2022; // CHAR(7)
dcl-c KEY_TIME_ZONE_CURRENT_OFFSET 2023; // BINARY(4)
dcl-c KEY_TIME_ZONE_DESCRIPTION_NAME 2024; // CHAR(10)
dcl-c KEY_TIME_ZONE_MESSAGE_FILE_NAME_QUALIFIED 2025; // CHAR(20)
dcl-c KEY_TIME_ZONE_DAYLIGHT_SAVING_TIME_INDICATOR 2026; // CHAR(1)

// Keys of format RTVC0200
dcl-c KEY_CURRENT_LIBRARY 0310; // CHAR(11)
dcl-c KEY_PRODUCT_LIBRARIES 1660; // Array(*) of CHAR(
dcl-c KEY_SYSTEM_LIBRARIES 1980; // Array(*) of CHAR(
dcl-c KEY_USER_LIBRARIES 2110; // Array(*) of CHAR(
dcl-c KEY_ALL_LIBRARIES_OF_FORMAT_RTVC0200 2702; // Array(*) of CHAR(

// Keys of format RTVC0300
dcl-c KEY_ASP_GROUP_INFORMATION 0104; // CHAR(*)

/endif
