select a.tablespace_name tablespace,  
	d.temp_total_mb,  
	sum (a.used_blocks * d.block_size) / 1024 / 1024 temp_used_mb,  
	d.temp_total_mb - sum (a.used_blocks * d.block_size) / 1024 / 1024 temp_free_mb  
from 
	v$sort_segment a,  
	(select b.name, c.block_size, sum (c.bytes) / 1024 / 1024 temp_total_mb  
		from v$tablespace b, v$tempfile c  
		where b.ts#= c.ts#  
		group by b.name, c.block_size) d  
where a.tablespace_name = d.name  
group by a.tablespace_name, d.temp_total_mb;

