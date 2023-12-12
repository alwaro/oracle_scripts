-- ===============================================================
-- NAME: check_dg3.sql
-- DESCRIPTION: Shows DG status
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select db_unique_name, database_role, OPEN_MODE, PROTECTION_MODE from v$database;
