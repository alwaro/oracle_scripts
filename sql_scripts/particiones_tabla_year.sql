-- ===============================================================
-- NAME: particiones_tabla_year.sql
-- DESCRIPTION: Displays the partitions on the specified table and between 2 years.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set long 5000
set lines 160
set pages 999
col partition_name format a18
col table_owner format a10
col tablespace_name format a13
col high_value format a90
col TABLE_NAME format a24
select partition_name, HIGH_VALUE, table_owner, table_name, TABLESPACE_NAME from dba_tab_partitions where table_name = '&nombre_tabla' and (partition_name LIKE '%21%' OR partition_name LIKE '%22%' OR partition_name LIKE '%DUMMY%') order by 3,1;
undef nombre_tabla
