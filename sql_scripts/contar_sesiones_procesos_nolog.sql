-- ===============================================================
-- NAME: contar_sesiones_procesos_nolog.sql
-- DESCRIPTION: Count user sesions
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
PROMPT DESGLOSE DE CONEXIONES DE USUARIO DE BBDD
PROMPT =========================================================================================
set lines 250
set pages 999
col username for a25
col Total for 999999
col MACHINE for a35
select username,count(username) Total from v$session where type != 'BACKGROUND' AND USERNAME NOT IN ('SYSRAC','DBSNMP','SYS','SYSTEM') group by username order by 2 desc;
PROMPT
PROMPT
PROMPT DESGLOSE DE CONEXIONES DE USUARIO DE S.O (los 10 usuarios con mas conexiones)
PROMPT =========================================================================================
select * from (select osuser,count(osuser) Total from v$session where type != 'BACKGROUND' AND USERNAME NOT IN ('SYSRAC','DBSNMP','SYS','SYSTEM') group by osuser order by 2 desc) where rownum < 11;
prompt
prompt
prompt
prompt DESGLOSE POR MAQUINAS CONECTADAS
PROMPT =========================================================================================
select machine,count(machine) total from v$session where type != 'BACKGROUND' AND USERNAME NOT IN ('SYSRAC','DBSNMP','SYS','SYSTEM') group by machine order by 2 desc;
prompt
prompt
PROMPT TOTAL SESIONES DE USUARIO
prompt =========================================================================================
select count(*) from v$session where type != 'BACKGROUND' AND USERNAME NOT IN ('SYSRAC','DBSNMP','SYS','SYSTEM');
PROMPT
prompt
prompt MOSTRANDO PROCESOS ACTUALES, ALCANZADOS DESDE EL ARRANQUE Y MAXIMOS PERMITIDOS
PROMPT
select * from v$resource_limit where resource_name = 'processes';
prompt
prompt
prompt 
prompt ========================================================================================


