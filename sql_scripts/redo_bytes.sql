-- ===============================================================
-- NAME: redo_bytes.sql
-- DESCRIPTION: Displays the standby redo logs.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set linesize 600
column MEMBER format a60
SELECT
    a.GROUP#,
    a.THREAD#,
    a.SEQUENCE#,
    a.ARCHIVED,
    a.STATUS,
    b.MEMBER,
    a.BYTES
FROM v$log a
JOIN v$logfile b ON a.Group#=b.Group# 
ORDER BY a.GROUP# ASC;
prompt
prompt =====================================================================================
prompt ...............................STANDBY REDO LOGS.....................................
PROMPT =====================================================================================
prompt
select GROUP#,DBID,THREAD#,BYTES,USED,STATUS,LAST_TIME from  v$standby_log;

