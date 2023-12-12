-- ===============================================================
-- NAME: discos.sql
-- DESCRIPTION: Displays asm disck info
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select name, path, mode_status, state, disk_number, total_mb, free_mb from v$asm_disk order by 1;

