-- ===============================================================
-- NAME: generar_sentencias_autoextend.sql
-- DESCRIPTION: Generates queries to activate autoextend
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SET   FEEDBACK OFF 
Set VERIFY OFF 
Set HEADING OFF 
Set ECHO OFF;
Spoo lista_tablesapces.log
select 'alter database datafile ''' ||  file_name ||    ''' ' || ' autoextend ON NEXT 200M maxsize unlimited;' FROM dba_data_files where tablespace_name in ('SYSAUX','SYSTEM','UNDOTBS1','UNDOTBS2','UNDO1','UNDO2');
select 'alter database tempfile ''' ||  file_name ||    ''' ' || ' autoextend ON NEXT 200M maxsize unlimited;' FROM dba_temp_files;
spoo off;
SET   FEEDBACK ON 
Set VERIFY ON 
Set HEADING ON 
Set ECHO ON;

