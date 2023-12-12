-- ===============================================================
-- NAME: sesiones_sid.sql
-- DESCRIPTION: Displays the SID info about the active sessions from users/app.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set pagesize 999
set lines 350
col username format a10
col SID_SERIAL format a12
col prog format a25 trunc
col machine format a22 trunc
col osuser format a15 trunc
col sql_text format a50 trunc
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
spoo sesiones2.log
set head off
select 'MOSTRAMOS SESIONES ACTIVAS DE APLICACION/USUARIOS' from dual;
set head on

select a.inst_id inst,
-- sid, serial#,
TO_CHAR(a.sid)||','||TO_CHAR(a.serial#) SID_SERIAL,
substr(program,1,19) prog, machine, username, osuser, b.sql_id, b.plan_hash_value, a.event,b.sql_text
from gv$session a, gv$sql b
where  sid in (696,267,1388,1455)
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.inst_id = b.inst_id
order by sql_id, sql_child_number
/
