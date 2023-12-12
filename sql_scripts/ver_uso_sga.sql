-- ===============================================================
-- NAME: ver_uso_sga.sql
-- DESCRIPTION: Displays SGA usage 
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

spool ver_uso_sga.log
prompt
prompt
PROMPT CONFIGURACION DE LOS PARAMETROS DE MEMORIA
PROMPT =========================================================================================
set lines 250
set pages 999
col name format a30
col "Free (MB)" format 9,999.99
col parameter FORMAT A25
col component FORMAT A30
select name, value/1024/1024 total_mb from v$parameter where name in ('db_cache_size','java_pool_size', 'large_pool_size', 'memory_max_target','memory_target', 'pga_aggregate_target','sga_max_size', 'sga_target', 'shared_pool_size', 'streams_pool_size') order by name;
PROMPT
PROMPT
PROMPT TAMAÑO ACTUAL, MINIMO Y MAXIMO
PROMPT =========================================================================================
SELECT component,ROUND(current_size/1024/1024) AS current_size_mb, ROUND(min_size/1024/1024) AS min_size_mb, ROUND(max_size/1024/1024) AS max_size_mb FROM v$sga_dynamic_components WHERE current_size != 0 ORDER BY component;
prompt
prompt
prompt MEMORIA LIBRE
PROMPT =========================================================================================
SELECT inst_id, pool, name, bytes/1024/1024 "Free (MB)" FROM gv$sgastat WHERE name='free memory' ORDER BY 1,2;
prompt
prompt
PROMPT ULTIMOS MOVIMIENTOS DE REDIMENSIONAMIENTO
prompt =========================================================================================
SELECT component, parameter, ROUND(initial_size/1024/1024) AS Initial_mb, ROUND(final_size/1024/1024) AS Final_mb, status, OPER_TYPE, to_char(end_time, 'DD-MON HH24:MI')as "Changed At" FROM V$SGA_RESIZE_OPS Where end_time > sysdate -1 ORDER BY end_time;
PROMPT
prompt
prompt SGA TARGET ADVICE
PROMPT =========================================================================================
select * from v$sga_target_advice order by sga_size;
prompt
spoo off;
