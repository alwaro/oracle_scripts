-- ===============================================================
-- NAME: get_ddl_tabla.sql
-- DESCRIPTION: Gets metadata from a table
-- USAGE: ask for a table
-- AUTHOR:
-- ---------------------------------------------------------------
set echo off
set feedback off
set linesize 184
set long 3000000
set pagesize 0
set trims on
column txt format a180 word_wrapped
spool definicion_&&OWNER..&&INDICE..sql
select DBMS_METADATA.GET_DDL('INDEX','&INDICE','&OWNER') txt FROM dual;
spool off
UNDEF INDICE
UNDEF OWNER
