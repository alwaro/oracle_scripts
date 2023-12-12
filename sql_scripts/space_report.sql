-- ===============================================================
-- NAME: space_report.sql
-- DESCRIPTION: This script allows to check db space related infomations.
-- USAGE: Execute as SYSTEM user or DBA equivalent.
-- AUTHOR:
-- ---------------------------------------------------------------
------------------------------------------------------------------------
TTITLE OFF
CLEAR  COL
SET LINES   150 TRIM ON TRIMS ON
SET TERMOUT OFF
SET VERIFY  OFF
SET FEED    OFF
SET PAGES   9999
SET PAUSE   OFF
SET DOC     OFF

--
-- Get current time information used to name report
--

COLUMN timecol         NEW_VALUE timestamp
COLUMN spool_extension NEW_VALUE suffix
COLUMN spool_prefix    NEW_VALUE prefix

SELECT TO_CHAR(sysdate,'YYYYDDMM') timecol,
       'html'                                                       spool_extension,
       'DB_capacity'                                                  spool_prefix
FROM   sys.dual;

--
-- Get the current database/instance information used to name report
--

COLUMN inst_name HEADING "Instance"  NEW_VALUE inst_name FORMAT a12;
COLUMN db_name   HEADING "DB Name"   NEW_VALUE db_name   FORMAT a12;
COLUMN hostname  HEADING "Host"      NEW_VALUE host_name;

SELECT d.name            db_name,
       i.instance_name   inst_name,
       i.host_name       hostname
FROM   v$database d,
       v$instance i;

--
-- Building name of file to spool
--

COLUMN file_to_spool NEW_VALUE file_spool
SELECT '&&prefix._&&db_name._&&host_name._&&timestamp..&&suffix' AS file_to_spool
FROM   sys.dual ;

------------------------------------------------------------------------
--
-- Beginning of the script.
--
------------------------------------------------------------------------

SET MARKUP HTML ON SPOOL ON
SPOOL &&file_spool.

REPH PAGE CENTER BOLD 'INSTANCE RUNNING STATUS'
set pagesize 20000
col  LOG_MODE for a15
col OPEN_MODE for a15
col HOST_NAME for a20
set line 200
select  to_char(startup_time,'DD-MM-YYYY HH24:MI:SS') StartTime,
to_char(sysdate,'DD-MM-YYYY HH24:MI:SS') SysDateTime,instance_name,
 name db_name,log_mode, open_mode, HOST_NAME , VERSION
from dual, gv$database a , gv$instance b
where a.inst_id = b.inst_id
/
REPH PAGE CENTER BOLD 'TABLESPACE_REPORT'

set pagesize 30000

set lines 200
col TABLESPACE for a20
col TOTAL_SPACE_MB for 999999999999999
col FREE_SPACE_MB for 999999999999999
SELECT df.tablespace_name TABLESPACE, df.total_space_mb TOTAL_SPACE_MB,
(df.total_space_mb - fs.free_space_mb) USED_SPACE_MB,
fs.free_space_mb FREE_SPACE_MB,
ROUND(100 * (fs.free_space / df.total_space),2) PCT_FREE
FROM (SELECT tablespace_name, SUM (bytes) TOTAL_SPACE,
      ROUND( SUM (bytes) / 1048576) TOTAL_SPACE_MB
      FROM dba_data_files
      GROUP BY tablespace_name) df,
     (SELECT tablespace_name, SUM (bytes) FREE_SPACE,
       ROUND( SUM (bytes) / 1048576) FREE_SPACE_MB
       FROM dba_free_space
       GROUP BY tablespace_name) fs
WHERE df.tablespace_name = fs.tablespace_name(+)
ORDER BY 5;

REPH PAGE CENTER BOLD 'DATABASE_LOGICAL_SPACE'

select sum(bytes/1024/1024/1024) as SIZE_GB from dba_segments;

REPH PAGE CENTER BOLD 'DATABASE_PHYSICAL_SPACE'

set linesize 180
select round(sum(used.bytes) / 1024 / 1024 / 1024 ) || ' GB' "Database Size"
, round(sum(used.bytes) / 1024 / 1024 / 1024 ) -
 round(free.poo / 1024 / 1024 / 1024) || ' GB' "Used space"
, round(free.poo / 1024 / 1024 / 1024) || ' GB' "Free space"
from    (select bytes
 from v$datafile
 union all
 select bytes
 from  v$tempfile
 union  all
 select  bytes
 from  v$log) used
, (select sum(bytes) as poo
 from dba_free_space) free
group by free.poo
/



------------------------------------------------------------------------
--
-- End of the script.
--
------------------------------------------------------------------------

SPOOL OFF
SET REPH OFF
SET MARKUP HTML OFF
EXIT





