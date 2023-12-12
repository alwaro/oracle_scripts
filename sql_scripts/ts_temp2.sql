select tablespace_name, file_name, autoextensible, bytes/1024/1024 as Mb, maxbytes/1024/1024 as Max_MB from dba_temp_files;
