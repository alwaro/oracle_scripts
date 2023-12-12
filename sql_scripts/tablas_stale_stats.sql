-- ===============================================================
-- NAME: stale_stats.sql
-- DESCRIPTION: Displays a list of tables and partitions with stale stats.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col table_name for a32
col index_name for a32
set lines 200
@$DBA/format_time
spoo salida_stale_stats.log
prompt
prompt
prompt LISTANDO TABLAS CON STATE STATS
prompt =================================
select OWNER,TABLE_NAME,partition_name,LAST_ANALYZED,STALE_STATS from dba_tab_statistics where STALE_STATS='YES' AND owner not in ('SYS','SYSTEM','DBSNMP') order by 1;
prompt
prompt
spoo off;
