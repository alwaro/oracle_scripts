-- ===============================================================
-- NAME: todos.sql
-- DESCRIPTION: Displays information about the memory and PGA usage
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

-- ##########################
-- memoria_desglose.sql
-- ##########################


COLUMN sum_bytes new_value divide_by noprint
COLUMN percent format 999.99999
SET pages 60 lines 80 feedback off verify off
BREAK on report
COMPUTE sum of bytes on report
COMPUTE sum of percent on report
SELECT SUM (VALUE) sum_bytes
  FROM SYS.v_$sga;
TTITLE left _date center 'SGA Component Sizes Report' skip 2
WITH total_size AS
     (SELECT SUM (VALUE) sum_bytes
        FROM SYS.v_$sga)
SELECT   a.NAME, a.BYTES, a.BYTES / b.sum_bytes * 100 PERCENT
    FROM SYS.v_$sgastat a, total_size b
ORDER BY BYTES ASC
/
CLEAR columns
CLEAR breaks
SET pages 22 lines 80 feedback on verify on
TTITLE off




-- ##########################
-- memoria_pga_60_html.sql
-- ##########################


SET MARKUP HTML ON
spoo pga_ultimos_60_dias.html
WITH
pgastat_denorm_1 AS (
SELECT /*+ MATERIALIZE NO_MERGE */
       snap_id,
       dbid,
       instance_number,
       SUM(CASE name WHEN 'PGA memory freed back to OS'           THEN value ELSE 0 END) pga_mem_freed_to_os,
       SUM(CASE name WHEN 'aggregate PGA auto target'             THEN value ELSE 0 END) aggr_pga_auto_target,
       SUM(CASE name WHEN 'aggregate PGA target parameter'        THEN value ELSE 0 END) aggr_pga_target_param,
       SUM(CASE name WHEN 'bytes processed'                       THEN value ELSE 0 END) bytes_processed,
       SUM(CASE name WHEN 'extra bytes read/written'              THEN value ELSE 0 END) extra_bytes_rw,
       SUM(CASE name WHEN 'global memory bound'                   THEN value ELSE 0 END) global_memory_bound,
       SUM(CASE name WHEN 'maximum PGA allocated'                 THEN value ELSE 0 END) max_pga_allocated,
       SUM(CASE name WHEN 'maximum PGA used for auto workareas'   THEN value ELSE 0 END) max_pga_used_aut_wa,
       SUM(CASE name WHEN 'maximum PGA used for manual workareas' THEN value ELSE 0 END) max_pga_used_man_wa,
       SUM(CASE name WHEN 'total PGA allocated'                   THEN value ELSE 0 END) tot_pga_allocated,
       SUM(CASE name WHEN 'total PGA inuse'                       THEN value ELSE 0 END) tot_pga_inuse,
       SUM(CASE name WHEN 'total PGA used for auto workareas'     THEN value ELSE 0 END) tot_pga_used_aut_wa,
       SUM(CASE name WHEN 'total PGA used for manual workareas'   THEN value ELSE 0 END) tot_pga_used_man_wa,
       SUM(CASE name WHEN 'total freeable PGA memory'             THEN value ELSE 0 END) tot_freeable_pga_mem
  FROM dba_hist_pgastat
 WHERE name IN
('PGA memory freed back to OS'
,'aggregate PGA auto target'
,'aggregate PGA target parameter'
,'bytes processed'
,'extra bytes read/written'
,'global memory bound'
,'maximum PGA allocated'
,'maximum PGA used for auto workareas'
,'maximum PGA used for manual workareas'
,'total PGA allocated'
,'total PGA inuse'
,'total PGA used for auto workareas'
,'total PGA used for manual workareas'
,'total freeable PGA memory'
)
   AND snap_id in (select snap_id from dba_hist_snapshot where begin_interval_time > sysdate -60)
 GROUP BY
       snap_id,
       dbid,
       instance_number
),
pgastat_denorm_2 AS (
SELECT /*+ MATERIALIZE NO_MERGE */
       h.dbid,
       h.instance_number,
       s.startup_time,
       MIN(h.pga_mem_freed_to_os) pga_mem_freed_to_os,
       MIN(h.bytes_processed) bytes_processed,
       MIN(h.extra_bytes_rw) extra_bytes_rw
  FROM pgastat_denorm_1 h,
       dba_hist_snapshot s
 WHERE s.snap_id = h.snap_id
   AND s.dbid = h.dbid
   AND s.instance_number = h.instance_number
 GROUP BY
       h.dbid,
       h.instance_number,
       s.startup_time
),
pgastat_delta AS (
SELECT /*+ MATERIALIZE NO_MERGE */
       h1.snap_id,
       h1.dbid,
       h1.instance_number,
       s1.begin_interval_time,
       s1.end_interval_time,
       ROUND((CAST(s1.end_interval_time AS DATE) - CAST(s1.begin_interval_time AS DATE)) * 24 * 60 * 60) interval_secs,
       (h1.pga_mem_freed_to_os - h0.pga_mem_freed_to_os) pga_mem_freed_to_os,
       h1.aggr_pga_auto_target,
       h1.aggr_pga_target_param,
       (h1.bytes_processed - h0.bytes_processed) bytes_processed,
       (h1.extra_bytes_rw - h0.extra_bytes_rw) extra_bytes_rw,
       h1.global_memory_bound,
       h1.max_pga_allocated,
       h1.max_pga_used_aut_wa,
       h1.max_pga_used_man_wa,
       h1.tot_pga_allocated,
       h1.tot_pga_inuse,
       h1.tot_pga_used_aut_wa,
       h1.tot_pga_used_man_wa,
       h1.tot_freeable_pga_mem
  FROM pgastat_denorm_1 h0,
       pgastat_denorm_1 h1,
       dba_hist_snapshot s0,
       dba_hist_snapshot s1,
       pgastat_denorm_2 min /* to see cumulative use (replace h0 with min on select list above) */
 WHERE h1.snap_id = h0.snap_id + 1
   AND h1.dbid = h0.dbid
   AND h1.instance_number = h0.instance_number
   AND s0.snap_id = h0.snap_id
   AND s0.dbid = h0.dbid
   AND s0.instance_number = h0.instance_number
   AND s1.snap_id = h1.snap_id
   AND s1.dbid = h1.dbid
   AND s1.instance_number = h1.instance_number
   AND s1.snap_id = s0.snap_id + 1
   AND s1.startup_time = s0.startup_time
   AND s1.begin_interval_time > (s0.begin_interval_time + (1 / (24 * 60))) /* filter out snaps apart < 1 min */
   AND min.dbid = s1.dbid
   AND min.instance_number = s1.instance_number
   AND min.startup_time = s1.startup_time
)
SELECT snap_id,
       TO_CHAR(MIN(begin_interval_time), 'YYYY-MM-DD HH24:MI') begin_time,
       TO_CHAR(MIN(end_interval_time), 'YYYY-MM-DD HH24:MI') end_time,
       ROUND(SUM(pga_mem_freed_to_os) / POWER(2, 30), 3) pga_mem_freed_to_os,
       ROUND(SUM(aggr_pga_auto_target) / POWER(2, 30), 3) aggr_pga_auto_target,
       ROUND(SUM(aggr_pga_target_param) / POWER(2, 30), 3) aggr_pga_target_param,
       ROUND(SUM(bytes_processed) / POWER(2, 30), 3) bytes_processed,
       ROUND(SUM(extra_bytes_rw) / POWER(2, 30), 3) extra_bytes_rw,
       ROUND(SUM(global_memory_bound) / POWER(2, 30), 3) global_memory_bound,
       ROUND(SUM(max_pga_allocated) / POWER(2, 30), 3) max_pga_allocated,
       ROUND(SUM(max_pga_used_aut_wa) / POWER(2, 30), 3) max_pga_used_aut_wa,
       ROUND(SUM(max_pga_used_man_wa) / POWER(2, 30), 3) max_pga_used_man_wa,
       ROUND(SUM(tot_pga_allocated) / POWER(2, 30), 3) tot_pga_allocated,
       ROUND(SUM(tot_pga_inuse) / POWER(2, 30), 3) tot_pga_inuse,
       ROUND(SUM(tot_pga_used_aut_wa) / POWER(2, 30), 3) tot_pga_used_aut_wa,
       ROUND(SUM(tot_pga_used_man_wa) / POWER(2, 30), 3) tot_pga_used_man_wa,
       ROUND(SUM(tot_freeable_pga_mem) / POWER(2, 30), 3) tot_freeable_pga_mem,
       0 dummy_15
  FROM pgastat_delta
 GROUP BY snap_id
 ORDER BY snap_id;
