-- ===============================================================
-- NAME: esperas_snapshot_sqlid_sdi.sql
-- DESCRIPTION: Shows wait events from snapshot
-- USAGE: Specify SQLID, SID and SERIAL
-- AUTHOR:
-- ---------------------------------------------------------------
set verify off;
spoo esperas_desde_snapshot_sqlid_&&INTRODUZCA_SQLID._sid_&&INTRODUCE_SID.-&&INTRODUCE_SERIAL..log
SELECT a.sql_exec_id, NVL(a.event, 'ON CPU') AS event,
       COUNT(*)*10 AS total_wait_time, b.object_name, a.SQL_PLAN_LINE_ID
FROM   dba_hist_active_sess_history a, dba_objects b
WHERE  a.sample_time > SYSDATE - 1 
AND a.CURRENT_OBJ#=b.object_id
AND a.SQL_ID='&&INTRODUZCA_SQLID'
AND a.SESSION_ID=&&INTRODUCE_SID and a.session_serial#=&&INTRODUCE_SERIAL
--AND a.INSTANCE_NUMBER=2
GROUP BY a.sql_exec_id,a.event, b.object_name, a.SQL_PLAN_LINE_ID
ORDER BY a.sql_exec_id,total_wait_time DESC;
undef INTRODUZCA_SQLID
undef INTRODUCE_SID
undef INTRODUCE_SERIAL
set verify on;
spool off;
