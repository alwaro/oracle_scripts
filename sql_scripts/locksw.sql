-- ===============================================================
-- NAME: locksw.sql
-- DESCRIPTION: Display wait events
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select BLOCKING_SESSION, EVENT, WAIT_CLASS, SECONDS_IN_WAIT, STATE from v$session where state='WAITING' and BLOCKING_SESSION_STATUS='VALID'
/
