-- ===============================================================
-- NAME: mi_sid.sql
-- DESCRIPTION: Displays the SID of the actual session.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 100
PROMPT _____________________________________________________
PROMPT SCRIPT PARA IDENTIFICAR EL SID DE LA SESION ACTUAL
PROMPT ______________________________________________________
PROMPT 
PROMPT Estas con el usuario:
show user;
PROMPT
PROMPT
PROMPT A continuacion se muestra el SID mediante 2 metodos distintos
prompt por si hubiera algun problema con alguno de ellos
prompt
PROMPT
prompt Obtenido a traves del entorno:
PROMPT
select sys_context('USERENV','SID') from dual;
prompt
prompt Obtenido a traves de la vista V$mystat:
PROMPT
select distinct sid from v$mystat;
prompt
prompt


