-- ===============================================================
-- NAME: total_memoria_usada.sql
-- DESCRIPTION: Displays the SGA usage and how much it's free 
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select sum(bytes)/1024/1024 " SGA size used in MB" from v$sgastat where name!='free memory';

