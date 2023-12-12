-- ===============================================================
-- NAME: contar_sesiones_usuario.sql
-- DESCRIPTION: Count every user sesion not in background
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
PROMPT DESGLOSE DE CONEXIONES DE USUARIO
PROMPT =========================================================================================
set lines 250
set pages 999
col username for a25
col Total for 999999
select username,count(username) Total from v$session where type != 'BACKGROUND' AND USERNAME NOT IN ('SYSRAC','DBSNMP','SYS','SYSTEM') group by username order by 2 desc;
PROMPT
PROMPT
PROMPT TOTAL SESIONES DE USUARIO
prompt =========================================================================================
select count(*) from v$session where type != 'BACKGROUND' AND USERNAME NOT IN ('SYSRAC','DBSNMP','SYS','SYSTEM');
PROMPT

