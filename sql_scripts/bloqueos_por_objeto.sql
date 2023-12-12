-- ===============================================================
-- NAME: bloqueos_por_objeto
-- DESCRIPTION: Show locks for objects
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 300
set pages 999
col object_name for a19
col sid format 99999
col spid format a8
col serial format a8
col full_text format a100
col program format a25
col logon_time format a30
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
spoo blo2.log
SELECT
O.OBJECT_NAME,
S.SID,
S.SERIAL#,
P.SPID,
S.PROGRAM,
SQ.SQL_FULLTEXT,
S.LOGON_TIME
FROM
V$LOCKED_OBJECT L,
DBA_OBJECTS O,
V$SESSION S,
V$PROCESS P,
V$SQL SQ
WHERE
L.OBJECT_ID = O.OBJECT_ID
AND L.SESSION_ID = S.SID
AND S.PADDR = P.ADDR
AND S.SQL_ADDRESS = SQ.ADDRESS;
spoo off

