-- ===============================================================
-- NAME: getsql_sqlid.sql
-- DESCRIPTION: Displays tunning info from an sqlid
-- USAGE: Ask for sqlid
-- AUTHOR:
-- ---------------------------------------------------------------
col sql_fulltext for a60 wrap
set verify off
set pagesize 999
set lines 155
col username format a13
col prog format a22
col sid format 999
col child_number format 99999 heading CHILD
col ocategory format a10
col avg_etime format 9,999,999.99
col avg_pio format 9,999,999.99
col avg_lio format 999,999,999
col etime format 9,999,999.99
set long 100000000

select sql_id, child_number, plan_hash_value plan_hash, executions execs, 
(elapsed_time/1000000)/decode(nvl(executions,0),0,1,executions) avg_etime, 
buffer_gets/decode(nvl(executions,0),0,1,executions) avg_lio,
sql_fulltext
from v$sql s
where sql_id like nvl('&sql_id',sql_id)
order by 1, 2, 3
/
