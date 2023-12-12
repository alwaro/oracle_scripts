-- ===============================================================
-- NAME: fragmentacion_tabla.sql
-- DESCRIPTION: Displays most fragmented tables in db
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col owner format a10
col table_name format a30
col 'Fragmented size' format a15
col 'Actual size' format a15
col 'reclaimable space' format a20
col 'reclaimable space %' format a5

set feedback off
SET VERIFY OFF

spool fragmentacion&&Nombre_del_propiertario..&&Nombre_de_tabla..log

select owner,
table_name,
round((blocks * 8), 2) || 'kb' "Fragmented size",
round((num_rows * avg_row_len / 1024), 2) || 'kb' "Actual size",
round((blocks * 8), 2) - round((num_rows * avg_row_len / 1024), 2) || 'kb' "reclaimable space",
((round((blocks * 8), 2) - round((num_rows * avg_row_len / 1024), 2)) /
to_char(round((blocks * 8), 2)) * 100 - 10) "reclaimable space % "
from dba_tables
where table_name=upper('&&Nombre_de_tabla') 
AND OWNER =upper('&&Nombre_del_propiertario') ;

spoo off;
set verify on
set feedback on
undef Nombre_de_tabla
undef Nombre_del_propiertario

