-- ===============================================================
-- NAME: check_dg_lag.sql
-- DESCRIPTION: Shows DG status
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
COL VALUE FORMAT A20
SELECT SOURCE_DB_UNIQUE_NAME,NAME, VALUE,TIME_COMPUTED,DATUM_TIME FROM v$dataguard_stats;

