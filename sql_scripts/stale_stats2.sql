-- ===============================================================
-- NAME: stale_stats2.sql
-- DESCRIPTION: Displays a list of tables and indexes with stale stats.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col IS_PARTITION format a14
col NAME for a30
col m.TABLE_OWNER format a14
col INSERTS for 9999999
col UPDATES FOR 99999999
Select m.TABLE_OWNER,
 'NO' as IS_PARTITION,
 m.TABLE_NAME as NAME, 
 m.INSERTS,
 m.UPDATES,
 m.DELETES,
 m.TRUNCATED,
 m.TIMESTAMP as LAST_MODIFIED, 
 round((m.inserts+m.updates+m.deletes)*100/NULLIF(t.num_rows,0),2) as EST_PCT_MODIFIED,
 t.num_rows as last_known_rows_number,
 t.last_analyzed
From dba_tab_modifications m,
 dba_tables t 
where m.table_owner=t.owner
and m.table_name=t.table_name
and m.table_owner not in ('SYS','SYSTEM')
and ((m.inserts+m.updates+m.deletes)*100/NULLIF(t.num_rows,0) > 10 or t.last_analyzed is null)
union
select m.TABLE_OWNER,
 'YES' as IS_PARTITION, 
 m.PARTITION_NAME as NAME, 
 m.INSERTS,
 m.UPDATES,
 m.DELETES,
 m.TRUNCATED,
 m.TIMESTAMP as LAST_MODIFIED, 
 round((m.inserts+m.updates+m.deletes)*100/NULLIF(p.num_rows,0),2) as EST_PCT_MODIFIED,
 p.num_rows as last_known_rows_number,
 p.last_analyzed 
From dba_tab_modifications m, 
 dba_tab_partitions p
where m.table_owner=p.table_owner
and m.table_name=p.table_name
and m.PARTITION_NAME = p.PARTITION_NAME
and m.table_owner not in ('SYS','SYSTEM')
and ((m.inserts+m.updates+m.deletes)*100/NULLIF(p.num_rows,0) > 10 or p.last_analyzed is null)
order by 8 desc;
