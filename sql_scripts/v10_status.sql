-- ===============================================================
-- NAME: v10_status.sql
-- DESCRIPTION: Displays the status of the job "v10"(501 numerical name)
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

select job,failures,last_date,last_sec, next_date, next_sec,schema_user from dba_jobs WHERE JOB=501;

