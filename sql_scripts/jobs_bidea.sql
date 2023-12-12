set pages 999
SELECT JOB_NAME,
(3600*extract(hour from elapsed_time)+60*extract(minute from elapsed_time)+extract(second from elapsed_time)) segundos
 FROM DBA_SCHEDULER_RUNNING_JOBS WHERE OWNER = 'TRAFICO' and extract(second from elapsed_time) >=1
union select job_name, 0 from dba_scheduler_jobs where owner='TRAFICO' and job_name not in(SELECT JOB_NAME from dba_scheduler_running_jobs);

