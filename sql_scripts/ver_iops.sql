-- ===============================================================
-- NAME: ver_iops.sql
-- DESCRIPTION: Displays information about the I/O operations 
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set lines 200
set pages 100
col ID format 999999
col DU format 99999
col INSTANCES for 999
col LOGONS_CURR for 999999
col LOGONS_CUM for 999999
col EXECS for 999999
SELECT snaps.id,
snaps.tm,
snaps.dur,
snaps.instances,
((sysstat.IOPsr - lag (sysstat.IOPsr,1) over (order by snaps.id)))/dur/60 IOPsr,
((sysstat.IOPsw - lag (sysstat.IOPsw,1) over (order by snaps.id)))/dur/60 IOPsw,
((sysstat.IOPsredo - lag (sysstat.IOPsredo,1) over (order by snaps.id)))/dur/60 IOPsredo,
(((sysstat.IOPsr - lag (sysstat.IOPsr,1) over (order by snaps.id)))/dur/60) +
(((sysstat.IOPsw - lag (sysstat.IOPsw,1) over (order by snaps.id)))/dur/60) +
(((sysstat.IOPsredo - lag (sysstat.IOPsredo,1) over (order by snaps.id)))/dur/60) Totiops,
sysstat.logons_curr ,
((sysstat.logons_cum - lag (sysstat.logons_cum,1) over (order by snaps.id)))/dur/60
logons_cum,
((sysstat.execs - lag (sysstat.execs,1) over (order by snaps.id)))/dur/60 execs
FROM
(
/* DBA_HIST_SNAPSHOT */
SELECT DISTINCT id,
dbid,
tm,
instances,
MAX(dur) over (partition BY id) dur
FROM
( SELECT DISTINCT s.snap_id id,
s.dbid,
TO_CHAR(s.end_interval_time,'DD-MON-RR HH24:MI') tm,
COUNT(s.instance_number) over (partition BY snap_id) instances,
1440*((CAST(s.end_interval_time AS DATE) - lag(CAST(s.end_interval_time AS DATE),1) over
(order by s.snap_id))) dur
FROM dba_hist_snapshot s,
v$database d
WHERE s.dbid=d.dbid
)
) snaps,
(
/* DBA_HIST_SYSSTAT */
SELECT *
FROM
(SELECT snap_id, dbid, stat_name, value FROM dba_hist_sysstat
) pivot (SUM(value) FOR (stat_name) IN ('logons current' AS logons_curr, 'logons cumulative'
AS logons_cum, 'execute count' AS execs, 'physical read IO requests' AS IOPsr,
'physical write IO requests' AS IOPsw, 'redo writes' AS IOPsredo))
) sysstat
WHERE dur > 0
AND snaps.id =sysstat.snap_id
AND snaps.dbid=sysstat.dbid
ORDER by id asc;
