-- ===============================================================
-- NAME: sesiones_larga_conexion.sql
-- DESCRIPTION: Displays the info about the user sessions with more than 2 days of life.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set feedback off;
set heading off;
set lines 190
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
set echo off;  
spoo sesiones_antiguas.log
PROMPT ===============================================================================================
prompt  LISTANDO SESIONES DE USUARIO CON MAS DE 2 DIAS DE VIDA
PROMPT ===============================================================================================
prompt
SELECT  
    'LOGON TIME...............: '||logon_time||chr(10)||
    'INSTANCIA................: '||inst_id||chr(10)||
    'SID......................: '||SID||chr(10)||
    'serial#..................: '||serial#||chr(10)||
    'USUARIO EN DB............: '||username||chr(10)||
    'USUARIO EN SO............: '||osuser||chr(10)||
    'MAQUINA..................: '||machine||chr(10)||
    'PROGRAMA.................: '||PROGRAM||chr(10)||
    'EVENTO...................: '||EVENT||chr(10)||
    'SQL_ID...................: '||SQL_ID||chr(10)||
    'MINUTOS ULTIMA EJEC......: '||trunc(last_call_et/60,2)||chr(10)||
    'WAIT_CLASS...............: '||WAIT_CLASS||chr(10)||
    'WAIT_TIME................: '||WAIT_TIME||chr(10)||
    'MIN EN ESPERA............: '||trunc(SECONDS_IN_WAIT/60,2)||chr(10)||
    'ESTADO...................: '||STATE||chr(10)||
    '___________________________________________________________'
FROM GV$SESSION
WHERE
    LOGON_TIME < SYSDATE-2
AND
	USERNAME NOT IN ('PROGG','PREGG','DESGG','SYSTEM', 'SYS', 'SYSBACKUP', 'SYSRAC', 'OJVMSYS', 'SYSKM', 'OUTLN', 'SYS$UMF', 'SYSDG', 'APPQOSSYS', 'DBSFWUSER', 'FLOWS_FILES', 'GGSYS', 'CTXSYS', 'APEX_030200', 'SI_INFORMTN_SCHEMA', 'OWBSYS', 'OWBSS_AUDIT', 'ORDPLUGINS', 'GSMADMIN_INTERNAL', 'APEX_050000', 'MDSYS', 'OLAPSYS', 'ORDDATA', 'XDB', 'WMSYS', 'ORDSYS', 'DBSNMP', 'XS$NULL', 'AUDSYS', 'DIP', 'ORACLE_OCM')
order by 1;
spoo off;
set feedback on;
set heading on;
set echo on;

