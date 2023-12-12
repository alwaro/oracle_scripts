-- ===============================================================
-- NAME: info_job_ejecutado.sql
-- DESCRIPTION: Displays info from a job execution
-- USAGE: Ask for a job
-- AUTHOR:
-- ---------------------------------------------------------------
col LOG_DATE for a35
col ACTUAL_START_DATE for a25
col ACTUAL_START_DATE for a45
col STATUS for a11
COL OWNER FOR A8
COL JOB_NAME FOR A44
select LOG_DATE,OWNER,JOB_NAME,STATUS,ACTUAL_START_DATE,RUN_DURATION, errors from ALL_SCHEDULER_JOB_RUN_DETAILS where log_date > sysdate-10 and job_name like '%&NOMBRE_JOB%';


