-- ===============================================================
-- NAME: refrescar_flashback_sisdesrw.sql
-- DESCRIPTION: Displays the queerys to refresh the flashback privileges of the schema sisdesrw on the selected schemas.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200;
set heading off
set echo off
set feedback off 
spoo generado.sql
-- ##################################
-- # BLOQUE PARA EL ESQUEMA SISDESRW
-- ##################################
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT FLASHBACK ON "'||owner||'"."'||object_name||'" TO SISDESRW;' from dba_objects where owner='ADM_AZKAR' and object_type in ('TABLE');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT FLASHBACK ON "'||owner||'"."'||object_name||'" TO SISDESRW;' from dba_objects where owner='ADM_SLM2' and object_type in ('TABLE');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT FLASHBACK ON "'||owner||'"."'||object_name||'" TO SISDESRW;' from dba_objects where owner='AUXL_SLM2' and object_type in ('TABLE');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT FLASHBACK ON "'||owner||'"."'||object_name||'" TO SISDESRW;' from dba_objects where owner='USRSOL' and object_type in ('TABLE');
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

set feedback on;
set heading ON;
SET ECHO ON;
SPOO OFF;
@generado.sql
SET ECHO OFF;
