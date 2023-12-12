-- ===============================================================
-- NAME: undo_usage.sql
-- DESCRIPTION: Displays the undo tablespace usage.
-- USAGE: Execute
-- AUTHOR: Desconocido
-- ---------------------------------------------------------------

set lines 350
set pages 999
col NAME FORMAT A20
col SIZE_MB format 99999999
col LOGON  format a10
col SID format 9999999
col SERIAL# format 99999999
COL SPID FORMAT A10
col username format a16
col osuser format a22
col machine format a22
col program format a16
col module format a15
col action format a15
spoo undo_usage.log
SELECT r.NAME "UNDO SEGMENT NAME", dba_seg.size_mb,
DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL, TRUNC(SYSDATE - LOGON_TIME) || ' Days' || ' + ') ||
TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON,
v$session.SID, v$session.SERIAL#, p.SPID, v$session.process,
v$session.USERNAME, v$session.STATUS, v$session.OSUSER, v$session.MACHINE, v$session.PROGRAM, v$session.module, action
FROM v$lock l, v$process p, v$rollname r, v$session,
(SELECT segment_name, ROUND(bytes/(1024*1024),2) size_mb FROM dba_segments WHERE segment_type = 'TYPE2 UNDO' ORDER BY bytes DESC) dba_seg
WHERE l.SID = p.pid(+) AND
v$session.SID = l.SID AND
TRUNC (l.id1(+)/65536)=r.usn AND
l.TYPE(+) = 'TX' AND
l.lmode(+) = 6
AND r.NAME = dba_seg.segment_name
--AND v$session.username = 'SYSTEM'
--AND status = 'INACTIVE'
ORDER BY size_mb DESC;
spoo off;

