-- ===============================================================
-- NAME: find.sql
-- DESCRIPTION: Search and display for a specified object
-- USAGE: Specify object
-- AUTHOR:
-- ---------------------------------------------------------------
set verify off
DEF objeto='&1';
col OBJECT_NAME format a45
spoo search_&&objeto.log
select owner, object_name, object_type,CREATED,STATUS, LAST_DDL_TIME from dba_objects where object_name like '%&&objeto%';
undef objeto;
undef 1;
spoo off

