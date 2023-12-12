-- ===============================================================
-- NAME: rman_spid.sql
-- DESCRIPTION: Displays the spid of rman.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
spo spid.log
SET LINES 150
set pages 999
COLUMN spid FORMAT A10
COLUMN username FORMAT A22
COLUMN program FORMAT A40
col machine format a20
col osuser format a14
SELECT s.inst_id,
       s.sid,
       s.serial#,
       p.spid,
       s.username,
       s.program,
       s.osuser,
       s.machine
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id
WHERE  s.type != 'BACKGROUND' and s.program LIKE '%rman%';
spo off

