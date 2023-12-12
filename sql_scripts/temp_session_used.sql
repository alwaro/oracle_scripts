-- ===============================================================
-- NAME: temp_session_used.sql
-- DESCRIPTION: Displays info about the sessions and the SQL they used 
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT a.username, a.SID, a.serial#, a.osuser, b.TABLESPACE, b.blocks*8/1024 "Size used in MB",
c.sql_text
FROM v$session a, v$tempseg_usage b, v$sqlarea c
WHERE a.saddr = b.session_addr
AND c.address = a.sql_address
AND c.hash_value = a.sql_hash_value
ORDER BY b.TABLESPACE, b.blocks;

