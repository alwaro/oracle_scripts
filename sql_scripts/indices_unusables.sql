-- ===============================================================
-- NAME: indices_unusables.sql
-- DESCRIPTION: Displays index with unsuable status
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col index_name for a30
select OWNER,INDEX_NAME,TABLE_OWNER,TABLE_NAME,STATUS from dba_indexes where status='UNUSABLE';

