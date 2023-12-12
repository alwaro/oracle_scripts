-- ===============================================================
-- NAME: refrescar_permisos_schema_archivado.sql
-- DESCRIPTION: Displays queerys to refresh the privileges of the schema archivado.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200;
set heading off
set echo off
set feedback off
spoo generado.sql
-- ##################################
-- # BLOQUE PARA EL USUARIO ARCHIVADO
-- ##################################
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO ARCHIVADO;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT, ALTER on "'||owner||'"."'||object_name||'" TO ARCHIVADO;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO ARCHIVADO;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ARCHIVADO;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO ARCHIVADO;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos los permisos sobre los objeto directorios de aplicacion (ATR_*)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'grant read, write on directory  "'||directory_name||'" TO ARCHIVADO;' from dba_directories where directory_name like 'ATR_%';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to ARCHIVADO;
grant select on sys.GV_$SESSION to ARCHIVADO;
GRANT select on sys.v_$sqlarea to ARCHIVADO;
GRANT select on sys.gv_$sqlarea to ARCHIVADO;
GRANT select on sys.gv_$sqlarea to ARCHIVADO;
GRANT SCHEDULER_ADMIN TO ARCHIVADO;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to ARCHIVADO;
grant select on sys.dba_scheduler_jobs to ARCHIVADO;
set feedback on;
set heading ON;
SET ECHO ON;
SPOO OFF;
@generado.sql
SET ECHO OFF;

