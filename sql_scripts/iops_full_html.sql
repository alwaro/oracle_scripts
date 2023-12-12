-- ===============================================================
-- NAME: acls.sql
-- DESCRIPTION: Gets an html report for iops
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
alter session set nls_date_format='dd-mm-yyyy hh24:mi';
set pages 30
col PHYSICAL_READ_TOTAL_BPS format 999999999999999
set markup html on spool on
spoo iops.html
select min(begin_time), max(end_time),
       sum(case metric_name when 'Physical Read Total Bytes Per Sec' then average end) Phys_Read_Total_Bps,
       sum(case metric_name when 'Physical Write Total Bytes Per Sec' then average end) Physical_Write_Total_Bps,
       sum(case metric_name when 'Redo Generated Per Sec' then average end) Redo_Bytes_per_sec,
       sum(case metric_name when 'Physical Read Total IO Requests Per Sec' then average end) Physical_Read_IOPS,
       sum(case metric_name when 'Physical Write Total IO Requests Per Sec' then average end) Physical_write_IOPS,
       sum(case metric_name when 'Redo Writes Per Sec' then average end) Physical_redo_IOPS,
       sum(case metric_name when 'Current OS Load' then average end) OS_LOad,
       sum(case metric_name when 'CPU Usage Per Sec' then average end) DB_CPU_Usage_per_sec,
       sum(case metric_name when 'Host CPU Utilization (%)' then average end) Host_CPU_util, --NOTE 100% = 1 loaded RAC node
       sum(case metric_name when 'Network Traffic Volume Per Sec' then average end) Network_bytes_per_sec,
       snap_id
from dba_hist_sysmetric_summary
group by snap_id
order by snap_id;
spool off;
