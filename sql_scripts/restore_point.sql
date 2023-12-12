-- ===============================================================
-- NAME: restore_point.sql
-- DESCRIPTION: Displays info of the restore point
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 250
col name format a35
select NAME, STORAGE_SIZE/1024/1024/1024 Gb from V$RESTORE_POINT;


