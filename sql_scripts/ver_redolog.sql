-- ===============================================================
-- NAME: ver_redolog.sql
-- DESCRIPTION: Displays log file information from the control files and contains information about redo log files.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set lines 250;
col status for a10;
col member for a70;
-- col NEXT_CHANGE# for 99999999999.99
select GROUP#,THREAD#,SEQUENCE#,BYTES,BLOCKSIZE,MEMBERS,ARCHIVED,STATUS,FIRST_CHANGE#,FIRST_TIME,NEXT_TIME from v$log order by THREAD#;
-- select * from v$log order by THREAD#;
select * from v$logfile;

