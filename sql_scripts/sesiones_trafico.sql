-- ===============================================================
-- NAME: sesiones_trafico.sql
-- DESCRIPTION: Displays info about the schema trafico
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set pages 50
set lines 250
col NODO for 999
col SID for 99999
col SERIAL# for 9999999
col USERNAME for a25
col STATUS for a6
col OSUSER for a25
col PROCESS for a15
col MACHINE  for a25
col PROGRAM for a50
-- col LOGON_TIME       
col EVENT for a40
spoo sesiones6.log
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
 ,EVENT  
from gv$session
where username='TRAFICO'
and program!='menu.exe';
spoo off;

