-- ===============================================================
-- NAME: sess.sql
-- DESCRIPTION: Displays info about the active sessions.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
 select inst_id, sid,type, program, username,event from gv$session where status='ACTIVE' and type!='BACKGROUND' and  sql_id is null
/
