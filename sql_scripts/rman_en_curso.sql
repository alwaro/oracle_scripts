-- ===============================================================
-- NAME: rman_en_curso.sql
-- DESCRIPTION: Displays info of RMAN sessions that are runing
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
prompt ESTADO DE LA(S) SESION(ES) DE RMAN
PROMPT =======================================
set lines 250
col p1 format 9999999
col p2 format 9999999
col p3 format 9999999
col client_info format a50
col event format a50
select
   sid,
   spid,
   client_info,
   event,
   seconds_in_wait,
   p1, p2, p3
 from
   v$process p,
   v$session s
 where
   p.addr = s.paddr
 and
   client_info like 'rman channel=%';

PROMPT TAREAS EN CURSO DEL RMAN
PROMPT =======================================
set lines 350
col TOTAL_BYTES format 999,999,999,999,999
col status format a20
col filename format a90
col bytes format 999,999,999,999
select STATUS,FILENAME,TOTAL_BYTES, bytes,to_char(OPEN_TIME,'DD/mm/RR HH:MI:SS') from v$BACKUP_ASYNC_IO WHERE OPEN_TIME > TO_TIMESTAMP('20/03/2017 08:30', 'DD/MM/YYYY HH24:MI') and STATUS != 'FINISHED' and STATUS != 'UNKNOWN';

PROMPT ESTADO GENERAL DEL PROCESO DE COPIA
PROMPT =========================================

select
  sid,
  start_time,
  totalwork
  sofar,
 (sofar/totalwork) * 100 pct_done
from
   v$session_longops
where
   totalwork > sofar
AND
   opname NOT LIKE '%aggregate%'
AND
   opname like 'RMAN%';

