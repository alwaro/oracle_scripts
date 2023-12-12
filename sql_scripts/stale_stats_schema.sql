-- ===============================================================
-- NAME: stale_stats.sql
-- DESCRIPTION: Displays a list of tables and indexes with stale stats.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
COL TABLE_NAME FOR A34
col index_name for a34
set lines 200
@$DBA/format_time
prompt
prompt
prompt LISTANDO TABLAS CON STATE STATS
prompt =================================
select OWNER,TABLE_NAME,LAST_ANALYZED,STALE_STATS from dba_tab_statistics where STALE_STATS='YES' AND OWNER='&&ESQUEMA' order by 1;
prompt
prompt
prompt LISTANDO INDICES CON STALE STATS
prompt =================================
select OWNER,INDEX_NAME,TABLE_OWNER,TABLE_NAME,LAST_ANALYZED,STALE_STATS from dba_ind_statistics where STALE_STATS='YES' AND OWNER='&&ESQUEMA' order by 1;
prompt
prompt
prompt
prompt
undef ESQUEMA
