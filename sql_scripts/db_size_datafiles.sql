
-- ===============================================================
-- NAME: dbsized.sql
-- DESCRIPTION: Show database size from datafiles and tempfiles
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col DATABASE_NAME FOR A35
prompt 
prompt Size de database datafiles
PROMPT =================================================================
SET FEEDBACK OFF
SELECT DATABASE_NAME FROM V$DATABASE;
SET FEEDBACK ON;
PROMPT
select
( select sum(bytes)/1024/1024/1024 data_size from dba_data_files ) +
( select nvl(sum(bytes),0)/1024/1024/1024 temp_size from dba_temp_files ) "Size in GB"
from
dual;

