spo spid.log
SET LINES 250
set pages 999
COLUMN spid FORMAT 9999999
COLUMN username FORMAT A22
COLUMN program FORMAT A40
col machine format a35
col osuser format a25
col sid format 99999
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
WHERE  s.type != 'BACKGROUND'
and s.osuser='juan.melchor';
spo off

