select 'alter system kill session '''||sid||','||serial#||',@'||inst_id||''' immediate;' as "Sentencias para matar"
from 
	(select sid,inst_id,serial#
	from gv$session) s,
	(select distinct final_blocking_session,final_blocking_instance
	from gv$session) b
where s.sid = b.final_blocking_session
	and s.inst_id = b.final_blocking_instance
order by 1;
