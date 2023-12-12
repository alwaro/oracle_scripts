-- ===============================================================
-- NAME: undo.sql
-- DESCRIPTION: Displays info about the undo usage by session, the sum of segments and the state of the tablespace.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

prompt USO DE UNDO POR SESSION
PROMPT ======================================================================
set line 200;
SELECT TO_CHAR(s.sid)||','||TO_CHAR(s.serial#) sid_serial,
NVL(s.username, 'None') orauser,
s.program,
r.name undoseg,
t.used_ublk * TO_NUMBER(x.value)/1024||'K' "Undo"
FROM sys.v_$rollname r,
sys.v_$session s,
sys.v_$transaction t,
sys.v_$parameter x
WHERE s.taddr = t.addr
AND r.usn = t.xidusn(+)
AND x.name = 'db_block_size'
/


PROMPT UNDO USAGE (undousage.log)
PROMPT =======================================================================
spo undousage.log
SET LINESIZE 200
COLUMN username FORMAT A15
SELECT s.username,
       s.sid,
       s.serial#,
       t.used_ublk,
       t.used_urec,
       rs.segment_name,
       r.rssize,
       r.status
FROM   v$transaction t,
       v$session s,
       v$rollstat r,
       dba_rollback_segs rs
WHERE  s.saddr = t.ses_addr
AND    t.xidusn = r.usn
AND   rs.segment_id = t.xidusn
ORDER BY t.used_ublk DESC;
spo off;


prompt SUMATORIO DE SEGMENTOS
PROMPT =======================================================================
SELECT SYSDATE AS fecha,
       unexpired.unexpired,
       expired.expired,
       active.active
FROM   (SELECT Sum(bytes / 1024 / 1024) AS unexpired
        FROM   dba_undo_extents
        WHERE  status = 'UNEXPIRED') unexpired,
       (SELECT Sum(bytes / 1024 / 104) AS expired
        FROM   dba_undo_extents tr
        WHERE  status = 'EXPIRED') expired,
       (SELECT CASE
                 WHEN Count(status) = 0
                 THEN 0
                 ELSE Sum(bytes / 1024 / 1024)
               END AS active
        FROM   dba_undo_extents
        WHERE  status = 'ACTIVE') active;



PROMPT ESTADO DEL UNDO (BASADO EN ESPACIO)
PROMPT ======================================================================
col allocated for 999,999.999
col free      for 999,999.999
col used      for 999,999.999

select
    ( select sum(bytes)/1024/1024 from dba_data_files
       where tablespace_name like 'UND%' )  allocated,
    ( select sum(bytes)/1024/1024 from dba_free_space
       where tablespace_name like 'UND%')  free,
    ( select sum(bytes)/1024/1024 from dba_undo_extents
       where tablespace_name like 'UND%') USed
from dual
/


