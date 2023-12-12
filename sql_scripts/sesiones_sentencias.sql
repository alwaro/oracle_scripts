-- ===============================================================
-- NAME: sesiones_sentencias.sql
-- DESCRIPTION: Displays a sentence to get the info about the active sessions.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set pagesize 999
set lines 200
col username format a10
col prog format a20 trunc
col sql_text format a120 trunc
col sid format 9999
col serial# format 99999
col program format a30
col inst for 9
spoo sesiones_sentencias.log
select a.inst_id inst, sid, serial#, substr(program,1,19) prog,b.sql_id,sql_text
from gv$session a, gv$sql b
where status = 'ACTIVE'
and username is not null
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.inst_id = b.inst_id
and sql_text not like 'select a.inst_id inst, sid, serial#, substr(program,1,19) prog,b.sql_id,sql_text%' -- don't show this query
order by sql_id, sql_child_number
/
spoo off;
