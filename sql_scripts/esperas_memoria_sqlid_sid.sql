-- ===============================================================
-- NAME: esperas_memoria_sqlid_sidtime.sql
-- DESCRIPTION: Shows wait events from memory
-- USAGE: Specify SQLID_SID and SERIALs
-- AUTHOR:
-- ---------------------------------------------------------------
SET VERIFY OFF;
SPOO esperas_en_memoria_sqlid_&&INTRODUCE_SQLID._SID_&&INTRODUCE_SID.-&&INTRODUCE_SERIAL..log
SELECT a.sql_exec_id,NVL(a.event, 'ON CPU') AS event,
       COUNT(*) AS total_wait_time,b.object_name
FROM   gv$active_session_history a, dba_objects b
WHERE  a.sample_time > SYSDATE - 30/(24*60) -- 30 mins
AND a.CURRENT_OBJ#=b.object_id
AND a.SQL_ID='&&INTRODUCE_SQLID'
AND a.SESSION_ID=&&INTRODUCE_SID and a.session_serial#=&&INTRODUCE_SERIAL
-- AND a.INST_ID=2
GROUP BY a.sql_exec_id,a.event, b.object_name, a.SQL_PLAN_LINE_ID
ORDER BY a.sql_exec_id,total_wait_time DESC;
undef INTRODUCE_SQLID
undef INTRODUCE_SID
undef INTRODUCE_SERIAL
SET VERIFY ON;
SPOO OFF

