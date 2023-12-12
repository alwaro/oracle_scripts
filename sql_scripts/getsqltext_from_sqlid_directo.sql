col sql_fulltext for a90 wrap
set verify off
set pagesize 999
set lines 155
set long 100000000
set verify off
set heading off;
DEF sql_id='&1';
select sql_fulltext
from v$sql s
where sql_id like nvl('&sql_id',sql_id)
/
