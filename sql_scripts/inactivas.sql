set lines 100 pages 999
col ID format a15
col status format a12
spoo sesiones-actividad.log
select username
,      sid || ',' || serial# "ID"
,      status
,      last_call_et "Last Activity"
from   gv$session
where  username is not null
order by status desc
,        last_call_et desc
/
spoo off;

