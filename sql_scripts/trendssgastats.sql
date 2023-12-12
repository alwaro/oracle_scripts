-- ===============================================================
-- NAME: trendssgastats.sql
-- DESCRIPTION: Displays a matrix of data for the entries in v$sgastat through the previous business day.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
REM  
REM   This script can be used at the end of a business day to see a matrix
REM   of data for the entries in v$sgastat through the previous business day.
REM   By default we look at hours 1-13 (6am through 6pm of AWR repository
REM   data from the previous day).   You can change the where clause information
REM   to look at whatever range of time you want to see, but peak activity times is
REM   best.
REM
REM    You can load this output in to Excel and create a line graph
REM     to see spikes of memory allocations or drops in free memory.
REM 

set lines 400
set pages 999
set termout off
set trimout on
set trimspool on
set feed off

col n format a30

spool trends.out
select n, 
   max(decode(to_char(begin_interval_time, 'hh24'), 1,bytes, null)) "1",
   max(decode(to_char(begin_interval_time, 'hh24'), 2,bytes, null)) "2",
   max(decode(to_char(begin_interval_time, 'hh24'), 3,bytes, null)) "3",
   max(decode(to_char(begin_interval_time, 'hh24'), 4,bytes, null)) "4",
   max(decode(to_char(begin_interval_time, 'hh24'), 5,bytes, null)) "5",
   max(decode(to_char(begin_interval_time, 'hh24'), 6,bytes, null)) "6",
   max(decode(to_char(begin_interval_time, 'hh24'), 7,bytes, null)) "7",
   max(decode(to_char(begin_interval_time, 'hh24'), 8,bytes, null)) "8",
   max(decode(to_char(begin_interval_time, 'hh24'), 9,bytes, null)) "9",
   max(decode(to_char(begin_interval_time, 'hh24'), 10,bytes, null)) "10",
   max(decode(to_char(begin_interval_time, 'hh24'), 11,bytes, null)) "11",
   max(decode(to_char(begin_interval_time, 'hh24'), 12,bytes, null)) "12",
   max(decode(to_char(begin_interval_time, 'hh24'), 13,bytes, null)) "13",
   max(decode(to_char(begin_interval_time, 'hh24'), 14,bytes, null)) "14",
   max(decode(to_char(begin_interval_time, 'hh24'), 15,bytes, null)) "15",
   max(decode(to_char(begin_interval_time, 'hh24'), 16,bytes, null)) "16",
   max(decode(to_char(begin_interval_time, 'hh24'), 17,bytes, null)) "17",
   max(decode(to_char(begin_interval_time, 'hh24'), 18,bytes, null)) "18",
   max(decode(to_char(begin_interval_time, 'hh24'), 19,bytes, null)) "19",
   max(decode(to_char(begin_interval_time, 'hh24'), 20,bytes, null)) "20",
   max(decode(to_char(begin_interval_time, 'hh24'), 21,bytes, null)) "21",
   max(decode(to_char(begin_interval_time, 'hh24'), 22,bytes, null)) "22",
   max(decode(to_char(begin_interval_time, 'hh24'), 23,bytes, null)) "23",
   max(decode(to_char(begin_interval_time, 'hh24'), 24,bytes, null)) "24"
from (select '"'||name||'"' n, begin_interval_time, bytes from dba_hist_sgastat a, dba_hist_snapshot b 
where pool='shared pool' and a.snap_id=b.snap_id
and to_char(begin_interval_time,'hh24:mi') between '01:00' and '24:00'
and to_char(begin_interval_time,'dd-mon')  = to_char(sysdate-1, 'dd-mon'))
group by n;
spool off

clear col
set termout on
set trimout off
set trimspool off
set feed on

/*  ------------------------------------------

Sample Output

"ASH buffers"                     4194304    4194304    4194304    4194304    4194304    4194304    4194304    4194304  ...
"PL/SQL MPCODE"         3618268    3618268    3618268    3618268    3618268    3618268    3618268    3618268  
"Heap0: KGL"                    1359516    1386948    1386948    1386948    1386948    1392216    1392216    1392216 
"KQR M PO"                      3138300    3148028    3148028    3148028    3148028    3148540    3148540    3148540 
"KTI-UNDO"                       1235304    1235304    1235304    1235304    1235304    1235304    1235304    1235304 
"PCursor"                           2501692    2524836    2524836    2528000    2528000    2533268    2533268    2533268
.
.
.

*/