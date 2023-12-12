-- ===============================================================
-- NAME: suma_datafiles.sql
-- DESCRIPTION: Displays a sum of the space used by the datafiles.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select sum(bytes)/1024/1024/1024 as GB from dba_data_files;

