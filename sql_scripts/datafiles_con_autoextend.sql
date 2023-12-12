-- ===============================================================
-- NAME: datafiles_con_autoextend.sql
-- DESCRIPTION: Shows datafiles with autoextend
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select file_name from dba_data_files where autoextensible='YES';
