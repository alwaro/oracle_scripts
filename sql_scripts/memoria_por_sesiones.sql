-- ===============================================================
-- NAME: memoria_por_sesiones.sql
-- DESCRIPTION: Displays the memory used by sessions.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
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

