-- ===============================================================
-- NAME: uso_memoria.sql
-- DESCRIPTION: Displays info about the memory usage.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set lines 210
set pages 999
PROMPT
PROMPT CONFIGURACION DE LOS PARAMETROS DE MEMORIA
PROMPT =====================================================
PROMPT 
SELECT NAME, VALUE/1024/1024 Mb
FROM V$PARAMETER
WHERE NAME IN (
'memory_target',
'memory_max_target',
'log_buffer',
'pga_aggregate_target',
'sga_target',
'sga_max_size',
'shared_pool_size',
'db_cache_size',
'large_pool_size',
'java_pool_size'
);

PROMPT
PROMPT
PROMPT USO DE LOS COMPONENTES DE MEMORIA
prompt =====================================================
prompt
select name, round(sum(mb),1) mb, round(sum(inuse),1) inuse
from (select case when name = 'buffer_cache'
then 'db_cache_size'
when name = 'log_buffer'
then 'log_buffer'
else pool
end name,
bytes/1024/1024 mb,
case when name <> 'free memory'
then bytes/1024/1024
end inuse
from v$sgastat
)group by name;


PROMPT 
PROMPT SUMATORIO DE MEMORIA SGA EN USO
PROMPT =======================================================
PROMPT 
select sum(bytes)/1024/1024 " SGA size used in MB" from v$sgastat where name!='free memory';
prompt


