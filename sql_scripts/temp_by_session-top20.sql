set lines 300
col "sid_serial@inst" for a15
col "temp_size" for 9999
col "username" for a15
select * 
	from 
	(select 
		a.sid||','||a.serial#||'@'||a.inst_id as "sid_serial@inst",  
		round(((b.blocks*p.value)/1024/1024),2)||'m' as "temp_size",  
		nvl(a.username, '(oracle)') as "username",
		a.sql_id,a.program,a.status  
	from gv$session a, gv$sort_usage b, gv$parameter p  
	where p.name = 'db_block_size' 
		and a.saddr = b.session_addr  
		and a.inst_id=b.inst_id 
		and a.inst_id=p.inst_id
		and a.sql_id is not null
	order by "temp_size" desc)
where rownum < 20;