spoo off;
SET MARKUP HTML OFF;





-- ##########################
-- memoria_pga_60.sql
-- ##########################


spoo memoria_pga_usada_60_dias.log
WITH
pgastat_denorm_1 AS (
SELECT /*+ MATERIALIZE NO_MERGE */
       snap_id,
       dbid,
       instance_number,
       SUM(CASE name WHEN 'PGA memory freed back to OS'           THEN value ELSE 0 END) pga_mem_freed_to_os,
       SUM(CASE name WHEN 'aggregate PGA auto target'             THEN value ELSE 0 END) aggr_pga_auto_target,
       SUM(CASE name WHEN 'aggregate PGA target parameter'        THEN value ELSE 0 END) aggr_pga_target_param,
       SUM(CASE name WHEN 'bytes processed'                       THEN value ELSE 0 END) bytes_processed,
       SUM(CASE name WHEN 'extra bytes read/written'              THEN value ELSE 0 END) extra_bytes_rw,
       SUM(CASE name WHEN 'global memory bound'                   THEN value ELSE 0 END) global_memory_bound,
       SUM(CASE name WHEN 'maximum PGA allocated'                 THEN value ELSE 0 END) max_pga_allocated,
       SUM(CASE name WHEN 'maximum PGA used for auto workareas'   THEN value ELSE 0 END) max_pga_used_aut_wa,
       SUM(CASE name WHEN 'maximum PGA used for manual workareas' THEN value ELSE 0 END) max_pga_used_man_wa,
       SUM(CASE name WHEN 'total PGA allocated'                   THEN value ELSE 0 END) tot_pga_allocated,
       SUM(CASE name WHEN 'total PGA inuse'                       THEN value ELSE 0 END) tot_pga_inuse,
       SUM(CASE name WHEN 'total PGA used for auto workareas'     THEN value ELSE 0 END) tot_pga_used_aut_wa,
       SUM(CASE name WHEN 'total PGA used for manual workareas'   THEN value ELSE 0 END) tot_pga_used_man_wa,
       SUM(CASE name WHEN 'total freeable PGA memory'             THEN value ELSE 0 END) tot_freeable_pga_mem
  FROM dba_hist_pgastat
 WHERE name IN
('PGA memory freed back to OS'
,'aggregate PGA auto target'
,'aggregate PGA target parameter'
,'bytes processed'
,'extra bytes read/written'
,'global memory bound'
,'maximum PGA allocated'
,'maximum PGA used for auto workareas'
,'maximum PGA used for manual workareas'
,'total PGA allocated'
,'total PGA inuse'
,'total PGA used for auto workareas'
,'total PGA used for manual workareas'
,'total freeable PGA memory'
)
   AND snap_id in (select snap_id from dba_hist_snapshot where begin_interval_time > sysdate -60)
 GROUP BY
       snap_id,
       dbid,
       instance_number
),
pgastat_denorm_2 AS (
SELECT /*+ MATERIALIZE NO_MERGE */
       h.dbid,
       h.instance_number,
       s.startup_time,
       MIN(h.pga_mem_freed_to_os) pga_mem_freed_to_os,
       MIN(h.bytes_processed) bytes_processed,
       MIN(h.extra_bytes_rw) extra_bytes_rw
  FROM pgastat_denorm_1 h,
       dba_hist_snapshot s
 WHERE s.snap_id = h.snap_id
   AND s.dbid = h.dbid
   AND s.instance_number = h.instance_number
 GROUP BY
       h.dbid,
       h.instance_number,
       s.startup_time
),
pgastat_delta AS (
SELECT /*+ MATERIALIZE NO_MERGE */
       h1.snap_id,
       h1.dbid,
       h1.instance_number,
       s1.begin_interval_time,
       s1.end_interval_time,
       ROUND((CAST(s1.end_interval_time AS DATE) - CAST(s1.begin_interval_time AS DATE)) * 24 * 60 * 60) interval_secs,
       (h1.pga_mem_freed_to_os - h0.pga_mem_freed_to_os) pga_mem_freed_to_os,
       h1.aggr_pga_auto_target,
       h1.aggr_pga_target_param,
       (h1.bytes_processed - h0.bytes_processed) bytes_processed,
       (h1.extra_bytes_rw - h0.extra_bytes_rw) extra_bytes_rw,
       h1.global_memory_bound,
       h1.max_pga_allocated,
       h1.max_pga_used_aut_wa,
       h1.max_pga_used_man_wa,
       h1.tot_pga_allocated,
       h1.tot_pga_inuse,
       h1.tot_pga_used_aut_wa,
       h1.tot_pga_used_man_wa,
       h1.tot_freeable_pga_mem
  FROM pgastat_denorm_1 h0,
       pgastat_denorm_1 h1,
       dba_hist_snapshot s0,
       dba_hist_snapshot s1,
       pgastat_denorm_2 min /* to see cumulative use (replace h0 with min on select list above) */
 WHERE h1.snap_id = h0.snap_id + 1
   AND h1.dbid = h0.dbid
   AND h1.instance_number = h0.instance_number
   AND s0.snap_id = h0.snap_id
   AND s0.dbid = h0.dbid
   AND s0.instance_number = h0.instance_number
   AND s1.snap_id = h1.snap_id
   AND s1.dbid = h1.dbid
   AND s1.instance_number = h1.instance_number
   AND s1.snap_id = s0.snap_id + 1
   AND s1.startup_time = s0.startup_time
   AND s1.begin_interval_time > (s0.begin_interval_time + (1 / (24 * 60))) /* filter out snaps apart < 1 min */
   AND min.dbid = s1.dbid
   AND min.instance_number = s1.instance_number
   AND min.startup_time = s1.startup_time
)
SELECT snap_id,
       TO_CHAR(MIN(begin_interval_time), 'YYYY-MM-DD HH24:MI') begin_time,
       TO_CHAR(MIN(end_interval_time), 'YYYY-MM-DD HH24:MI') end_time,
       ROUND(SUM(pga_mem_freed_to_os) / POWER(2, 30), 3) pga_mem_freed_to_os,
       ROUND(SUM(aggr_pga_auto_target) / POWER(2, 30), 3) aggr_pga_auto_target,
       ROUND(SUM(aggr_pga_target_param) / POWER(2, 30), 3) aggr_pga_target_param,
       ROUND(SUM(bytes_processed) / POWER(2, 30), 3) bytes_processed,
       ROUND(SUM(extra_bytes_rw) / POWER(2, 30), 3) extra_bytes_rw,
       ROUND(SUM(global_memory_bound) / POWER(2, 30), 3) global_memory_bound,
       ROUND(SUM(max_pga_allocated) / POWER(2, 30), 3) max_pga_allocated,
       ROUND(SUM(max_pga_used_aut_wa) / POWER(2, 30), 3) max_pga_used_aut_wa,
       ROUND(SUM(max_pga_used_man_wa) / POWER(2, 30), 3) max_pga_used_man_wa,
       ROUND(SUM(tot_pga_allocated) / POWER(2, 30), 3) tot_pga_allocated,
       ROUND(SUM(tot_pga_inuse) / POWER(2, 30), 3) tot_pga_inuse,
       ROUND(SUM(tot_pga_used_aut_wa) / POWER(2, 30), 3) tot_pga_used_aut_wa,
       ROUND(SUM(tot_pga_used_man_wa) / POWER(2, 30), 3) tot_pga_used_man_wa,
       ROUND(SUM(tot_freeable_pga_mem) / POWER(2, 30), 3) tot_freeable_pga_mem,
       0 dummy_15
  FROM pgastat_delta
 GROUP BY snap_id
 ORDER BY snap_id;
