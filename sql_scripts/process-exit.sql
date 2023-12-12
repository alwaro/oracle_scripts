-- ===============================================================
-- NAME: process-exit.sql
-- DESCRIPTION: Generates a query that displays the runing process.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set echo off
set heading off
set feedback off
spoo /tmp/procesos-prosmx.log
select current_utilization from v$resource_limit where resource_name = 'processes';
spoo off;
exit;

