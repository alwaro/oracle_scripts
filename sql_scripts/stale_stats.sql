-- ===============================================================
-- NAME: stale_stats.sql
-- DESCRIPTION: Displays a list of tables and indexes with stale stats.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
@$DBA/format_time
prompt
prompt
prompt LISTANDO TABLAS CON STATE STATS
prompt =================================
select OWNER,TABLE_NAME,LAST_ANALYZED,STALE_STATS from dba_tab_statistics where STALE_STATS='YES' AND owner not in ('SYS','SYSTEM','DBSNMP') order by 1;
prompt
prompt
prompt LISTANDO INDICES CON STALE STATS
prompt =================================
select OWNER,INDEX_NAME,TABLE_OWNER,TABLE_NAME,LAST_ANALYZED,STALE_STATS from dba_ind_statistics where STALE_STATS='YES' AND owner not in ('SYS','SYSTEM','DBSNMP')  order by 1;
prompt
prompt
prompt
prompt

