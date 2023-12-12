-- ===============================================================
-- NAME: pga_by_session.sql
-- DESCRIPTION: Displays the pga used by sessions.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
col username for a14
col LOGON format a20
col module format a42
col program for a42
col PGA_MB_USED for 999999999
col machine for a25
col spid for a7
col sid for 999999
col SERIAL# for 999999
set pages 50
spoo pga_by_session.log
SELECT DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL, TRUNC(SYSDATE - LOGON_TIME) || ' Days' || ' + ') || 
TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON, 
SID, v$session.SERIAL#, v$process.SPID , ROUND(v$process.pga_used_mem/(1024*1024), 2) PGA_MB_USED, 
v$session.USERNAME, STATUS, OSUSER, MACHINE, v$session.PROGRAM, MODULE 
FROM v$session, v$process 
WHERE v$session.paddr = v$process.addr 
--and status = 'ACTIVE' 
--and v$session.sid = 97
--and v$session.username = 'SYSTEM' 
--and v$process.spid = 24301
ORDER BY pga_used_mem DESC;
spoo off;

