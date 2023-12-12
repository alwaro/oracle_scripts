-- ===============================================================
-- NAME: informe_stadisticas_stale_exit.sql
-- DESCRIPTION: Display stale stats in db
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
select owner, table_name,LAST_ANALYZED,STATTYPE_LOCKED TIPO_BLOQUEO,STALE_STATS DESACTUALIZADAS from dba_tab_statistics where LAST_ANALYZED < sysdate-2 
and owner not in ('SYS','SYSTEM','DBSNMP','STDBYPERF','XDB','WMSYS','APPQOSSYS','PERFSTAT','EXFSYS','STRMADMIN','OUTLN')
order by LAST_ANALYZED asc;
exit;
