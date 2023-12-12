-- ===============================================================
-- NAME: flashbck_contenido.sql
-- DESCRIPTION: Displays flashback size
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SET PAGESIZE 60
SET LINESIZE 300
SELECT 
     estimated_flashback_size/1024/1024/1024 "EST_FLASHBACK_SIZE(GB)" 
FROM 
     v$flashback_database_log;

