-- ===============================================================
-- NAME: ts_size.sql
-- DESCRIPTION: After writing a tablespace displays a queery that lets you select the tablespace name and bytes as GB of the given tablespace
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select tablespace_name, sum(bytes)/1024/1024/1024 as Gb from dba_data_files where tablespace_name like '%&NOMBRE_DEL_TS%' group by tablespace_name, bytes;
undef NOMBRE_DEL_TS;

