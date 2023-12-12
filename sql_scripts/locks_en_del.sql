prompt 
prompt LISTANDO TODAS LAS SESIONES QUE TIENEN UN BLOQUEO SOBRE LA TABLA DEL (Ojo, que puede haber bloqueos normales)
prompt ==============================================================================================================
set lines 250
select l.* from v$locked_object l, dba_objects o
where l.object_id = o.object_id
and o.object_type = 'TABLE'
and o.owner = 'TRAFICO'
and o.object_name = 'DEL';
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
prompt 
prompt LISTANDO INFO EXTENDIDA DE LAS SESIONES CON BLOQUEO SOBRE LA TABLA DEL
PROMPT ==========================================================================
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
col PROGRAM for a50
-- col LOGON_TIME
col EVENT for a40
spoo sesiones3.log
 select
-- INST_ID NODO
 LOGON_TIME
 ,OSUSER
 ,PROCESS
 ,SID
 ,SERIAL#
 ,username
 ,SUBSTR(STATUS,0,6) STATUS
 ,MACHINE
 ,PROGRAM
 ,EVENT
from v$session
WHERE SID IN (select L.SESSION_ID
from v$locked_object l, dba_objects o
where l.object_id = o.object_id
and o.object_type = 'TABLE'
and o.owner = 'TRAFICO'
and o.object_name = 'DEL');
spoo off;

