-- ===============================================================
-- NAME: uso_historico_temp.sql
-- DESCRIPTION: Displays info about the temporal tablespace usage.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set line 300
col action for a40
spoo uso_historico_temp.log
SELECT /*+ PARALLEL(16) */ * FROM
(SELECT /*+ PARALLEL(16) */ SQL_ID, ACTION,MODULE,CONSUMER_GROUP_ID, to_char(trunc(SQL_EXEC_START,'HH')+(10*round(to_char(trunc(SQL_EXEC_START,'MI'),'MI')/10))/1440,'DD-mon-YYYY hh24:mi:ss') SQL_EXEC_START_5,
SUM(TEMP)/1024/1024/1024 AS TEMP
FROM
(
SELECT /*+ PARALLEL(32) */ distinct T1.DBID, T1.CON_ID, T1.SQL_EXEC_START, T1.consumer_group_id, T1.module, T1.action, T1.sql_id, T1.session_id, T1.session_serial#, T1.instance_number,
MAX(T1.TEMP_SPACE_ALLOCATED) over (partition by T1.SQL_EXEC_START,T1.sql_id, T1.module, T1.action, T1.session_id, T1.session_serial#, T1.instance_number) TEMP
FROM DBA_HIST_ACTIVE_SESS_HISTORY T1
WHERE T1.SAMPLE_TIME>TO_DATE('03/05/2023 11:05:01','DD/MM/RRRR HH24:MI:SS') and T1.SAMPLE_TIME<TO_DATE('03/05/2023 12:50:01','DD/MM/RRRR HH24:MI:SS')
AND T1.TEMP_SPACE_ALLOCATED IS NOT NULL
AND T1.SQL_EXEC_sTART IS NOT NULL
) T1
GROUP BY SQL_ID, ACTION,MODULE,CONSUMER_GROUP_ID, CON_ID, to_char(trunc(SQL_EXEC_START,'HH')+(10*round(to_char(trunc(SQL_EXEC_START,'MI'),'MI')/10))/1440,'DD-mon-YYYY hh24:mi:ss')--,
) T1
WHERE TEMP>5
ORDER BY TEMP DESC, SQL_EXEC_START_5 DESC;
spoo off

