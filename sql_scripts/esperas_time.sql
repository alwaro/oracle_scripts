-- ===============================================================
-- NAME: esperas_time.sql
-- DESCRIPTION: Shows wait events
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
COL EVENT FOR A57
PROMPT DATOS DE LA VISTA V$SYSTEM_EVENT
PROMPT ==========================================================================================================================
select EVENT,TOTAL_WAITS,TOTAL_TIMEOUTS,TIME_WAITEd, AVERAGE_WAIT from v$system_event where event like '%wait%' ORDER BY 4 DESC;
PROMPT
PROMPT
PROMPT DATOS DE LA VISTA V$WAITSTAT
PROMPT ==========================================================================================================================
select * from v$waitstat order by 3 desc;
PROMPT

