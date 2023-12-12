-- ===============================================================
-- NAME: wait_chains.sql
-- DESCRIPTION: Displays information about blocked sessions
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

select SID,BLOCKER_SID,WAIT_EVENT_TEXT,IN_WAIT,WAIT_EVENT_TEXT,TIME_REMAINING_SECS,NUM_WAITERS from v$wait_chains;

