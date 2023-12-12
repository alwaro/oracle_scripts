-- ===============================================================
-- NAME: io_check.sql
-- DESCRIPTION: Display IO info with different views
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set lines 200
set pages 999
spoo informe_io.log
col USUARIO format a25
col sql_id format a20
col direct_writes format 99999999999999999999
col QUERY format a100
col disk_reads format 99999999999999999999
prompt ###################################################################
prompt ###################################################################
select instance_name, host_name from v$instance;
prompt ###################################################################
prompt ###################################################################
prompt 
prompt 
prompt ===================================================================
prompt                  NIVELES DE IO POR SCHEMA Y QUERY
prompt ====================================================================
prompt 
SELECT *
FROM
(SELECT
      parsing_schema_name USUARIO
     ,sql_id
     ,SUBSTR(sql_text,1,75) QUERY
     ,direct_writes 
     ,disk_reads
    FROM v$sql
    ORDER BY disk_reads DESC)
WHERE rownum < 10;
prompt 
prompt ====================================================================
prompt                     NIVELES DE IO POR OBJETO 
prompt ====================================================================
prompt
col statistic_name format a25
col owner format a16
col object_type format a25
col object_name format a30
col value format 99999999999999999999
SELECT *
FROM
(SELECT
      s.statistic_name
     ,s.owner
     ,s.object_type
     ,s.object_name
     ,s.value
      FROM v$segment_statistics s
      WHERE s.statistic_name IN
        ('physical reads', 'physical writes', 'logical reads',
                 'physical reads direct', 'physical writes direct')
            ORDER BY s.value DESC)
        WHERE rownum < 10;
prompt 
prompt
prompt
prompt ====================================================================
prompt               TOTALES LECTURAS Y ESCRITURAS FISICAS
prompt ====================================================================
select sum(a.value+b.value) "TOTAL LECTURAS FISICAS"
from v$segment_statistics a, v$segment_statistics b
where a.statistic_name='physical reads'
and   b.statistic_name='physical reads direct';

select sum(a.value+b.value) "TOTAL ESCRITURAS FISICAS"
from v$segment_statistics a, v$segment_statistics b
where a.statistic_name='physical writes'
and   b.statistic_name='physical writes direct';
spoo off;
