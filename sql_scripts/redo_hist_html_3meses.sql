-- ===============================================================
-- NAME: redo_hist_html_3meses.sql
-- DESCRIPTION: This script allows to check archive log count for each day on hourly basis  Related infomations..
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
------------------------------------------------------------------------
-- It could be automated
--
-- Ouput is as simple as an HTML file.
--
-- Requirements :
-- Should be excuted as SYSTEM user or DBA equivalent.
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
       'DB_arch_count'                                                  spool_prefix
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
REPH PAGE CENTER BOLD 'CHECK COUNT OF ARCHIVE LOG GENERATED ON HOURLY BASIS'

set pagesize 300
col first_time for a50
set linesize 300
select
 to_char(first_time,'YYYY-MM-DD') day,
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)),'999') "00",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)),'999') "01",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)),'999') "02",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)),'999') "03",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)),'999') "04",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)),'999') "05",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)),'999') "06",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)),'999') "07",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)),'999') "08",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)),'999') "09",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)),'999') "10",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)),'999') "11",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)),'999') "12",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)),'999') "13",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)),'999') "14",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)),'999') "15",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)),'999') "16",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)),'999') "17",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)),'999') "18",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)),'999') "19",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)),'999') "20",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)),'999') "21",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)),'999') "22",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)),'999') "23",
   COUNT(*) TOTAL
   from v$log_history where first_time>sysdate-90
 group by to_char(first_time,'YYYY-MM-DD')
 order by day desc
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


