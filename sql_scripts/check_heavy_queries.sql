select distinct
        phv.parsing_schema_name Schema,module,cpu_total_secs,phv.sql_id,sql_text
	from
        (select distinct parsing_schema_name,sql_id,max(cpu_time_total/1000000) as cpu_total_secs
        from dba_hist_sqlstat hsq
        where snap_id in (
                select distinct snap_id
                from dba_hist_sqlstat
                order by 1 desc
                fetch first 24 rows only) --Number of snaps to take
	        --and parsing_schema_name in ('CENTRAL','GWR')
        group by parsing_schema_name,sql_id
        order by cpu_total_secs desc) phv,
        (select distinct sql_id,sql_text,module
        from gv$sql) sq
	where phv.sql_id=sq.sql_id
	order by cpu_total_secs desc;
