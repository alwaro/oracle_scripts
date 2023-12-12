-- ===============================================================
-- NAME: bloqueos.sql
-- DESCRIPTION: Show locks, sessions locked and sessions locking
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
col event format a35
col wait_class format a11
col state format a18
col status format a10
col seconds format 999999
spo bloqueos.log

set head off
select 'EXISTEN LOS SIGUIENTES BLOQUEOS EN LA INSTANCIA:' from dual;


select 'USER1: SID='|| HOLDING_SESSION || ' bloquea al USER2: SID=' || waiting_session  AS blocking_status from dba_waiters;

set head off
select 'MOSTRAMOS SESIONES BLOQUEADAS' from dual;
set head on

select sid, serial#, substr(program,1,19) prog, machine, username, osuser, b.sql_id, status, state, wait_class, seconds_in_wait seconds, c.HOLDING_SESSION "BLOCKING_SESSION", event, sql_text
from v$session a, v$sql b, dba_waiters c
where a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.sid = c.waiting_session;

set head off
select 'MOSTRAMOS SESIONES BLOQUEANTES' from dual;
set head on


select sid,serial#, substr(program,1,19) prog, machine, username, osuser, b.sql_id, status, state, wait_class, seconds_in_wait seconds, event, sql_text
from v$session a, v$sql b, dba_waiters c
where a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.sid = c.HOLDING_SESSION;

spoo off;
