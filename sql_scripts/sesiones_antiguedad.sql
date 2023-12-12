-- ===============================================================
-- NAME: sesiones_antiguedad.sql
-- DESCRIPTION: Generates a sentence to display the seesions ordered by logon_time.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set pages 20
set lines 300
col NODO for 999
col SID for 99999
col SERIAL# for 9999999
col USERNAME for a25
col STATUS for a6
col OSUSER for a25
col PROCESS for a7
col MACHINE  for a25
col PROGRAM for a38
-- col LOGON_TIME       
spoo sesiones3.log
 select 
 INST_ID NODO
 ,LOGON_TIME
 ,OSUSER
 ,PROCESS
 ,SID
 ,SERIAL#
 ,username
 ,SUBSTR(STATUS,0,6) STATUS
 ,MACHINE            
 ,PROGRAM            
from gv$session
order by LOGON_TIME;
spoo off;

