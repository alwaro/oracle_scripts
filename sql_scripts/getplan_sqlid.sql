-- ===============================================================
-- NAME: getplan_sqlid.sql
-- DESCRIPTION: Displays sql_id from a plan
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 150
select * from table(dbms_xplan.display_cursor('&sql_id','&child_no','typical'))
/

