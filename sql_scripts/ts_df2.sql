-- ===============================================================
-- NAME: ts_df.sql
-- DESCRIPTION: Displays the information about tablespaces name, file name, if it's autoextensible, how much space it occupies and how much it's free
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set line 1000
set pages 5000
col bigfile for a4
col tablespace_name for a30
col file_name for a80
col free_space for 9999999
compute sum of total_space on report
compute sum of free_space on report
compute sum of MAX_SPACE on report
break on tablespace_name on report nodup

select c.tablespace_name,a.autoextensible,a.file_name,a.total_space,b.free_space, round(b.free_space/a.total_space *100,2) "Free%",a.max_space_GB from (select file_id,file_name,sum(bytes)/1024/1024 total_space,sum(MAXBYTES)/1024/1024/1024 max_space_GB,autoextensible from dba_data_files group by file_id,file_name,autoextensible) a,(select file_id,nvl(sum(bytes)/1024/1024,0) free_space from dba_free_space group by file_id) b, (select tablespace_name,file_id from dba_data_files) c where a.file_id=b.file_id(+) and a.file_id=c.file_id order by tablespace_name;

