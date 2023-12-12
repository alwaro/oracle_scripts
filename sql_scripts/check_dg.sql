-- ===============================================================
-- NAME: check_dg.sql
-- DESCRIPTION: Shows DG status
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select sequence#,registrar,applied from v$archived_log order by 1;

