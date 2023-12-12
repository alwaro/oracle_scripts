-- ===============================================================
-- NAME: queries_modifican_100M_rows.sql
-- DESCRIPTION: Lists the queries what are modifying more than 100 Millions of rows each execution
-- USAGE: execute
-- AUTHOR: Adapted from internet
-- ---------------------------------------------------------------
prompt
prompt ======= LISTADO DE QUERIES QUE MODIFICAN MAS DE 100 MILLONES DE ROWS CADA EJECUCION ==========
PROMPT
select SQL_ID, executions, rows_processed
from v$sql
where rows_processed > 10000000
and command_type not in (3,47)  
and parsing_user_id != 0               -- to ignore SYS
and command_type != 47                 -- to ignore PL/SQL
order by rows_processed desc;
