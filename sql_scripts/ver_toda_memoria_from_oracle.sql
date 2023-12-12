-- ===============================================================
-- NAME: ver_toda_memoria_from_oracle.sql
-- DESCRIPTION: Script from oracle support to see all about memory
-- USAGE: exeute
-- AUTHOR: Oracle Support
-- ---------------------------------------------------------------
spool /tmp/memory_report.txt
col VALUE for a50
set pagesize 100
set pagesize 100
col Parameter for a50
col "Session Value" for a50
col "Instance Value" for a50
column component format a25
column Initial format 99,999,999,999
column Final format 99,999,999,999
column Started format A25
select name,value from v$system_parameter where name in ( 'memory_max_target', 'memory_target', 'sga_max_size', 'sga_target', 'shared_pool_size', 'db_cache_size', 'large_pool_size', 'java_pool_size', 'pga_aggregate_target', 'workarea_size_policy', 'streams_pool_size' ) ;
select a.ksppinm "Parameter", b.ksppstvl "Session Value", c.ksppstvl "Instance Value"
from sys.x$ksppi a, sys.x$ksppcv b, sys.x$ksppsv c
where a.indx = b.indx and a.indx = c.indx and a.ksppinm in
('__shared_pool_size','__db_cache_size','__large_pool_size','__java_pool_size','__streams_pool_size','__pga_aggregate_target','__sga_target','memory_target');
select * from v$sgastat where pool like '%shared%' order by bytes;
select NAMESPACE,GETHITRATIO,PINHITRATIO,RELOADS,INVALIDATIONS from v$librarycache;
SELECT COMPONENT ,OPER_TYPE,INITIAL_SIZE "Initial",FINAL_SIZE "Final",to_char(start_time,'dd-mon hh24:mi:ss') Started FROM V$SGA_RESIZE_OPS;
SELECT COMPONENT ,OPER_TYPE,INITIAL_SIZE "Initial",FINAL_SIZE "Final",to_char(start_time,'dd-mon hh24:mi:ss') Started FROM V$MEMORY_RESIZE_OPS;
select SHARED_POOL_SIZE_FOR_ESTIMATE,ESTD_LC_LOAD_TIME_FACTOR,ESTD_LC_LOAD_TIME "Current Time" from GV$SHARED_POOL_ADVICE;
select sga_size, sga_size_factor, estd_db_time from gv$sga_target_advice;
spool off;

