-- ===============================================================
-- NAME: getplan_query.sql
-- DESCRIPTION: Display plan from a query
-- USAGE: Ask for a query
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
set pages 200
explain plan for 
'&query';

select * from table(dbms_xplan.display());