spoo off;





-- ##########################
-- memoria_pga_by_session.sql
-- ##########################


set lines 200
col sid format 9999999
col name format a25
col memory format 999999
col username format a20
col COMMAND for 999999
col OSUSER for a20
col MACHINE for a20
col TERMINAL for a20
col PROGRAM for a35
col STATISTIC# for 99999
select 
ssst.sid, 
stn.name , 
round(ssst.value/1024/1024,2) memory , 
USERNAME, 
COMMAND, 
OSUSER, 
MACHINE, 
TERMINAL, 
PROGRAM , 
ssst.STATISTIC# 
from v$statname stn,v$sesstat ssst , v$session ses 
where stn.STATISTIC# = ssst.STATISTIC# and 
ssst.sid = ses.sid and 
name like 'session%pga%memory%' 
order by 3 asc ; 




-- ##########################
-- memoria_por_sesiones.sql
-- ##########################


SET pages 999 
set lines 200
col username for a20
col OSUSER for a30
col sess.osuser for a20
set verify off feedback off echo off
COLUMN sess_mem heading "Current|session|memory|Mb" format 9,999,999,999,999
SET pages 66 lines 132 verify off feedback off
TTITLE left _date center 'Current Session Memory' skip 2
SELECT   NVL (username, 'SYS-Backgrnd') username, sess.SID,sess.serial#,sess.osuser, SUM (VALUE)/1024/1024 sess_mem
    FROM v$session sess, v$sesstat stat, v$statname NAME
   WHERE sess.SID = stat.SID
     AND stat.statistic# = NAME.statistic#
     AND NAME.NAME LIKE 'session % memory'
