-- ===============================================================
-- NAME: dg_sincro2.sql
-- DESCRIPTION: Displays DG info
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
COL VALUE FORMAT A20
SELECT SOURCE_DB_UNIQUE_NAME,NAME, VALUE,TIME_COMPUTED,DATUM_TIME FROM v$dataguard_stats;

