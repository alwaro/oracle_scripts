-- ===============================================================
-- NAME: instancia.sql
-- DESCRIPTION: Display instance info
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 250
set pages 999
col HOST_NAME format a30
select inst_id, INSTANCE_NAME,HOST_NAME,VERSION,to_char(STARTUP_TIME,'dd.mm.yyyy hh24:mi') STARTUP,STATUS,LOGINS from gv$instance;