GROUP BY username, sess.SID, sess.serial#,sess.osuser
order by 5
/
TTITLE off





-- ##########################
-- memoria_procesos.sql
-- ##########################


set lines 250
set pages 999
col MB format 9999999999
col session for a80
col PID/THREAD for 9999999999
col "CURRENT SIZE" for 9999999999
col "MAXIMUM SIZE" for 9999999999
SELECT to_char(ssn.sid, '9999') || ' - ' || nvl(ssn.username, nvl(bgp.name, 'background')) ||
nvl(lower(ssn.machine), ins.host_name) "SESSION",
to_char(prc.spid, '999999999') "PID/THREAD",
to_char((se1.value/1024)/1024, '999G999G990D00') || ' MB' " CURRENT SIZE",
to_char((se2.value/1024)/1024, '999G999G990D00') || ' MB' " MAXIMUM SIZE"
FROM v$sesstat se1, v$sesstat se2, v$session ssn, v$bgprocess bgp, v$process prc,
v$instance ins, v$statname stat1, v$statname stat2
WHERE se1.statistic# = stat1.statistic# and stat1.name = 'session pga memory'
AND se2.statistic# = stat2.statistic# and stat2.name = 'session pga memory max'
AND se1.sid = ssn.sid
AND se2.sid = ssn.sid
AND ssn.paddr = bgp.paddr (+)
AND ssn.paddr = prc.addr (+)
order by 3;





