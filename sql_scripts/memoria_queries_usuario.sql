-- ===============================================================
-- NAME: memoria_queries_usuario.sql
-- DESCRIPTION: Displays the memory used by the querys of the users.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
COLUMN sql_text      FORMAT a40   HEADING Text word_wrapped
COLUMN sharable_mem               HEADING Shared|Bytes
COLUMN persistent_mem             HEADING Persistent|Bytes
COLUMN parse_calls                HEADING Parses
COLUMN users         FORMAT a15   HEADING "User"
COLUMN executions                 HEADING "Executions"
Ttitle left _date center 'SQL Area Memory Use' skip 2
SET LONG 1000 PAGES 59 LINES 132 ECHO OFF
BREAK ON users
COMPUTE SUM OF sharable_mem ON users
COMPUTE SUM OF persistent_mem ON users
COMPUTE SUM OF runtime_mem ON users
SELECT   username users, sql_text, executions, parse_calls, sharable_mem,
         persistent_mem
    FROM sys.v_$sqlarea a, dba_users b
   WHERE a.parsing_user_id = b.user_id
     AND b.username LIKE UPPER ('%&user_name%')
ORDER BY 1;
