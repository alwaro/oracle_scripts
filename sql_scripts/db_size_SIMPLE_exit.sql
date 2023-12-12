-- ===============================================================
-- NAME: db_size_SIMPLE_exit.sql
-- DESCRIPTION: Show database size from datafiles and segments
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
prompt 
SET FEEDBACK OFF
PROMPT
prompt "SIZE TOTAL SUMANDO DATAFILES, TEMPFILES, REDOLOGS Y CONTROLFILES"
select
( select sum(bytes)/1024/1024/1024 data_size from dba_data_files ) +
( select nvl(sum(bytes),0)/1024/1024/1024 temp_size from dba_temp_files ) +
( select sum(bytes)/1024/1024/1024 redo_size from sys.v_$log ) +
( select sum(BLOCK_SIZE*FILE_SIZE_BLKS)/1024/1024/1024 controlfile_size from v$controlfile) "TOTAL GB"
from
dual;
select sum(bytes)/1024/1024/1024 as "Suma de Datafiles en Gb" from dba_data_files;
select sum(bytes)/1024/1024/1024 as "Suma de datos usados en Gb" from dba_segments;
set feedback on;
exit;

