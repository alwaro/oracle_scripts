-- ===============================================================
-- NAME: queries_pesadas.sql
-- DESCRIPTION: Query with heavy data search
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
spoo queries_pesadas.log
SELECT 
    Q.ADDRESS
    ,Q.SQL_TEXT
    ,Q.SQL_ID
    ,Q.EXECUTIONS
    ,Q.DISK_READS
    ,Q.BUFFER_GETS
    ,Q.APPLICATION_WAIT_TIME
    ,Q.COMMAND_TYPE
    ,Q.PARSING_SCHEMA_NAME
    ,Q.SERVICE
    ,Q.CPU_TIME
    ,Q.ELAPSED_TIME
    ,Q.PHYSICAL_READ_BYTES
    ,S.SID
    ,S.SERIAL#
    ,S.USERNAME
    ,S.OSUSER
    ,S.PROCESS
    ,S.MACHINE
    ,S.PROGRAM
    ,S.MODULE
    ,S.EVENT
    ,S.SQL_EXEC_START
    ,S.LOGON_TIME
from 
    V$SQL Q, 
    V$SESSION S 
WHERE 
    Q.ADDRESS = S.SQL_ADDRESS
    -- AND Q.PARSING_SCHEMA_NAME = 'SYS'
    -- AND Q.PARSING_SCHEMA_NAME = 'TRAFICO'
    -- AND Q.SQL_TEXT = 'select * from system.datos_brutos'    	
    -- AND S.MACHINE LIKE ('CTX%')
    -- AND S.PROGRAM IN ('SQL Developer','XXXXXXXX','YYYYYYYY')
    -- AND S.PROGRAM='SQL Developer'
    -- AND S.PROGRAM NOT IN ('menu.exe','MCGateway.exe')
    ORDER BY S.LOGON_TIME;
spoo off;

