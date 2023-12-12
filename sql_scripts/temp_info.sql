-- ===============================================================
-- NAME: temp_info.sql
-- DESCRIPTION: Displays info about the active sessions of app/users 
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select b.Total_MB,
       b.Total_MB - round(a.used_blocks*8/1024) Current_Free_MB,
       round(used_blocks*8/1024)                Current_Used_MB,
      round(max_used_blocks*8/1024)             Max_used_MB
from v$sort_segment a,
 (select round(sum(bytes)/1024/1024) Total_MB from dba_temp_files ) b;


col hash_value for a40
col tablespace for a10
col username for a20
SELECT s.sid, s.username, u.tablespace, s.sql_hash_value||'/'||u.sqlhash hash_value, u.segtype, u.contents, u.blocks
FROM v$session s, v$tempseg_usage u
WHERE s.saddr=u.session_addr
order by u.blocks;

@$DBA/temp_use.sql

@$DBA/sesiones2.sql

