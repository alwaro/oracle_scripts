-- ===============================================================
-- NAME: bloqueos_2.sql
-- DESCRIPTION:
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 150
spoo bloqueos.log
select (select username
from v$session
where sid = v$lock.sid) username,
sid,
id1,
id2,
lmode,
request, block, v$lock.type
from v$lock
where sid = sys_context('userenv','sid');
spoo off

