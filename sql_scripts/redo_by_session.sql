-- ===============================================================
-- NAME: redo_by_session.sql
-- DESCRIPTION: Displays the redo size by sessions.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT
s.sid,
s.username,
s.program,
ROUND(t.VALUE/(1024*1024)) AS "Redo Size MB",
sa.sql_text
FROM V$SESSION s, V$SESSTAT t, V$STATNAME sn, V$SQLAREA sa
WHERE s.sid = t.sid
AND t.statistic# = sn.statistic#
AND sn.name = 'redo size'
AND sa.sql_id = s.sql_id
AND ROUND(t.VALUE/(1024*1024)) != 0
ORDER BY t.VALUE DESC;

