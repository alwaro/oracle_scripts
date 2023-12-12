-- ===============================================================
-- NAME: sesiones_inactivas_info_extra.sql
-- DESCRIPTION: Displays info about the inactive sessions.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col USERNAME format a35
col MACHINE  format a35
col OSUSER   format a35
col ID format a15
col status format a12
spoo sesiones-actividad.log
select inst_id, username
,      sid || ',' || serial# "ID"
,      status
,      machine
,      osuser
,      last_call_et "Last Activity"
from   gv$session
where  username is not null
order by status desc
,        last_call_et desc
/
spoo off;
