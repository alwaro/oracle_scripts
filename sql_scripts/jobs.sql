-- ===============================================================
-- NAME: jobs.sql
-- DESCRIPTION: Gets jobs from an specific owner
-- USAGE: Execute (Variable for custom owner)
-- AUTHOR:
-- ---------------------------------------------------------------
 SELECT JOB_NAME,
 (3600*extract(hour from elapsed_time)+60*extract(minute from elapsed_time)+extract(second from elapsed_time)) segundos, null "STATE", null "OWNER", session_id "SID"
FROM DBA_SCHEDULER_RUNNING_JOBS WHERE OWNER = 'TRAFICO' and extract(second from elapsed_time) >=1
union
 select job_name, 0, state, owner, null "SID" from dba_scheduler_jobs
where  job_name not in(SELECT JOB_NAME from dba_scheduler_running_jobs)
/
