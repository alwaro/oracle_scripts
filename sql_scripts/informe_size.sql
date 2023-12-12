-- ===============================================================
-- NAME: informe_size.sql
-- DESCRIPTION: Generate a size report
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
@$DBA/f
prompt
prompt ===============================================================================================
prompt                        USO POR TABLESPACE DE CADA ESQUEMA
prompt ===============================================================================================
clear breaks
clear computes
set linesize 300
set pagesize 100
set feedback off
select a.owner username, a.tablespace_name, round(b.total_space/1024/1024/1024,2) "Total (GB)", round(sum(a.bytes)/1024/1024/1024,2) "Used (GB)"
from dba_segments a, (select tablespace_name, sum(bytes) total_space
                      from dba_data_files
                      group by tablespace_name) b
where a.tablespace_name not in ('UNDOTBS1', 'UNDOTBS2')
and a.tablespace_name = b.tablespace_name
group by a.owner,a.tablespace_name, b.total_space/1024/1024/1024
order by a.owner,a.tablespace_name;
--group by a.tablespace_name, a.owner, b.total_space/1024/1024/1024
--order by a.tablespace_name, a.owner;
prompt
prompt
prompt
prompt ===============================================================================================
prompt                       GIGABYTES POR ESQUEMA Y SIZE TOTAL DE SEGMENTOS
prompt ===============================================================================================
set linesize 150
set pagesize 5000
col owner for a25
col segment_name for a30
col segment_type for a20
col TABLESPACE_NAME for a30
clear breaks
clear computes
compute sum label "TOTAL SEGMENTOS" of SIZE_IN_GB on report
break on report
select OWNER,sum(bytes)/1024/1024/1000 "SIZE_IN_GB" from dba_segments group by owner order by SIZE_IN_GB DESC;
prompt
prompt
prompt
prompt ===============================================================================================
prompt         TOTAL SIZE DE CADA TABLESPACE (SUMANDO FICHEROS) Y SIZE TOTAL DE DATAFILES
prompt ===============================================================================================
set linesize 150
set pagesize 5000
col owner for a25
col segment_name for a30
col segment_type for a20
col TABLESPACE_NAME for a30
clear breaks
clear computes
compute sum label "TOTAL DATAFILES" of SIZE_IN_GB on report
break on report
select tablespace_name,sum(bytes)/1024/1024/1000 "SIZE_IN_GB" from dba_data_files group by tablespace_name order by SIZE_IN_GB DESC;
prompt
prompt
clear breaks
clear computes
set feedback on

