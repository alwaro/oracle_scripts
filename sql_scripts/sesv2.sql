-- ===============================================================
-- NAME: sess.sql
-- DESCRIPTION: Displays info about the sessions.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 350
set pages 40
col sid_serial format a15
col USUARIO_BBDD format a15
col NODO format 9999
col programa format a40
col MAQUINA format a30
col USUARIO_SO format a30
col evento_actual format a60 
spoo sesv2.log
select
   inst_id NODO,
   TO_CHAR(s.sid)||','||TO_CHAR(s.serial#) SID_SERIAL,
   username USUARIO_BBDD,
   osuser USUARIO_SO,
   machine MAQUINA,
   program PROGRAMA,
   event EVENTO_ACTUAL
from
   gv$session s
order by 1;
spoo off;
