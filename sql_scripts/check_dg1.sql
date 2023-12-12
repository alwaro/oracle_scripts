-- ===============================================================
-- NAME: check_dg1.sql
-- DESCRIPTION: Shows DG status
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
select sequence#,registrar,applied from v$archived_log;
