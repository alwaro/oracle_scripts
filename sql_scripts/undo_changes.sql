-- ===============================================================
-- NAME: undo_changes.sql
-- DESCRIPTION: Displays the changes that occur in the undo tablespace.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set lines 200

PROMPT ========================================================================================
PROMPT SCRIPT PARA VER LOS CAMBIOS ACTUALES QUE SE PRODUCEN EN EL UNDO. NO MUESTRA EL USO TOTAL
PROMPT      EL USO TOTAL LO MUESTRA EL SCRIPT: @$DBA/undo_usage
PROMPT =======================================================================================

col sid_serial format a20
select
   TO_CHAR(s.sid)||','||TO_CHAR(s.serial#) sid_serial,
   NVL(s.username, 'None') orauser,
   s.program,
   r.name undoseg,
   t.used_ublk * TO_NUMBER(x.value)/1024||'K' "Undo"
from
   sys.v_$rollname r,
   sys.v_$session s,
   sys.v_$transaction t,
   sys.v_$parameter x
where
   s.taddr = t.addr
AND 
   r.usn = t.xidusn(+)
AND 
   x.name = 'db_block_size';



select
   --s.sid, 
   TO_CHAR(s.sid)||','||TO_CHAR(s.serial#) sid_serial,
   s.username,
   r.name "RBS name", 
   t.start_time,
   t.used_ublk "Undo blocks",
   t.used_urec "Undo recs"
from
   v$session s,
   v$transaction t,
   v$rollname r
where
   t.addr = s.taddr 
and
   r.usn = t.xidusn;
   
select 
   TO_CHAR(s.sid)||','||TO_CHAR(s.serial#) sid_serial,
   s.username, 
   --s.sid, 
   --s.serial#, 
   s.logon_time, 
   t.xidusn, t.ubafil,
   t.ubablk, 
   t.used_ublk, 
   t.start_date, t.status
from
   v$session s, 
   v$transaction t
where 
   s.saddr = t.ses_addr;

