-- ===============================================================
-- NAME: estadisticas_24h.sql
-- DESCRIPTION: Shows tables with statistics gatherted in last 24h
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
select owner, table_name,LAST_ANALYZED,STATTYPE_LOCKED,STALE_STATS from dba_tab_statistics where LAST_ANALYZED > sysdate-1 order by LAST_ANALYZED asc;

