-- ===============================================================
-- NAME: undo_advisor.sql
-- DESCRIPTION: Displays the reccomended amount of undo tablespace.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set serveroutput on
DECLARE
utbsiz_in_MB NUMBER;
BEGIN
utbsiz_in_MB := DBMS_UNDO_ADV.RBU_MIGRATION;
dbms_output.put_line('===================================================================');
dbms_output.put_line('Segun lo presente en flashback, el UNDO perfecto seria de: '||utbsiz_in_MB||' MB');
dbms_output.put_line('===================================================================');
end;
/
