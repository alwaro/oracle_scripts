-- ===============================================================
-- NAME: poner_autoextend_a_todo.sql
-- DESCRIPTION: Configures unlimited autoextend on all datafiles.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
-- SCRIPT PARA CONFIGURAR AUTOEXTEND ILIMITADO A TODOS LOS DATAFILES
set lines 300;
set heading off;
set feedback off;
spool autoextend_to_all.sql
select
	'alter database datafile '''||
	file_name||
	''' '||
	' autoextend on next 10M maxsize unlimited;'
from
   dba_data_files;
spoo off;
prompt ==============================================================
prompt Para aplicar los autoextend debe ejecutarse a mano el script:
prompt autoextend_to_all.sql
prompt
prompt ==============================================================
set heading on;
set feedback on;


