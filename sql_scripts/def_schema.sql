-- ===============================================================
-- NAME: def_schema.sql
-- DESCRIPTION: Shows schema info
-- USAGE: Ask for schema_name
-- AUTHOR: AANAYAMA
-- ---------------------------------------------------------------
set echo off
set long 1000000000
set lines 160
set pages 999
SET FEEDBACK OFF
SET VERIFY OFF
set heading off
spoo definition-schema-&&SCHEMA_NAME..log
prompt ------------ SCHEMA &&SCHEMA_NAME STATUS AND CONFIG -------------;
SELECT
    'USER NAME..............: '||USERNAME||chr(10)||
    'ACCOUNT_STATUS.........: '||ACCOUNT_STATUS||chr(10)||
    'LOCK_DATE..............: '||LOCK_DATE||chr(10)||
    'EXPIRY_DATE............: '||EXPIRY_DATE||chr(10)||
    'DEFAULT_TABLESPACE.....: '||DEFAULT_TABLESPACE||chr(10)||
    'TEMPORARY_TABLESPACE...: '||TEMPORARY_TABLESPACE||chr(10)||
    'CREATED................: '||CREATED||chr(10)||
    'PROFILE................: '||PROFILE||chr(10)
FROM DBA_USERS WHERE
    USERNAME=upper('&&SCHEMA_NAME');
-- SHOWING THE SIZE
set HEADING ON
select sum(bytes)/1024/1024 as "SCHEMA SIZE in Mb" from dba_segments where owner=upper('&&SCHEMA_NAME');
set heading off
prompt  
prompt  
prompt ------------ SCHEMA &&SCHEMA_NAME FULL DEFINITION --------------;
SELECT dbms_metadata.get_ddl('USER',upper('&&SCHEMA_NAME')) FROM dual;
prompt 
PROMPT --ASSIGNED ROLES (errors may means no grants):
SELECT DBMS_METADATA.GET_GRANTED_DDL('ROLE_GRANT',upper('&&SCHEMA_NAME')) from dual;
prompt  
PROMPT --OBJECTS GRANTS (errors may means no grants):
SELECT DBMS_METADATA.GET_GRANTED_DDL('OBJECT_GRANT',upper('&&SCHEMA_NAME')) from dual;
prompt  
PROMPT --SYSTEM GRANTS (errors may means no grants):
SELECT DBMS_METADATA.GET_GRANTED_DDL('SYSTEM_GRANT',upper('&&SCHEMA_NAME')) from dual;
prompt  
PROMPT --------------------- SCHEMA DEFINITION ENDS ------------------------;
spoo off;
set heading on
set verify on
set feedback on
undef SCHEMA_NAME

