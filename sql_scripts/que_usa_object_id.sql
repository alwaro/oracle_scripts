-- ===============================================================
-- NAME: que_usa_object_id.sql
-- DESCRIPTION: Displays all queries using the object_ids in CURRENT_OBJ
-- USAGE: Execute
-- AUTHOR: Alvaro
-- ---------------------------------------------------------------

SELECT a.SAMPLE_TIME,a.SESSION_ID,a.SQL_ID,b.sql_text,a.EVENT,a.WAIT_CLASS,a.CURRENT_OBJ#,a.PROGRAM,a.MODULE,a.MACHINE 
FROM v$active_session_history a, dba_hist_sqltext b
where a.SQL_ID = b.SQL_ID
and CURRENT_OBJ# IN (85337,3200825)
order by sample_time desc;
