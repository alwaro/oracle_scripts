-- ===============================================================
-- NAME: dbsized.sql
-- DESCRIPTION: Show database size from datafiles tempfiles redo and controlfiles
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col DATABASE_NAME FOR A35
prompt 
prompt Size de database (datafiles, tempfiles, controlfiles y redo)
PROMPT =================================================================
SET FEEDBACK OFF
SELECT DATABASE_NAME FROM V$DATABASE;
SET FEEDBACK ON;
PROMPT
select
( select sum(bytes)/1024/1024/1024 data_size from dba_data_files ) +
( select nvl(sum(bytes),0)/1024/1024/1024 temp_size from dba_temp_files ) +
( select sum(bytes)/1024/1024/1024 redo_size from sys.v_$log ) +
( select sum(BLOCK_SIZE*FILE_SIZE_BLKS)/1024/1024/1024 controlfile_size from v$controlfile) "Size in GB"
from
dual;

