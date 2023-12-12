-- ===============================================================
-- NAME: lost_space_tables.sql
-- DESCRIPTION: Display reclaimable space in tables
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

-- +++ ===================== lost_space_tables =======================
-- ++    Este script muestra el espacio ocupado por cada tabla y
-- ++    el espacio  que esta desaprovechando porque necesita una 
-- ++    compactacion para liberar bloques no liberados tras deletes
-- ++    Todas las columnas de esta sentencia estan mostradas en Mb
-- ++ ===============================================================

set lines 200; 
column owner format a15; 
column segment_name format a30; 
spoo lost_space_tables.log
select 
a.owner, 
a.segment_name, 
a.segment_type, 
round(a.bytes/1024/1024,0) MBS, 
round((a.bytes-(b.num_rows*b.avg_row_len) )/1024/1024,0) WASTED 
from dba_segments a, dba_tables b 
where a.owner=b.owner 
and a.owner not like 'SYS%' 
and a.segment_name = b.table_name 
and a.segment_type='TABLE' 
group by a.owner, a.segment_name, a.segment_type, round(a.bytes/1024/1024,0) ,round((a.bytes-(b.num_rows*b.avg_row_len) )/1024/1024,0) 
having round(bytes/1024/1024,0) >100 
order by round(bytes/1024/1024,0) desc ;
spoo off;
