-- ===============================================================
-- NAME: dbsizes.sql
-- DESCRIPTION: Show database size frm segments
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select sum(bytes)/1024/1024/1024 GB from dba_segments
/
