-- ===============================================================
-- NAME: io_totales.sql
-- DESCRIPTION: Display IO values
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 100
set pages 999
spoo totales_io.log
select sum(a.value+b.value) "TOTAL LECTURAS FISICAS"
from v$segment_statistics a, v$segment_statistics b
where a.statistic_name='physical reads'
and   b.statistic_name='physical reads direct';
select sum(a.value+b.value) "TOTAL ESCRITURAS FISICAS"
from v$segment_statistics a, v$segment_statistics b
where a.statistic_name='physical writes'
and   b.statistic_name='physical writes direct';
spoo off;