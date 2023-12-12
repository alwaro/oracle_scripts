-- ===============================================================
-- NAME: datos_cliente.sql
-- DESCRIPTION: Displays info about the client session which executes the script
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 100
PROMPT _____________________________________________________
PROMPT SCRIPT PARA IDENTIFICAR DATOS DE LA SESION ACTUAL
PROMPT ______________________________________________________
PROMPT 
prompt
select 
    'SID...........: '||SYS_CONTEXT('USERENV','SID')||chr(10)||
    'INSTANCE_NAME.: '||SYS_CONTEXT('USERENV','INSTANCE_NAME')||chr(10)||
    'SESSION_USER..: '||SYS_CONTEXT('USERENV','SESSION_USER')||chr(10)||    
    'CURRENT_SCHEMA: '||SYS_CONTEXT('USERENV','CURRENT_USER')||chr(10)||
    'PROXY_USER....: '||SYS_CONTEXT('USERENV','PROXY_USER')||chr(10)||
    'OS_USER.......: '||SYS_CONTEXT('USERENV','OS_USER')||chr(10)||
    'MODULE........: '||SYS_CONTEXT('USERENV','MODULE')||chr(10)||
    'MAQUINA.......: '||SYS_CONTEXT('USERENV','HOST')||chr(10)||
    'IP_ADDRESS....: '||SYS_CONTEXT('USERENV','IP_ADDRESS')||chr(10)||
    'LANG..........: '||SYS_CONTEXT('USERENV','LANG')||chr(10)||
    'LANGUAGE......: '||SYS_CONTEXT('USERENV','LANGUAGE')||chr(10)||
    'NLS_DATE_FMT..: '||SYS_CONTEXT('USERENV','NLS_DATE_FORMAT')||chr(10)||
    'CDB_NAME......: '||SYS_CONTEXT('USERENV','CDB_NAME')||chr(10)||
    'CON_NAME......: '||SYS_CONTEXT('USERENV','CON_NAME')||chr(10)||
    'CON_ID........: '||SYS_CONTEXT('USERENV','CON_ID')||chr(10)||
    'CLI_IDENTIFIER: '||SYS_CONTEXT('USERENV','CLIENT_IDENTIFIER')||chr(10)||
    'CLIENT_INFO...: '||SYS_CONTEXT('USERENV','CLIENT_INFO')||chr(10)||
    'CLI_PROG_NAME.: '||SYS_CONTEXT('USERENV','CLIENT_PROGRAM_NAME')||chr(10)||
    'ORACLE_HOME...: '||SYS_CONTEXT('USERENV','ORACLE_HOME')
as DATOS_CONEXION_CLIENTE 
from dual;



