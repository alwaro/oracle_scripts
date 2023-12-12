-- ===============================================================
-- NAME: dbw_use.sql
-- DESCRIPTION: Shows database event stats
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
rem dbwr_stat.sql
rem Mike Ault - 11/09/01 Created
rem
col name format a46 heading 'DBWR Statistic'
col value format 9999999999999 heading 'Statistic Value'
set pages 999
rem title 80 'DBWR Statistic Report'
spool dbwr_stat
select a.name,a.value 
from  (select name, value from v$sysstat 
       where name not like '%redo%' and name not like '%remote%') a
where (a.name like 'DBWR%' or a.name like '%buffer%' 
       or a.name like '%write%' or a.name like '%summed%')
union
select class name, count value from v$waitstat 
where class='data block' 
union 
select name||' '||to_char(block_size/1024)||'K hit ratio', 
  round(((1 - (physical_reads / (db_block_gets + consistent_gets))) * 100),3)
value
from V$buffer_pool_statistics
union 
select name||' '||to_char(block_size/1024)||'K free buffer wait',free_buffer_wait
value
from V$buffer_pool_statistics
union
select name||' '||to_char(block_size/1024)||'K buffer busy wait',buffer_busy_wait
value
from V$buffer_pool_statistics
union
select name||' '||to_char(block_size/1024)||'K write complete
wait',write_complete_wait value 
from V$buffer_pool_statistics
/
spool off
set pages 22
ttitle off

