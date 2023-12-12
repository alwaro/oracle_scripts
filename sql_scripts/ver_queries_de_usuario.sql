-- ===============================================================
-- NAME: ver_queries_de_usuario.sql
-- DESCRIPTION: Displays the queries from the specified user
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set pagesize 999
set lines 350
col SID_SERIAL format a12
col sql_text format a300
SET LONG 300
select a.inst_id inst,
TO_CHAR(a.sid)||','||TO_CHAR(a.serial#) SID_SERIAL,program, b.sql_text
from gv$session a, gv$sql b
where  username='&VER_QUERIES_DEL_USUARIO'
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.inst_id = b.inst_id
and sql_text not like 'select a.inst_id inst, sid, serial#, substr(program,1,19) prog, a.action, machine, username, osuser, b.sql_id, plan_hash_value,%' -- don't show this query
order by 1
/
