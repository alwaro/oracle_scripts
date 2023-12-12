-- ===============================================================
-- NAME: redo_by_session2.sql
-- DESCRIPTION: Generates queerys to display the redo size by sessions.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
spoo redo_by_session2.log
set lines 200
col value format a30
col program format a50
col module format a70
select
ss.sid,
ss.value/1024/1024 as Redo_size_Mb,
s.program,
s.module
from 
v$statname 
sn,v$sesstat 
ss,v$session s
where 
ss.statistic#=sn.statistic# 
and
sn.name='redo size' 
and
s.sid=ss.sid 
and
ss.value>0
order by 
ss.value DESC;
spoo off;
