-- ===============================================================
-- NAME: sesiones2_fullsql.sql
-- DESCRIPTION: Generates the sentence to display the info of the active sessions from dual.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set pagesize 999
set lines 350
set long 99999
col username format a10
col SID_SERIAL format a12
col prog format a25 trunc
col machine format a22 trunc
col osuser format a15 trunc
col sql_text format a500
col plan_hash_value format 99999999999
col sid format 9999
col execs format 9999999999
col serial# format 99999
col child for 99999
col avg_etime for 99,999.99
col program format a30
col action format a20
col inst for 9
col event format a26 trunc
spoo sesiones2_fullsql.log
set head off
select 'MOSTRAMOS SESIONES ACTIVAS DE APLICACION/USUARIOS' from dual;
set head on

select a.inst_id inst,
-- sid, serial#,
TO_CHAR(a.sid)||','||TO_CHAR(a.serial#) SID_SERIAL,
substr(program,1,19) prog, machine, username, osuser, b.sql_id, b.plan_hash_value, a.event,b.sql_text
from gv$session a, gv$sql b
where  username is not null
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.inst_id = b.inst_id
and sql_text not like 'select a.inst_id inst, sid, serial#, substr(program,1,19) prog, a.action, machine, username, osuser, b.sql_id, plan_hash_value,%' -- don't show this query
order by sql_id, sql_child_number
/

spoo off;

