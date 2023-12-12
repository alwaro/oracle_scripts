--
-- Copyright (c) 1988, 2005, Oracle.  All Rights Reserved.
--
-- NAME
--   glogin.sql
--
-- DESCRIPTION
--   SQL*Plus global login "site profile" file
--
--   Add any SQL*Plus commands here that are to be executed when a
--   user starts SQL*Plus, or uses the SQL*Plus CONNECT command.
--
-- USAGE
--   This script is automatically run
--
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
SET LINESIZE 250
SET PAGESIZE 999
SET TIME ON
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

-- Otras columnas varias
COL username format a25


