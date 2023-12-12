-- ===============================================================
-- NAME: fecha.sql
-- DESCRIPTION: Modify session date format
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
select sysdate from dual;

