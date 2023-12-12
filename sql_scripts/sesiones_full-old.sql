-- ===============================================================
-- NAME: sesiones_full.sql
-- DESCRIPTION: Creates a log with the sentence to display the info of the active sessions of users/app, golden gate, etc... from dual.
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
set head off
select 'MOSTRAMOS SESIONES ACTIVAS DE APLICACION/USUARIOS' from dual;
set head on

select a.inst_id inst, sid, serial#, substr(program,1,19) prog, a.action, machine, username, osuser, b.sql_id, plan_hash_value, 
sql_text
from gv$session a, gv$sql b
where status = 'ACTIVE'
and username is not null
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.inst_id = b.inst_id
and sql_text not like 'select a.inst_id inst, sid, serial#, substr(program,1,19) prog, a.action, machine, username, osuser, b.sql_id, plan_hash_value,%' -- don't show this query
order by sql_id, sql_child_number
/

set head off
select 'MOSTRAMOS SESIONES ACTIVAS DE OTROS TIPOS (GOLDENGATE, ESCLAVOS DE JOBS...)' from dual;
set head on

select inst_id inst, sid, serial#, program, username,event from gv$session where status='ACTIVE' and type!='BACKGROUND' and  sql_id is null;

spoo off;
