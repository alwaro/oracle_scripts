-- ===============================================================
-- NAME: datafiles_size.sql
-- DESCRIPTION: Shows datafiles size
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select name from v$database;
select sum(bytes)/1024/1024/1024 Gb from dba_data_files;

