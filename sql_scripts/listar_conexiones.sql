-- ===============================================================
-- NAME: contar_sesiones_conexiones_procesos.sql
-- DESCRIPTION: Count user sesions
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
spool resultado_procesos_conexiones.log
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
spoo off;
prompt
prompt
prompt =========================================================================================
prompt    ESTE BLOQUE SOLO ES VALIDO CUANDO INVOCAMOS ESTE SCRIPT TRAS LA ALARMAS DEL TRIGGER
prompt         si lo invocamos porque una bbdd ha llegado al max de procesos sin que
prompt        haya sido el trigger quien impide mas conexiones, se ignora este bloque
prompt
prompt SI SE HAN PRODUCIDO BLOQUEOS DE CONEXION POR EL TRIGGER, LOS DATOS DE LAS SESIONES A LAS
prompt QUE SE LES HA IMPEDIDO CONECTAR ESTA EN LA SIGUIENTE TABLA:
prompt
prompt TABLA.......: SYSTEM.CONEXIONES_FALLIDAS
prompt
prompt Por ejemplo:
prompt          SELECT * FROM SYSTEM.CONEXIONES_FALLIDAS WHERE FECHA > SYSDATE -2;
prompt 
prompt ========================================================================================


