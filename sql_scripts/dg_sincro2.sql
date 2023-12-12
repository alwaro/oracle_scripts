-- ===============================================================
-- NAME: dg_sincro2.sql
-- DESCRIPTION: Displays DG advanced info
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 150;
set pages 999
select THREAD#, sequence#, applied, to_char(first_time,'dd/mm/yyyy hh24:mi:ss'),
to_char(next_time,'dd/mm/yyyy hh24:mi:ss'), archived, status
from v$archived_log order by sequence#;
