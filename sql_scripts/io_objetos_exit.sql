set lines 200
set pages 999
spoo informe_io.log
col USUARIO format a25
col sql_id format a20
col direct_writes format 99999999999999999999
col QUERY format a100
col disk_reads format 99999999999999999999
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
select sum(a.value+b.value) "TOTAL LECTURAS FISICAS"
from v$segment_statistics a, v$segment_statistics b
where a.statistic_name='physical reads'
and   b.statistic_name='physical reads direct';
spoo off;
exit;
