-- ===============================================================
-- NAME: getfullscans.sql
-- DESCRIPTION: Displays info when fullscans is happening in a table
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select s .sid, s. serial#, s.sql_id ,s. username,s.event ,s. seconds_in_wait, s.state, q.sql_fulltext ,q. sql_text from gv$session s , v$sqlstats q where s.sql_id =q. sql_id and s.status ='ACTIVE'
and s.sql_id in (
SELECT SQL_ID
FROM V$SQL_PLAN
WHERE OPTIONS like '%FULL%' AND OPERATION like '%TABLE%'
 ) and q.sql_text not like ' select s .sid, s. serial#, s.sql_id ,s. username,s.event ,s. seconds_in_wait, s%'
/
