-- ===============================================================
-- NAME: bloqueosv2
-- DESCRIPTION: 
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
set head off
set echo off

select  'SID ' || l1.sid ||' is blocking  ' || l2.sid blocking
from    gv$lock l1, gv$lock l2
where   l1.block =1 and l2.request > 0
and     l1.id1=l2.id1
and     l1.id2=l2.id2
/

select '---------------------------------------------------------' from dual;

select 'LA INFORMACION DE LA SESSION BLOQUEANTE ES LA SIGUIENTE:' from dual;

select a.inst_id, sid, serial#, substr(program,1,19) prog, machine, username, osuser, b.sql_id, plan_hash_value,
sql_text
from gv$session a, gv$sql b
where sid= (
select  'SID ' || l1.sid ||' is blocking  ' || l2.sid blocking
from    gv$lock l1, gv$lock l2
where   l1.block =1 and l2.request > 0
and     l1.id1=l2.id1
and     l1.id2=l2.id2
)
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
order by sql_id, sql_child_number
/

select '---------------------------------------------------------' from dual;

