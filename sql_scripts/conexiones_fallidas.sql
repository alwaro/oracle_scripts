-- ===============================================================
-- NAME: conexiones_fallidas.sql
-- DESCRIPTION: Shows statistics for objects
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
SET LINES 200
SET PAGES 50
col USUARIO for a30
col OSUSER  for a35
col HOST    for a30
col MODULO  for a40
select * from SYSTEM.CONEXIONES_FALLIDAS;
