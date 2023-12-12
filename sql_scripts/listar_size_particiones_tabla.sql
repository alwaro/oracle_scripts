-- ===============================================================
-- NAME: listar_size_particiones_tabla.sql
-- DESCRIPTION: Display partition size from an specific table
-- USAGE: Ask table_name and owner
-- AUTHOR: 
-- ---------------------------------------------------------------
spoo size_particiones_&&NOMBRE_OWNER._&&NOMBRE_TABLA..log
select PARTITION_NAME,sum(bytes)/1024/1024 AS MB from dba_segments where SEGMENT_NAME='&&NOMBRE_TABLA' AND OWNER='&&NOMBRE_OWNER' and PARTITION_NAME IN (SELECT PARTITION_NAME FROM DBA_TAB_PARTITIONS WHERE TABLE_OWNER='&&NOMBRE_OWNER' AND TABLE_NAME='&&NOMBRE_TABLA') GROUP BY PARTITION_NAME, BYTES ORDER BY PARTITION_NAME;
spoo off
undef NOMBRE_OWNER
undef NOMBRE_TABLA

