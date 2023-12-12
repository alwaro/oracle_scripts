-- ===============================================================
-- NAME: ts_free.sql
-- DESCRIPTION: After writing a tablespace name it gives you how much space it occupies and the free amount of MB you can add
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 132
set pages 100 verify off
clear break 
clear compute
ttitle center 'Space Usage on Tablespaces' skip 1 center '*****************************************' skip 2
accept tablespace_name char prompt 'Enter Tablespace Name :'
select a.TABLESPACE_NAME,
       round(a.bytes_used/(1024*1024),2) TOTAL_SPACE_IN_MB,
       round(b.bytes_free/(1024*1024),2) FREE_SPACE_IN_MB,
       round(b.smallest/(1024*1024),2) min_size_in_MB,
       round(b.largest/(1024*1024),2) max_size_in_MB,
       round(((a.bytes_used-b.bytes_free)/a.bytes_used)*100,2) percent_used
  from
  (
  select TABLESPACE_NAME, sum(bytes) bytes_used
    from dba_data_files
   group by TABLESPACE_NAME
  ) a,
  (
  select TABLESPACE_NAME, sum(BYTES) bytes_free, min(BYTES) smallest, max(BYTES) largest
    from dba_free_space
   group by TABLESPACE_NAME
  ) b
 where a.TABLESPACE_NAME=b.TABLESPACE_NAME(+)
   and a.tablespace_name = decode('&tablespace_name',null,a.tablespace_name,'&tablespace_name')
 order by ((a.BYTES_used-b.BYTES_free)/a.BYTES_used) desc;


