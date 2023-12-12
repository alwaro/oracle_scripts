-- ===============================================================
-- NAME: cache_buffer_chains.sql
-- DESCRIPTION:
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select
   count(*)    child_count,
   sum(gets)   sum_gets,
   sum(misses) sum_misses,
   sum(sleeps) sum_sleeps
from
   v$latch_children
where
   name = 'cache buffers chains';

