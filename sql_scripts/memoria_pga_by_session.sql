-- ===============================================================
-- NAME: memoria_pga_by_session.sql
-- DESCRIPTION: Displays the memory usage of the PGA by sessions.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
col sid format 9999999
col name format a25
col memory format 999999
col username format a20
col COMMAND for 999999
col OSUSER for a20
col MACHINE for a20
col TERMINAL for a20
col PROGRAM for a35
col STATISTIC# for 99999
spoo memory_pga_by_session.log
select 
ssst.sid, 
stn.name , 
round(ssst.value/1024/1024,2) memory , 
USERNAME, 
COMMAND, 
OSUSER, 
MACHINE, 
TERMINAL, 
PROGRAM , 
ssst.STATISTIC# 
from v$statname stn,v$sesstat ssst , v$session ses 
where stn.STATISTIC# = ssst.STATISTIC# and 
ssst.sid = ses.sid and 
name like 'session%pga%memory%' 
order by 3 asc ; 
spoo off;

