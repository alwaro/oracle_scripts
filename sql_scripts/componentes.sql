-- ===============================================================
-- NAME: componentes.sql
-- DESCRIPTION: Shows components
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col COMP_NAME format a40
select COMP_NAME,VERSION,STATUS from dba_registry;
