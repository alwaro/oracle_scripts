-- Script de auto-configuracion para formateo
-- Ejecutable "tal cual" aunque es mejor convertirlo en
-- en el fichero glogin.sql por defecto del sqlplus ya 
-- que el prompt se actualiza ante cambios de usuario o bbdd
-- y si lo ejecutamos bajo demanda solo cambia al ejecutarlo
-- Alvaro.

-- ZONA DE VARIABLES
-- -------------------------------

-- Variable para la ruta de los scripts dba
-- COMENTADA: Mejor definirla a nivel de SISTEMA OPERATIVO
-- define dba=/SCRIPTS/dba


-- PROMPT
SET sqlprompt "&_USER@&_CONNECT_IDENTIFIER> "


-- Habilitamos que pueda haber lineas en blanco dentro de una sentencia
set sqlblanklines on


-- configuraciones de aspecto
-- -------------------------------
SET LINESIZE 300
SET PAGESIZE 999
-- SET TIME ON
SET NUMFORMAT 999999999999999999
-- ALTER SESSION SET nls_date_format = 'HH:MI:SS';


-- Usadas para el comando SHOW ERRORS
COLUMN LINE/COL FORMAT A8
COLUMN ERROR FORMAT A65 WORD_WRAPPED

-- Para el comando SHOW SGA
COLUMN name_col_plus_show_sga FORMAT a24

-- Para SHOW PARAMETERS
COLUMN name_col_plus_show_param FORMAT a36 HEADING NAME
COLUMN value_col_plus_show_param FORMAT a30 HEADING VALUE

-- Para SHOW RECYCLEBIN
COLUMN origname_plus_show_recyc FORMAT a16 HEADING 'ORIGINAL NAME'
COLUMN objectname_plus_show_recyc FORMAT a30 HEADING 'RECYCLEBIN NAME'
COLUMN objtype_plus_show_recyc FORMAT a12 HEADING 'OBJECT TYPE'
COLUMN droptime_plus_show_recyc FORMAT a19 HEADING 'DROP TIME'

-- Para el SET AUTOTRACE EXPLAIN report
COLUMN id_plus_exp FORMAT 990 HEADING i
COLUMN parent_id_plus_exp FORMAT 990 HEADING p
COLUMN plan_plus_exp FORMAT a60
COLUMN object_node_plus_exp FORMAT a8
COLUMN other_tag_plus_exp FORMAT a29
COLUMN other_plus_exp FORMAT a44

-- DANDO FORMATO A COLUMNAS

-- COLUMNAS DE OWNER
-- ------------------------------------------
COL OWNER FORMAT A25
COL OBJECT_OWNER FORMAT A25
COL TABLE_OWNER FORMAT A25
COL INDEX_OWNER FORMAT A25
COL TIGGER_OWNER FORMAT A25
COL SEGMENT_OWNER FORMAT A25

-- COLUMNAS DE NAME
-- -------------------------------------------
COL NAME FORMAT A25
COL TABLE_NAME FORMAT A25
COL INDEX_NAME FORMAT A25
COL OBJECT_NAME FORMAT A35
COL TRIGGER_NAME FORMAT A25
COL SEGMENT_NAME FORMAT A40
COL FILE_NAME FORMAT A40
COL TABLESPACE_NAME FORMAT A25
COL TABLESPACE FORMAT A25
COL USERNAME FORMAT A25
COL FILENAME FORMAT A40
COL DIRECTORY_NAME FORMAT A30
COL PARTITION_NAME FORMAT A25
COL INSTANCE_NAME FORMAT A25
COL HOST_NAME FORMAT A25
COL LOG_NAME FORMAT A25
COL ARCHIVELOG_NAME FORMAT A25
COL GROUP_NAME FORMAT A25


-- COLUMNAS DE TYPE
-- ----------------------------------------------------------
COL TYPE FORMAT A25
COL SEGMENT_TYPE FORMAT A25
COL INDEX_TYPE FORMAT A25
COL OBJECT_TYPE FORMAT A25
COL FILE_TYPE FORMAT A25


-- COLUMNAS VARIAS
-- ---------------------------------------------------------------
COL SCHEMA FORMAT A25
COL STATUS FORMAT A20
COL DATABASE_STATUS FORMAT A25
COL INSTANCE_STATUS FORMAT A25
COL MACHINE FORMAT A30
COL PROGRAM FORMAT A30
COL EVENT FORMAT A30
COL WAIT_EVENT FORMAT A25
COL WAIT FORMAT A25
COL OSUSER FORMAT A35
COL DIRECTORY_PATH FORMAT A80

-- COLUMNAS NUMERICAS
-- ----------------------------------------------------------------------
COL INST_ID FORMAT 9999
COL BYTES FORMAT 9999999999999