-- ===============================================================
-- NAME: redo.sql
-- DESCRIPTION: Displays the standby redo logs.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set linesize 600
column REDOLOG_FILE_NAME format a60
SELECT
    a.GROUP#,
    a.THREAD#,
    a.SEQUENCE#,
    a.ARCHIVED,
    a.STATUS,
    b.MEMBER    AS REDOLOG_FILE_NAME,
    (a.BYTES/1024/1024) AS SIZE_MB
FROM v$log a
JOIN v$logfile b ON a.Group#=b.Group# 
ORDER BY a.GROUP# ASC;
prompt
prompt =====================================================================================
prompt ...............................STANDBY REDO LOGS.....................................
PROMPT =====================================================================================
prompt
select GROUP#,DBID,THREAD#,BYTES/1024/1024 as SIZE_MB,USED,STATUS,LAST_TIME from  v$standby_log;

