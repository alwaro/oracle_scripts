-- ===============================================================
-- NAME: informe_size-historif2.sql
-- DESCRIPTION: Generate historificacion report
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------@$DBA/f
prompt
spoo informe_size_historif.log
prompt ===============================================================================================
prompt                        USO POR TABLESPACE DE CADA ESQUEMA
prompt ===============================================================================================
clear breaks
clear computes
set linesize 300
set pagesize 100
set feedback off
select a.owner username, a.tablespace_name, round(b.total_space/1024/1024,2) "Total (GB)", round(sum(a.bytes)/1024/1024,2) "Used (GB)"
from dba_segments a, (select tablespace_name, sum(bytes) total_space
                      from dba_data_files
                      group by tablespace_name) b
where a.tablespace_name not in ('UNDOTBS1', 'UNDOTBS2')
and a.tablespace_name = b.tablespace_name
group by a.owner,a.tablespace_name, b.total_space/1024/1024
order by a.owner,a.tablespace_name;
--group by a.tablespace_name, a.owner, b.total_space/1024/1024
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
select OWNER,sum(bytes)/1024/1024 "SIZE_IN_GB" from dba_segments group by owner order by SIZE_IN_GB DESC;
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
select tablespace_name,sum(bytes)/1024/1024/1024 "SIZE_IN_GB" from dba_data_files group by tablespace_name order by SIZE_IN_GB DESC;
prompt
prompt
clear breaks
clear computes
set feedback on
prompt
prompt
prompt
prompt ===============================================================================================
prompt         SUMAS DE SEGMENTOS INDIVIDUALES DE TRAFICO Y MOVILIDAD (NO PARTICIONADOS)
prompt ===============================================================================================
PROMPT
PROMPT
select sum(bytes)/1024/1024/1024 as "SIZE TABLAS TRAFICO EN GB" from dba_segments where segment_type='TABLE' AND owner='TRAFICO';
PROMPT
select sum(bytes)/1024/1024/1024 as "SIZE INDICES TRAFICO EN GB" from dba_segments where segment_type='INDEX' AND owner='TRAFICO';
PROMPT
PROMPT
select sum(bytes)/1024/1024/1024 as "SIZE TABLAS MOVILIDAD EN GB" from dba_segments where segment_type='TABLE' AND owner='MOVILIDAD';
PROMPT
select sum(bytes)/1024/1024/1024 as "SIZE INDICES MOVILIDAD EN GB" from dba_segments where segment_type='INDEX' AND owner='MOVILIDAD';
PROMPT
PROMPT
prompt ===============================================================================================
prompt         SUMA TOTAL DE SEGMENTOS DE UNDO QUE PERTENECEN A SYS
prompt ===============================================================================================
prompt 
select sum(bytes)/1024/1024/1024 from dba_segments where segment_tyPe like '%UNDO' AND OWNER='SYS';
spoo off

