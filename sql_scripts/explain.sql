-- ===============================================================
-- NAME: explain.sql
-- DESCRIPTION: Displays query plan
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select * from table(dbms_xplan.display());

