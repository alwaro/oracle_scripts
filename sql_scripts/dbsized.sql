-- ===============================================================
-- NAME: dbsized.sql
-- DESCRIPTION: Show database size from datafiles
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
 select sum(bytes)/1024/1024/1024 GB from dba_data_files
/
