-- ===============================================================
-- NAME: planes_usados_por_sqlid.sql
-- DESCRIPTION: Displays the last 30 executions of an SQLID.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set pages 999
set lines 200
set feedback off;
set verify off;
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
spool planes_usados_por_&&SQL_ID_VALUE..log
prompt
prompt MOSTRANDO LAS ULTIMAS 30 EJECUCIONES DE UN SQLID (&&SQL_ID_VALUE)
prompt ========================================================================
prompt
select * from (
select SQL_ID
  ,PLAN_HASH_VALUE PLAN_EJECUCION
  ,COST COSTE
  ,CPU_COST COSTE_CPU
  ,IO_COST COSTE_IO
  ,TIME DURACION
  ,TIMESTAMP FECHA_EJECUCION
from DBA_HIST_SQL_PLAN
  where SQL_ID=lower('&&SQL_ID_VALUE')
  order by timestamp desc
)
where
rownum < 50;
set feedback on;
set verify on;
spoo off;
undef SQL_ID_VALUE;

