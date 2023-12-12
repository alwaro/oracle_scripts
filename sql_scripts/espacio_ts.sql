-- ===============================================================
-- NAME: espacio_ts.sql
-- DESCRIPTION: Displays tablespaces ocupation
-- USAGE: Specify tablespacename
-- AUTHOR:
-- ---------------------------------------------------------------
set pages 999 lines 100
col "Tablespace" for a50
col "Size MB" for 999999999
col "%Used" for 999
set verify off
prompt Introducir el nombre del Tablespace en MAYUSCULAS.
select tsu.tablespace_name "Tablespace"
, ceil(tsu.used_mb) "Size MB"
, 100 - floor(tsf.free_mb/tsu.used_mb*100) "%Used"
from (select tablespace_name, sum(bytes)/1024/1024 used_mb
from dba_data_files group by tablespace_name) tsu
, (select ts.tablespace_name
, nvl(sum(bytes)/1024/1024, 0) free_mb
from dba_tablespaces ts, dba_free_space fs
where ts.tablespace_name = fs.tablespace_name (+)
group by ts.tablespace_name) tsf
where tsu.tablespace_name = tsf.tablespace_name (+)
and tsf.tablespace_name='&NOMBRE_DEL_TABLESPACE'
order by 3
/
