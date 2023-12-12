-- ===============================================================
-- NAME: explain_all.sql
-- DESCRIPTION: Displays query plan
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT *
FROM table(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'ALLSTATS LAST'));

