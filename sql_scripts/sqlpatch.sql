-- ===============================================================
-- NAME: sqlpatch.sql
-- DESCRIPTION: Displays info about the PATCH.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col patch_id for 999999999999
col status for a14
col DESCRIPTION for a86
col ACTION_TIME for a30
select PATCH_ID,PATCH_TYPE,ACTION,STATUS,ACTION_TIME,DESCRIPTION,SOURCE_VERSION,TARGET_VERSION from dba_registry_sqlpatch;

