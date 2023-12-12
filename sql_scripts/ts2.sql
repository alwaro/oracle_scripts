-- ===============================================================
-- NAME: ts.sql
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
col Num_Segs        Heading 'Num Segs'
col Num_Exts        Heading 'Num Exts'


select c.tablespace_name,
       round(a.bytes/1048576) Megs_Alloc,
       round(b.bytes/1048576) Megs_Free,
       round((a.bytes-b.bytes)/1048576) Megs_Used,
       round(b.bytes/a.bytes * 100) Pct_Free,
       round((a.bytes-b.bytes)/a.bytes * 100) Pct_Used,
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

spoo off;

