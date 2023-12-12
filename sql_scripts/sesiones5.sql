-- ===============================================================
-- NAME: sesiones5.sql
-- DESCRIPTION: Generates a sentence that displays the info of the sessions where usernames are not null.
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
col PROCESS for a7
col MACHINE  for a25
col PROGRAM for a50
-- col LOGON_TIME       
col EVENT for a40
spoo sesiones5.log
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
where username is not null;
spoo off;

