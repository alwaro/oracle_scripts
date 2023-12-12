-- ===============================================================
-- NAME: jobs_running.sql
-- DESCRIPTION: Displays running jobs
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 150
set pages 999
select session_id,JOB_NAME,OWNER from  dba_scheduler_running_jobs;

