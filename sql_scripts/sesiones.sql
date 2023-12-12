-- ===============================================================
-- NAME: sesiones.sql
-- DESCRIPTION: Displays info about all sessions opened.
-- USAGE: Execute
-- AUTHOR: Pablo Bustamante
-- ---------------------------------------------------------------
set lines 400
set underline '='
set colsep '|'
set linesize 201
set recsepchar '-'
set recsep ea
col "User info" for a30
col "Current Query" for a30
col "Connect Info" for a30
col "SQL Info" for a27
col "Targeting" for a27
col "Blocked by" for a15
col "Session Info" for a33
spoo sesiones.log
select distinct --ident
	sid||','||serial#||',@'||sess.inst_id||chr(10)||'Schema: '||parsing_schema_name||chr(10)||'OS user: '||osuser||'' as  "User info",
	'Since: '||logonSince||chr(10)||'Module: '||substr(sess.module,1,20)||chr(10)||'Program: '||substr(sess.program,1,20)||'' as "Connect Info",
	'SQL_ID: '||sess.sql_id||chr(10)||'Exec Plan: '||plan_hash_value||chr(10)||'Prev SQL: '||prev_sql_id||'' as "SQL Info",
	substr(sql_text,1,90) as "Current Query",
	decode(object_type,
			'',''||chr(10)||'  Not targeting...'||chr(10)||'',
			'TABLE',''||owner||'.'||substr(object_name,1,20)||chr(10)||'('||object_type||')'||chr(10)||'Stale: '||stale_stats||' since '||lastStats,
			''||owner||'.'||substr(object_name,1,20)||chr(10)||'('||object_type||')'||'') as "Targeting",
	decode(blocking_session_status,
			'VALID',''||final_blocking_session||',@'||final_blocking_instance||chr(10)||'for '||waitSecs||' secs',
			'NO HOLDER',chr(10)||'  Not blocked'||chr(10),
			'NOT IN WAIT',chr(10)||'  Not waiting'||chr(10),
			chr(10)||'  Running...'||chr(10)) as "Blocked by",
	'Session is: '||sess.status||' with event: '||chr(10)||sess.event as "Session Info"
from 
	(select 
		sid,serial#,inst_id,
		sql_id,prev_sql_id,
		osuser,terminal,program,module,
		se.owner,se.object_name,se.object_type,
		blocking_session_status,final_blocking_session,final_blocking_instance,
		waitSecs,
		logonSince,
		se.status,event,
		stale_stats,lastStats
	from
		(select 
			sid,serial#,inst_id,
			sql_id,prev_sql_id,
			owner,object_name,object_type,osuser,program,module,terminal,
			blocking_session_status,final_blocking_session,final_blocking_instance,round(wait_time_micro/1000000) waitSecs,
			to_char(logon_time,'DD-MON-YY HH24:MI:SS') logonSince,
			s.status,event,s.type
		from gv$session s left join dba_objects obj on s.row_wait_obj# = obj.object_id) se
			left join (select owner,table_name,stale_stats,trunc(last_analyzed) lastStats from dba_tab_statistics) st on se.object_name = st.table_name and se.owner = st.owner
		where
			se.status = 'ACTIVE' and
			se.type != 'BACKGROUND'
		order by sid desc) sess,
	gv$sql sq 
where 
	sess.sql_id = sq.sql_id (+)
	and sess.inst_id = sq.inst_id (+)
	and sql_text not like 'select distinct --ident%'
order by "User info" desc
/
spoo off
set recsep off
set colsep ' '