-- ##########################
-- memoria_queries_usuario.sql
-- ##########################


COLUMN sql_text      FORMAT a40   HEADING Text word_wrapped
COLUMN sharable_mem               HEADING Shared|Bytes
COLUMN persistent_mem             HEADING Persistent|Bytes
COLUMN parse_calls                HEADING Parses
COLUMN users         FORMAT a15   HEADING "User"
COLUMN executions                 HEADING "Executions"
Ttitle left _date center 'SQL Area Memory Use' skip 2
SET LONG 1000 PAGES 59 LINES 132 ECHO OFF
BREAK ON users
COMPUTE SUM OF sharable_mem ON users
COMPUTE SUM OF persistent_mem ON users
COMPUTE SUM OF runtime_mem ON users
SELECT   username users, sql_text, executions, parse_calls, sharable_mem,
         persistent_mem
    FROM sys.v_$sqlarea a, dba_users b
   WHERE a.parsing_user_id = b.user_id
     AND b.username LIKE UPPER ('%&user_name%')
ORDER BY 1;




-- ##########################
-- memoria_sesion.sql
-- ##########################


-- Find out how much memory each session is using
set lines 320
COLUMN sid                     FORMAT 9999            HEADING 'SID'
COLUMN os_username             FORMAT a25            HEADING 'OS User'     JUSTIFY right
COLUMN oracle_username         FORMAT a12            HEADING 'Oracle User'     JUSTIFY right
COLUMN session_program         FORMAT a25            HEADING 'Session Program' TRUNC
COLUMN session_module         FORMAT a35            HEADING 'Session module' TRUNC
COLUMN session_action         FORMAT a18            HEADING 'Session action' TRUNC
COLUMN session_machine         FORMAT a8             HEADING 'Machine'   JUSTIFY right TRUNC
COLUMN session_pga_memory      FORMAT 9,999,999,999  HEADING 'PGA Memory'
COLUMN session_pga_memory_max  FORMAT 9,999,999,999  HEADING 'PGA Memory Max'
COLUMN session_uga_memory      FORMAT 9,999,999,999  HEADING 'UGA Memory'
COLUMN session_uga_memory_max  FORMAT 9,999,999,999  HEADING 'UGA Memory MAX'
COLUMN session_total_memory  FORMAT 9,999,999,999  HEADING 'Total Memory'

select sid,oracle_username,os_username,session_program,session_module,session_action, 
session_pga_memory,session_pga_memory_max,session_uga_memory,session_uga_memory_max,session_pga_memory+session_uga_memory session_total_memory from (
SELECT
    s.sid                sid
  , lpad(s.username,12)  oracle_username
  , lpad(s.osuser,25)     os_username
  , s.program            session_program
  , s.module            session_module
  , s.action            session_action
  , lpad(s.machine,8)    session_machine
  , (select ss.value from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and 
           sn.statistic# = ss.statistic# and
           sn.name = 'session pga memory')        session_pga_memory
  , (select ss.value from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and 
           sn.statistic# = ss.statistic# and
           sn.name = 'session pga memory max')    session_pga_memory_max
  , (select ss.value  from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and 
           sn.statistic# = ss.statistic# and
           sn.name = 'session uga memory')        session_uga_memory
  , (select ss.value from v$sesstat ss, v$statname sn
     where ss.sid = s.sid and 
           sn.statistic# = ss.statistic# and
           sn.name = 'session uga memory max')   as session_uga_memory_max
FROM 
    v$session  s )
ORDER BY session_total_memory DESC;



