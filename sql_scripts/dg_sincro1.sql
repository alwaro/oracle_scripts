-- ===============================================================
-- NAME: dg_sincro2.sql
-- DESCRIPTION: Displays DG info
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select sequence#,registrar,applied from v$archived_log;

