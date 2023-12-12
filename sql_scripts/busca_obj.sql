-- ===============================================================
-- NAME: busca_obj.sql
-- DESCRIPTION: Search object and shows status
-- USAGE: Needs object_name
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 250
col owner format a20
col OBJECT_TYPE format a35
col OBJECT_NAME format a35
col STATUS format a8
--SET VERIFY OFF
select OWNER,OBJECT_NAME,OBJECT_TYPE,CREATED,LAST_DDL_TIME,STATUS from dba_objects where object_name like upper('%&&NOMBRE_DEL_OBJETO%');


