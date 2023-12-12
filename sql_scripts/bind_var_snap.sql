-- ===============================================================
-- NAME: bind_var_snap.sql
-- DESCRIPTION: Gets bind variables used in query in selected snapshot
-- USAGE: Needs SQLID and snapid
-- AUTHOR: Pablo Bustamante
-- ---------------------------------------------------------------
set verify off;
set lines 300
col snap for 9999999
col bind_variable for a20
col type for a20
col value for a20
spoo variables_&&sqlid._snap_&&snapid..log
select sql_id,name as bind_variable,datatype_string as type,value_string as value,b.snap_id as snap, TO_CHAR(BEGIN_INTERVAL_TIME, 'MM-DD-YYYY HH:MI:SS') as snapdate
from dba_hist_sqlbind b,dba_hist_snapshot s 
where 
	b.snap_id=s.snap_id 
	and sql_id='&&sqlid' 
	and b.snap_id='&&snapid'
order by b.snap_id;
undef sqlid
undef snap_date
