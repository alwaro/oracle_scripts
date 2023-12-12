-- ===============================================================
-- NAME: redo_by_session2.sql
-- DESCRIPTION: Generates queerys to display the redo size by sessions.
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
col value format a30
col module format a45
spoo redo_by_session_big.log
prompt 
prompt ====================================================================================
prompt ............... SESIONES CON MAS DE 200MB DE REDO GENERADO..........................
PROMPT ====================================================================================
select ss.sid, ss.value/1024/1024 as Redo_size_Mb, s.program, s.module
from  v$statname sn,v$sesstat ss,v$session s
where ss.statistic#=sn.statistic# 
and sn.name='redo size' 
and s.sid=ss.sid 
and ss.value/1024/1024 > 200
order by ss.value DESC;
PROMPT 
PROMPT
PROMPT ====================================================================================
prompt .................... DATOS DE LAS SESIONES (NO ORACLE) .............................
PROMPT ====================================================================================
PROMPT
set pagesize 999
set lines 350
col instance for 99999
col sid for 999999
col username for a20
col osuser for a20
col machine for a40
col program for a40
col Redo_size_Mb for 99999999
select distinct s.inst_id as instance, ss.sid, s.username, s.osuser, s.machine, s.program, ss.value/1024/1024 as Redo_size_Mb
from gv$statname sn, gv$sesstat ss,gv$session s, gv$sql sq
where
    ss.statistic#=sn.statistic# and s.sid=ss.sid and s.sql_id=sq.sql_id
    and sn.name='redo size'
    and ss.value/1024/1024 > 200
    and (program like '%JDBC%' or program like '%tibco%')
order by Redo_size_Mb desc;
PROMPT
spoo off

