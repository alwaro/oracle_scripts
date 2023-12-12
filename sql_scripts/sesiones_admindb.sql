-- ===============================================================
-- NAME: sesiones_admindb.sql
-- DESCRIPTION: Generates sentences to search for the info of the admin sesions.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set pagesize 999
set lines 200
col username format a10
col prog format a20 trunc
col machine format a22 trunc
col osuser format a15 trunc
col sql_text format a42 trunc
col plan_hash_value format 99999999999
col sid format 9999
col execs format 9999999999
col serial# format 99999
col child for 99999
col avg_etime for 99,999.99
col program format a30
col action format a20
col inst for 9
col event format a50
spoo sesiones.log

select a.inst_id inst, sid, serial#, substr(program,1,19) prog, a.action, machine, username, osuser, b.sql_id, plan_hash_value,
sql_text
from gv$session a, gv$sql b
where status = 'ACTIVE'
and username is not null
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.inst_id = b.inst_id
and sql_text not like 'select a.inst_id inst, sid, serial#, substr(program,1,19) prog, a.action, machine, username, osuser, b.sql_id, plan_hash_value,%' -- don't show this query
and osuser='admindb' -- para solo mostrarme a mi
order by sql_id, sql_child_number
/

