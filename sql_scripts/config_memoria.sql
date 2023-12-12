-- ===============================================================
-- NAME: config_memoria.sql
-- DESCRIPTION: Shows sga and pga values
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col PGA_en_bytes format a30
col SGA_TARGET_EN_BYTES for a30
col SGA_MAX_BYTES_EN_BYTES for a30
prompt 
prompt ===========================================================
PROMPT VALORES DE MEMORIA EN BASE AL DBTIME DE LA CARGA DE LA BBDD
prompt ===========================================================
prompt 
PROMPT  VALORES PARA PGA
SELECT PGA_TARGET_FOR_ESTIMATE,PGA_TARGET_FACTOR,ESTD_EXTRA_BYTES_RW FROM v$pga_target_advice;
--SELECT PGA_TARGET_FOR_ESTIMATE,PGA_TARGET_FACTOR,ESTD_TIME/60 Minutos,ESTD_EXTRA_BYTES_RW FROM v$pga_target_advice;
--SELECT PGA_TARGET_FOR_ESTIMATE,PGA_TARGET_FACTOR,ESTD_TIME/60/60 Horas,ESTD_EXTRA_BYTES_RW FROM v$pga_target_advice;
--SELECT PGA_TARGET_FOR_ESTIMATE,PGA_TARGET_FACTOR,ESTD_TIME/60/60/24 dias,ESTD_EXTRA_BYTES_RW FROM v$pga_target_advice;

PROMPT VALORES PARA SGA
SELECT SGA_SIZE, SGA_SIZE_FACTOR, ESTD_DB_TIME FROM v$sga_target_advice ORDER BY SGA_SIZE_FACTOR;
PROMPT VALORES PARA MEMORY TARGET (MEMORIA AUTOMATICA)
SELECT MEMORY_SIZE,MEMORY_SIZE_FACTOR,ESTD_DB_TIME FROM v$memory_target_advice;
prompt
prompt
prompt VALORES CONFIGURADOS ACTUALMENTE
prompt 
select value PGA_en_bytes from v$parameter where name='pga_aggregate_target';
PROMPT
PROMPT  
select value  SGA_TARGET_EN_BYTES from v$parameter where name='sga_target';
PROMPT 
PROMPT
select value  SGA_MAX_BYTES_EN_BYTES from v$parameter where name='sga_max_size';
PROMPT
PROMPT

