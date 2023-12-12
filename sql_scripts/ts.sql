set lines 300
col "Total Mb" for 999999999
col "Free Mb" for 999999999
col "Used MB" for 999999999
col "Total Autoextend Mb" for a20
col "Occupation Graph" for a26
col "Autoextend Occupation Graph" for a26
col status for a15
col contents for a15
select 
	a.tablespace_name as "Tablespace name",
	round(bytes_alloc/1024/1024) as "Total Mb",
	round(nvl(b.bytes_free, 0)/1024/1024) as "Free Mb",
	round((bytes_alloc-nvl(b.bytes_free,0))/1024/1024) as "Used MB",
	rpad('|'||rpad('#',round((bytes_alloc-nvl(b.bytes_free,0))/bytes_alloc*20,0),'#'),20,'-')||'| '||round((bytes_alloc-nvl(b.bytes_free,0))/bytes_alloc*100,0)||'%' as "Occupation Graph",
	decode(round(maxbytes/1024/1024),33554432,'Unlimited',round(maxbytes/1024/1024)) as "Total Autoextend Mb",
	rpad('|'||rpad('#',round((bytes_alloc-nvl(b.bytes_free,0))/maxbytes*20,0),'#'),20,'-')||'| '||round((bytes_alloc-nvl(b.bytes_free,0))/maxbytes*100,0)||'%' as "Autoextend Occupation Graph",
	c.status, c.contents
from 
		(select 
			f.tablespace_name,
			sum(f.bytes) bytes_alloc,
			sum(decode(f.autoextensible,'YES',f.maxbytes,'NO',f.bytes)) maxbytes
		from dba_data_files f
        group by tablespace_name) a,
		(select f.tablespace_name,
			sum(f.bytes) bytes_free
		from dba_free_space f
        group by tablespace_name) b,
	dba_tablespaces c
where a.tablespace_name = b.tablespace_name (+)
and a.tablespace_name = c.tablespace_name
union all 
select 
	tf.tablespace_name as "Tablespace name",
	Mb_alloc as "Total Mb",
	Mb_free as "Free Mb",
	Mb_alloc-Mb_free as "Used MB",	
	rpad('|'||rpad('#',round(((Mb_alloc-Mb_free)/Mb_alloc)*20,0),'#'),20,'-')||'| '||round(((Mb_alloc-Mb_free)/Mb_alloc)*100,0)||'%' as "Occupation Graph",
	decode(totalMb,33554432,'Unlimited',totalMb) as "Total Autoextend Mb",
	rpad('|'||rpad('#',round(((Mb_alloc-Mb_free)/totalMb)*20,0),'#'),20,'-')||'| '||round(((Mb_alloc-Mb_free)/totalMb)*100,0)||'%' as "Autoextend Occupation Graph",
	tbs.status, tbs.contents
from 
	(select 
		tablespace_name,
		round(sum(bytes)/1024/1024) Mb_alloc,
		round(sum(decode(autoextensible,'YES',maxbytes,'NO',bytes))/1024/1024) totalMb
	from dba_temp_files 
    group by tablespace_name) tf,
	(select tablespace_name,
		round(sum(free_space)/1024/1024) Mb_free
	from dba_temp_free_space
	group by tablespace_name) tfs,
	dba_tablespaces tbs
where 
	tfs.tablespace_name = tf.tablespace_name (+)
	and tf.tablespace_name = tbs.tablespace_name
--group by tf.tablespace_name
order by 1
/

