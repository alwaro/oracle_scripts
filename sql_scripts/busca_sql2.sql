-- ===============================================================
-- NAME: busca_sql2.sql
-- DESCRIPTION: Gets info about session specified in query
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
WITH TOTALES AS (
select 
sum(TM_DELTA_DB_TIME)/1000000 as DB_TIME_SECONDS,
sum(TM_DELTA_TIME)/1000000 as TIME_SECONDS,
--extract(HOUR FROM (max(sample_time)-min(sample_time))) AS ELAPSED_HOURS,
--extract(MINUTE FROM (max(sample_time)-min(sample_time))) AS  ELAPSED_MINUTES,
--extract(second from (max(sample_time)-min(sample_time))) AS ELAPSED_SEC, 
sql_id, 
SQL_EXEC_ID,
session_id,
session_serial#,
SQL_PLAN_HASH_VALUE 
from dba_hist_active_sess_history 
where --SQL_EXEC_START > to_date('2022-02-24 10:55:00','YYYY-MM-DD HH24:MI:SS') and
       sample_time between to_date('2022-10-20 19:00:00','YYYY-MM-DD HH24:MI:SS') and to_date('2022-10-31 18:00:00','YYYY-MM-DD HH24:MI:SS')
     and user_id in( 
           select user_id from dba_users where oracle_maintained = 'N')  and sql_id in ('adpd9unxpkc5w')
     and SQL_PLAN_HASH_VALUE > 0 and sql_exec_id is not null
group by sql_id, SQL_EXEC_ID, session_id, session_serial#, SQL_PLAN_HASH_VALUE)
SELECT 
a.TIME_SECONDS,
a.DB_TIME_SECONDS,
--ELAPSED_HOURS*60*60+ ELAPSED_MINUTES*60+ELAPSED_SEC AS TOTAL_ELAPSED,
a.sql_id, 
b.sql_text,
a.session_id,
a.session_serial#,
a.SQL_EXEC_ID, 
a.SQL_PLAN_HASH_VALUE 
from TOTALES a
join dba_hist_sqltext b on a.sql_id = b.sql_id 
where a.sql_id is not null and a.SQL_PLAN_HASH_VALUE > 0
ORDER BY a.db_TIME_SECONDS desc
FETCH NEXT 10 ROWS ONLY
;

