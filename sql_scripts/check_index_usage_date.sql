-- ===============================================================
-- NAME: check_index_usage_date.sql
-- DESCRIPTION: Lists all the user indexes which haven't been used for more tha X days
-- USAGE: Execute
-- AUTHOR: alvaro
-- ---------------------------------------------------------------

set pages 999
COL NAME FOR A40
spoo lista_uso_indices_fecha.log
select OWNER, name, last_used from DBA_INDEX_USAGE where last_used < sysdate-30 and owner not in ('SYS','SYSTEM','OUTLN','DIP','ANONYMOUS','ORACLE_OCM','DBSNMP','APPQOSSYS','WMSYS','XDB','XS$NULL','SYSRAC','SYSBACKUP','PERFSTAT','STDBYPERF','AUDSYS','SYSDG','SYSKM','GSMADMIN_INTERNAL','GGSYS','GSMUSER','REMOTE_SCHEDULER_AGENT','DBSFWUSER','SYS$UMF','GSMCATUSER','SQLTXPLAIN','OJVMSYS','SQLTXADMIN') order by last_used desc;
spoo off;

