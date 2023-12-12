-- ===============================================================
-- NAME: dpjobs.sql
-- DESCRIPTION: Displays datapump jobs.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
spo dpjobs.log
SET lines 200
set pages 200
COL owner_name FORMAT a10;
COL job_name FORMAT a20
COL state FORMAT a12
COL operation LIKE state
COL job_mode LIKE state

-- locate Data Pump jobs:

SELECT owner_name, job_name, operation, job_mode,
state, attached_sessions
FROM dba_datapump_jobs
WHERE job_name NOT LIKE 'BIN$%'
ORDER BY 1,2; 
spo off
