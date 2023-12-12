-- ===============================================================
-- NAME: sesiones_con_sqlid.sql
-- DESCRIPTION: Displays the info of the active sessions and their SQL_ID.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select a.inst_id inst, sid, serial#, substr(program,1,19) prog, a.action, machine, username, osuser, b.sql_id, plan_hash_value,
sql_text
from gv$session a, gv$sql b
where status = 'ACTIVE'
and username is not null
and a.sql_id = b.sql_id
and a.sql_child_number = b.child_number
and a.inst_id = b.inst_id
and a.sql_id = '9y7pp3u272s2f';

