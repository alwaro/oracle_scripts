-- ===============================================================
-- NAME: invalidos.sql
-- DESCRIPTION: Display invalid objects and components
-- USAGE: Execute
-- AUTHOR: Alvaro Anaya
-- ---------------------------------------------------------------
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
col owner format a25
COLUMN object_name FORMAT A30
col status format a10
col COMP_NAME format a40
prompt
prompt COMPONENTES
PROMPT ===================================================================================================================
select COMP_NAME,VERSION,MODIFIED,STATUS from dba_registry;
PROMPT 
PROMPT 
PROMPT OBJETOS INVALIDOS
PROMPT ===================================================================================================================
SELECT owner,object_name,object_type, status, last_ddl_time  FROM dba_objects
WHERE status = 'INVALID' ORDER BY owner, object_name, object_type;

