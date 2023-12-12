-- ===============================================================
-- NAME: tablas_particionadas.sql
-- DESCRIPTION: Displays a list of the partitioned tables.
-- USAGE: Execute
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
SELECT DISTINCT TABLE_NAME FROM DBA_TAB_PARTITIONS WHERE TABLE_NAME NOT LIKE '%$%' and table_name not like 'LOGMN%' GROUP BY TABLE_NAME order by table_name;
