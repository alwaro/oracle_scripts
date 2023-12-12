-- ===============================================================
-- NAME: v10_full.sql
-- DESCRIPTION: Displays a detailed list of information from the job V10 and then a list of all the dba_jobs that are running.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

col SCHEMA_USER for a25
prompt
prompt ESTADO DEL JOB V10
prompt ===================================================================================================
-- select job,failures,last_date,last_sec, next_date, next_sec,schema_user from dba_jobs WHERE JOB=501;
Select job, broken from dba_jobs where WHAT like '%v10%';
prompt
select job,failures,last_date,last_sec, next_date, next_sec,schema_user from dba_jobs WHERE WHAT like '%v10%';
prompt
prompt
prompt LISTA DE JOBS EN EJECUCION (DBA_JOBS)
prompt ===================================================================================================
SELECT * from dba_jobs_RUNNING;
prompt 
prompt 


