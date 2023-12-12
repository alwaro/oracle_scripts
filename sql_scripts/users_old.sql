-- ===============================================================
-- NAME: users_old.sql
-- DESCRIPTION: Displays the username, account_status and password_versions from all users.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

--set verify off
--DEF usuario='&1';
col username for a25
select username, account_status, password_versions from dba_users; 
-- where username like '%usuairo%';

