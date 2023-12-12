-- ===============================================================
-- NAME: def_table_full.sql
-- DESCRIPTION: Show info of table
-- USAGE: Specify table and owner
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
col owner format a15
col column_name format a25
col table_owner format a20
col UNIQUENESS format a4
SET ECHO OFF
SET FEEDBACK OFF
set verify off
DEF Nombre_del_propiertario='&1';
DEF Nombre_de_la_tabla='&2';
set heading off
spool definicion_tabla_&&Nombre_del_propiertario..&&Nombre_de_la_tabla..log
prompt ===============================================
PROMPT DATOS DE LA TABLA
prompt ===============================================
SELECT
    'PROPIETARIO..............: '||t.OWNER||chr(10)||
    'NOMBRE DE TABLA..........: '||t.TABLE_NAME||chr(10)||
    'SIZE EN MB...............: '||s.BYTES/1024/1024||chr(10)||
    'TABLESPACE...............: '||t.TABLESPACE_NAME||chr(10)||
    'PARARELISMO..............: '||t.DEGREE||chr(10)||
    'LOGGING..................: '||t.LOGGING||chr(10)||
    'ESTADISTICAS.............: '||t.LAST_ANALYZED||chr(10)||
    'PARTICIONADA.............: '||t.PARTITIONED||chr(10)||
    'ROW_MOVEMENT.............: '||t.ROW_MOVEMENT||chr(10)||
    'COMPRESION...............: '||t.COMPRESSION
FROM DBA_TABLES t, DBA_SEGMENTS s WHERE
    t.OWNER=upper('&&Nombre_del_propiertario') AND
    t.TABLE_NAME=upper('&&Nombre_de_la_tabla') AND
    s.owner=upper('&&Nombre_del_propiertario') AND
    s.segment_name=upper('&&Nombre_de_la_tabla') AND
    s.SEGMENT_TYPE='TABLE';
prompt
prompt DATOS DE LOS INDICES
prompt ================================================
select
    'INDEX..................: '||i.INDEX_NAME||chr(10)||
    'SIZE EN MB.............: '||s.BYTES/1024/1024||chr(10)||
    'PROPIETARIO............: '||i.OWNER||chr(10)||
    'TABLE_OWNER............: '||i.TABLE_OWNER||chr(10)||
    'TABLE_NAME.............: '||i.TABLE_NAME||chr(10)||
    'UNIQUENESS.............: '||i.UNIQUENESS||chr(10)||
    'COMPRESSION............: '||i.COMPRESSION||chr(10)||
    'TABLESPACE_NAME........: '||i.TABLESPACE_NAME||chr(10)||
    'LOGGING................: '||i.LOGGING||chr(10)||
    'BLEVEL.................: '||i.BLEVEL||chr(10)||
    'STATUS.................: '||i.STATUS||chr(10)||
    'LAST_ANALYZED..........: '||i.LAST_ANALYZED||chr(10)||
    'DEGREE.................: '||i.DEGREE||chr(10)||
    'PARTITIONED............: '||i.PARTITIONED||chr(10)||
    'VISIBILITY.............: '||i.VISIBILITY
from dba_indexes i, dba_segments s where
    i.owner='&&Nombre_del_propiertario' AND
    i.table_name='&&Nombre_de_la_tabla' and
    s.owner='&&Nombre_del_propiertario' AND
    i.index_name=s.segment_name AND
    s.SEGMENT_TYPE='INDEX';
prompt
prompt COLUMNAS DE LOS INDICES
prompt ================================================
set heading on
select index_name,COLUMN_NAME,COLUMN_POSITION,DESCEND from all_ind_columns where table_owner='&&Nombre_del_propiertario' and table_name='&&Nombre_de_la_tabla' AND INDEX_NAME IN (SELECT INDEX_NAME FROM DBA_INDEXES WHERE TABLE_OWNER='&&Nombre_del_propiertario' AND TABLE_NAME='&&Nombre_de_la_tabla');
spoo off;
SET VERIFY ON
SET FEEDBACK ON
undef Nombre_del_propiertario
undef Nombre_de_la_tabla
SET ECHO ON

