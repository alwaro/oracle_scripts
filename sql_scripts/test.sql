-- ===============================================================
-- NAME: test.sql
-- DESCRIPTION: Displays info about the system
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col begin_interval_time format a30
set lines 160 pages 1000
col end_interval_time format a30
set colsep '|'
alter session set nls_date_format='DD-MON-YYYY';
with REDO_SIZE as (
SELECT  sysst.snap_id, sysst.instance_number, begin_interval_time ,end_interval_time ,  startup_time,
VALUE - lag (VALUE) OVER ( PARTITION BY  startup_time, sysst.instance_number
                ORDER BY begin_interval_time, startup_time, sysst.instance_number) stat_value,
EXTRACT (DAY    FROM (end_interval_time-begin_interval_time))*24*60*60+
            EXTRACT (HOUR   FROM (end_interval_time-begin_interval_time))*60*60+
            EXTRACT (MINUTE FROM (end_interval_time-begin_interval_time))*60+
            EXTRACT (SECOND FROM (end_interval_time-begin_interval_time)) DELTA
  FROM sys.wrh$_sysstat sysst , DBA_HIST_SNAPSHOT snaps
WHERE (sysst.dbid, sysst.stat_id) IN ( SELECT dbid, stat_id FROM sys.wrh$_stat_name WHERE  stat_name='redo size' )
AND snaps.snap_id = sysst.snap_id
AND snaps.dbid =sysst.dbid
AND sysst.instance_number=snaps.instance_number
and begin_interval_time > sysdate-30
)
select instance_number, 
  to_date(to_char(begin_interval_time,'DD-MON-YYYY'),'DD-MON-YYYY') DATE 
, sum(stat_value) REDO
from REDO_SIZE
group by  instance_number,
  to_date(to_char(begin_interval_time,'DD-MON-YYYY'),'DD-MON-YYYY') 
order by instance_number, 2;

