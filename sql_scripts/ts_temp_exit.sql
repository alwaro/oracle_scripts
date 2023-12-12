-- ===============================================================
-- NAME: ts_temp_exit.sql
-- DESCRIPTION: Displays the tablespace name, id, extends and bytes from the temporal extent pool.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select tablespace_name,
       file_id,
       extents_cached extents_allocated,
       extents_used,
       bytes_cached/1024/1024 mb_allocated,
       bytes_used/1024/1024 mb_used
from v$temp_extent_pool
/
exit;

