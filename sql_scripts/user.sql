-- ===============================================================
-- NAME: user.sql
-- DESCRIPTION: Displays info about a specific user.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set verify off
DEF usuario='&1';
col username for a25
select username, account_status, password_versions from dba_users where username like '%usuairo%';

