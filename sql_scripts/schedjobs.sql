set lines 300
col "Job Info" for a30
col "Job Definition" for a50
col "Exec Info" for a35
set underline '_'
set colsep '|'
set recsepchar '='
set recsep ea
set linesize 125
prompt "De algun schema?"
def sjown='&1';
prompt "Algun nombre concreto?"
def sjname='&2':
select 
	'Job name: '||owner||'.'||job_name||chr(10)||'Status: '||decode(enabled,'TRUE','Enabled')||' -> '||state as "Job Info",
	'Type: '||job_type||chr(10)||'Def: '||substr(job_action,1,200) as "Job Definition",
	'Last Exec: '||to_char(last_start_date,'DD/MM/YYYY hh24:mi:ss')||chr(10)||'Lasts for: '||substr(replace(to_char(last_run_duration),'0000000',''),1,16)||chr(10)||'Next Exec: '||to_char(next_run_date,'DD/MM/YYYY hh24:mi:ss') as "Exec Info"
from dba_scheduler_jobs
where 
	owner like '%&&sjown%' and
	job_name like '%&&sjname%'
order by 1,2
/
undef sjown;
undef sjname;
