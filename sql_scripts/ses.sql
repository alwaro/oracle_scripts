-- ===============================================================
-- NAME: ses.sql
-- DESCRIPTION: Displays information about the active sessions
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set pagesize 999
set lines 200
col username format a13
col prog format a20 trunc
col machine format a22 trunc
col osuser format a15 trunc
col sql_text format a42 trunc
col plan_hash_value format 99999999999
col sid format 9999
col execs format 9999999999
col serial# format 999999
col child for 99999
col avg_etime for 99,999.99
select a.inst_id, sid, serial#, substr(program,1,19) prog, machine, username, osuser, b.sql_id, plan_hash_value, 
sql_text
from gv$session a, gv$sql b
where status = 'ACTIVE'
-- and username is not null
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
or a.sql_id is NULL
and sql_text not like 'select a.inst_id, sid, serial#, substr(program,1,19) prog, machine, username, osuser, b.sql_id, plan_hash_value,%' -- don't show this query
order by sql_id, sql_child_number
/
