-- ===============================================================
-- NAME: sesiones_de_usuario.sql
-- DESCRIPTION: Displays the username from the sessions that are not part of the system.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select username from v$session where type != 'BACKGROUND' AND USERNAME NOT IN ('SYSRAC','DBSNMP','SYS','SYSTEM');
