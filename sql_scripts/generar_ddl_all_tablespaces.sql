-- ===============================================================
-- NAME: generar_ddl_all_tablespaces.sql
-- DESCRIPTION: Displays metadata from tablespaces
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set heading off;
set lines 170;
set echo off;
Set pages 999;
set long 99999999;
spool ddl_all_ts.sql
select dbms_metadata.get_ddl('TABLESPACE',tb.tablespace_name) from dba_tablespaces tb;
spool off

