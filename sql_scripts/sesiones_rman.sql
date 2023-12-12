-- ===============================================================
-- NAME: sesiones_rman.sql
-- DESCRIPTION: Displays info about the RMAN session.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 250
col p1 format 9999999
col p2 format 9999999
col p3 format 9999999
col client_info format a50
col event format a50
select
   s.inst_id,
   sid,
   spid,
   client_info,
   event,
   seconds_in_wait,
   p1, p2, p3
 from
   gv$process p,
   gv$session s
 where
   p.addr = s.paddr
 and
   client_info like 'rma%';

