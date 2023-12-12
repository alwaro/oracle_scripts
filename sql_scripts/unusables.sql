-- ===============================================================
-- NAME: unusables.sql
-- DESCRIPTION: Displays info from the indexes that have the status unusable.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

select owner, index_name, table_owner, table_name,STATUS from dba_indexes where status = 'UNUSABLE';
