-- ===============================================================
-- NAME: segment_advisor_fragmentacion_leer_resultados.sql
-- DESCRIPTION: Generates a sentence to create an analysis from the segments of the table sysaux.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 300
set pages 999
COL TASK_NAME FOR A25
COL OBJETO FOR A35
COL PARTICION FOR A30
COL TIPO FOR A20
COL INFO_EXTENDIDA FOR a130
spoo resultado_fragmentacion.log
select DISTINCT ao.attr2 OBJETO, ao.attr3 PARTICION, ao.type TIPO, af.message INFO_EXTENDIDA
  from
  dba_advisor_findings af,
  dba_advisor_objects ao
where ao.task_id = af.task_id
  and ao.object_id = af.object_id
  AND AF.TASK_NAME='ANALISIS sysaux 20190513_16pm'
  and af.message != 'The free space in the object is less than 10MB.'
  order by 4;
spoo off;

