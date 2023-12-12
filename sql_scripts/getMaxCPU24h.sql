select inst_n as "Instance Name",(((max(DBtime)/48)*100)/60) as "CPU Usage" from 
	(select begin_snap, end_snap, 
	inst,inst_n, a/1000000/60 DBtime from
		(select
			e.snap_id end_snap,
			lag(e.snap_id) over (order by e.instance_number,e.snap_id) begin_snap,
			lag(s.end_interval_time) over (order by e.instance_number,e.snap_id) timestamp,
			s.instance_number inst,g.instance_name inst_n,
			e.value,
			nvl(value-lag(value) over (order by e.instance_number,e.snap_id),0) a
		from dba_hist_sys_time_model e, DBA_HIST_SNAPSHOT s, gv$instance g
		where s.snap_id = e.snap_id
			and s.instance_number = g.instance_number
			and e.instance_number = s.instance_number
			and stat_name= 'DB time')
	where begin_snap=end_snap-1
		and timestamp > SYSDATE-1
	order by dbtime desc)
where rownum < 31
group by inst_n
/
