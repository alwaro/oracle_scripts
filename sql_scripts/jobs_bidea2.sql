set lines 160
set pages 999
select  distinct job_name, enabled from dba_scheduler_jobs where owner='TRAFICO';

