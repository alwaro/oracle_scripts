-- ===============================================================
-- NAME: olap_use.sql
-- DESCRIPTION: Checks for the OLAP features installed.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
prompt *******************************************
prompt checking for OLAP features installed
prompt *******************************************

col c1 heading 'OLAP|Installed' format a20

select 
   decode(count(*), 0, 'No', 'Yes') c1
from 
   v$option
where 
   parameter = 'OLAP';

prompt *******************************************
prompt checking for OLAP features used
prompt *******************************************

col c1 heading 'OLAP|Used' format a20

select 
   decode(count(*), 0, 'No', 'Yes') c1
from 
   dba_feature_usage_statistics
where 
   name like '%OLAP%'
and 
   first_usage_date is not null;

select 
   name,
   first_usage_date,
   last_usage_date
from 
   dba_feature_usage_statistics
where 
   name like '%OLAP%'
and 
   first_usage_date is not null;


col comp_id   format a10
col comp_name format a30
col version   format a15
col status    format a10

select 
   comp_id, 
   comp_name, 
   version, 
   status 
from 
   dba_registry 
where 
   comp_name like '%OLAP%';
