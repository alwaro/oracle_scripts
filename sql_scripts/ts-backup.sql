-- ===============================================================
-- NAME: ts-backuo.sql
-- DESCRIPTION: Displays the basic information about a tablespace like it's name and the space it occupies
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set echo off
set feedback off
set verify off
set linesize 512

set term off
COLUMN block_size NOPRINT new_value block_size
SELECT value block_size from v$parameter
 where name='db_block_size';
set term on
spoo ts.log
prompt
prompt Tablespace Basic Information
prompt

col Tablespace_name Heading 'Tablespace'
col Megs_Alloc      Heading 'Megs Alloc'
col Megs_Free       Heading 'Megs Free'
col Megs_Used       Heading 'Megs Used'
col Pct_Free        Heading 'Pct Free'
col Pct_Used        Heading 'Pct Used'
col Init_Ext        Heading 'Init Ext'
col Next_Ext        Heading 'Next Ext'
col Min_Ext         Heading 'Min Ext'
col Max_Ext         Heading 'Max Ext'
col Num_Segs        Heading 'Num Segs'
col Num_Exts        Heading 'Num Exts'


select c.tablespace_name,
       round(a.bytes/1048576) Megs_Alloc,
       round(b.bytes/1048576) Megs_Free,
       round((a.bytes-b.bytes)/1048576) Megs_Used,
       round(b.bytes/a.bytes * 100) Pct_Free,
       round((a.bytes-b.bytes)/a.bytes * 100) Pct_Used,
       round(c.initial_extent/1048576) Init_Ext,
       round(c.next_extent/1048576) Next_Ext,
       round(a.minbytes/1048576) Min_Ext,
       round(a.maxbytes/1048576) Max_Ext,
       nvl(d.num_segs,0) Num_segs,
       nvl(d.num_exts,0) Num_Exts
from (select tablespace_name,
             sum(a.bytes) bytes,
             min(a.bytes) minbytes,
             max(a.bytes) maxbytes
      from sys.dba_data_files a
      group by tablespace_name) a,
     (select a.tablespace_name,
             nvl(sum(b.bytes),0) bytes
      from sys.dba_data_files a,
           sys.dba_free_space b
      where a.tablespace_name = b.tablespace_name (+)
        and a.file_id         = b.file_id (+)
      group by a.tablespace_name) b,
      sys.dba_tablespaces c,
      (select tablespace_name, 
              count(distinct segment_name) num_segs,
              count(extent_id) num_exts
       from sys.dba_extents
       group by tablespace_name) d
where a.tablespace_name = b.tablespace_name(+)
  and a.tablespace_name = c.tablespace_name
  and a.tablespace_name = d.tablespace_name(+)
order by c.tablespace_name;

prompt
prompt Tablspace Free Space Breakdown
prompt

col tablespace_name Heading 'Tablespace Name'
col over_100m       Heading '# > 100M'
col over_25m        Heading '# > 25M'
col over_10m        Heading '# > 10M'
col over_5m         Heading '# > 5M'
col over_1m         Heading '# > 1M'
col over_512k       Heading '# > 512K'
col under_512k      Heading '# <= 512K'

select tablespace_name,
       sum(decode(sign(bytes-1024*1024*100),-1,0,1)) over_100m,
       (sum(decode(sign(bytes-1024*1024*025),-1,0,1)) -
            sum(decode(sign(bytes-1024*1024*100),-1,0,1))) over_25m,
       (sum(decode(sign(bytes-1024*1024*010),-1,0,1)) -
            sum(decode(sign(bytes-1024*1024*25),-1,0,1))) over_10m,
       (sum(decode(sign(bytes-1024*1024*005),-1,0,1)) -
            sum(decode(sign(bytes-1024*1024*10),-1,0,1))) over_5m,
       (sum(decode(sign(bytes-1024*1024*001),-1,0,1)) -
            sum(decode(sign(bytes-1024*1024*5),-1,0,1))) over_1m,
       (sum(decode(sign(bytes-1024*512*001),-1,0,1)) -
            sum(decode(sign(bytes-1024*1024*1),-1,0,1))) over_512k,
      sum(decode(sign(bytes-1024*512*001),-1,1,0)) under_512k
from dba_free_space
group by tablespace_name;
spoo off;

