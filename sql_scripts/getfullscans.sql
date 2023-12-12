-- ===============================================================
-- NAME: getfullscans.sql
-- DESCRIPTION: Displays info when fullscans is happening in a table
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT SQL_ID,SQL_TEXT, executions,service,module
FROM V$SQL
WHERE SQL_ID in (
SELECT SQL_ID
FROM V$SQL_PLAN
WHERE OPTIONS like '%FULL%' AND OPERATION like '%TABLE%'
)
and service not like '%SYS%' and module not like '%EM Realtime Connection%' and module not like '%OMS%'
/
