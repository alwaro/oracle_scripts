-- ===============================================================
-- NAME: sesiones_text.sql
-- DESCRIPTION: Displays info about the active sessions in a text.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 9999
set pagesize 999
set long 50000 
col inst format 9999
col username format a13
col prog format a20 trunc
col machine format a22 trunc
col osuser format a15 trunc
#col sql_text format a22 trunc
col plan_hash_value format 99999999999
col sid format 9999
col execs format 9999999999
col serial# format 999999
col child for 99999
col avg_etime for 99,999.99
select a.inst_id inst, sid, serial#, username, b.sql_id, plan_hash_value, executions execs, 
(elapsed_time/decode(nvl(executions,0),0,1,executions))/1000000 avg_etime, 
sql_fulltext
from gv$session a, gv$sql b
where status = 'ACTIVE'
and username is not null
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and sql_text not like 'select a.inst_id inst, sid, serial#, username, b.sql_id, plan_hash_value, executions execs,%' -- don't show this query
order by sql_id, sql_child_number
/
