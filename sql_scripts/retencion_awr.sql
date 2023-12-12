-- ===============================================================
-- NAME: retencion_awr.sql
-- DESCRIPTION: Displays info of the retention time of an AWR
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT extract(day from snap_interval) *24*60+extract(hour from snap_interval) *60+extract(minute from snap_interval) snapshot_Interval,
extract(day from retention) *24*60+extract(hour from retention) *60+extract(minute from retention) retention_Interval
FROM dba_hist_wr_control;

