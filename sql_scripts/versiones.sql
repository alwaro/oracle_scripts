-- ===============================================================
-- NAME: versiones.sql
-- DESCRIPTION: Displays oracle versions and actions registered
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set lines 250
set pages 999
col action format a20
col version format a14
col BUNDLE_SERIES format a10
col COMMENTS format a30
select * from v$version;
prompt
select  ACTION,VERSION,COMMENTS,action_time from dba_registry_history;



