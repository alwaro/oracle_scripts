-- ===============================================================
-- NAME: refrescar_permisos_devinf.sql
-- DESCRIPTION: Displays queerys to refresh the privileges of the users on the database devinf.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200;
set heading off
set echo off
set feedback off
spoo generado_permisos_devinf.sql
-- ##################################
-- # BLOQUE PARA EL USUARIO SOPAPPRW
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos 
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='DEVINF' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT, ALTER on "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='DEVINF' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='DEVINF' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de DEVINF.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='DEVINF' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='DEVINF' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to SOPAPPRW;
grant select on sys.GV_$SESSION to SOPAPPRW;
GRANT select on sys.v_$sqlarea to SOPAPPRW;
GRANT select on sys.gv_$sqlarea to SOPAPPRW;
GRANT select on sys.gv_$sqlarea to SOPAPPRW;
GRANT SCHEDULER_ADMIN TO SOPAPPRW;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to SOPAPPRW;
grant select on sys.dba_scheduler_jobs to SOPAPPRW;
-- ##################################
-- # BLOQUE PARA EL USUARIO INDRARW
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos 
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='DEVINF' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT, ALTER on "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='DEVINF' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='DEVINF' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de DEVINF.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='DEVINF' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='DEVINF' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to INDRARW;
grant select on sys.GV_$SESSION to INDRARW;
GRANT select on sys.v_$sqlarea to INDRARW;
GRANT select on sys.gv_$sqlarea to INDRARW;
GRANT select on sys.gv_$sqlarea to INDRARW;
GRANT SCHEDULER_ADMIN TO INDRARW;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to INDRARW;
grant select on sys.dba_scheduler_jobs to INDRARW;
-- ##################################
-- # BLOQUE PARA EL USUARIO SOPAPPRW
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos 
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INTEGRARW;' from dba_objects where owner='DEVINF' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT, ALTER on "'||owner||'"."'||object_name||'" TO INTEGRARW;' from dba_objects where owner='DEVINF' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INTEGRARW;' from dba_objects where owner='DEVINF' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de DEVINF.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INTEGRARW;' from dba_objects where owner='DEVINF' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO INTEGRARW;' from dba_objects where owner='DEVINF' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to INTEGRARW;
grant select on sys.GV_$SESSION to INTEGRARW;
GRANT select on sys.v_$sqlarea to INTEGRARW;
GRANT select on sys.gv_$sqlarea to INTEGRARW;
GRANT select on sys.gv_$sqlarea to INTEGRARW;
GRANT SCHEDULER_ADMIN TO INTEGRARW;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to INTEGRARW;
grant select on sys.dba_scheduler_jobs to INTEGRARW;
-- ###################################
-- # BLOQUE PARA EL USUARIO CONSULTAS
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario consultas
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='DEVINF' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTDEVINF (Enlazadas desde DEVINF mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='DEVINF' and object_type='SEQUENCE' order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='DEVINF' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='DEVINF' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='DEVINF' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de DEVINF.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='DEVINF' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to CONSULTAS;
grant select on sys.GV_$SESSION to CONSULTAS;
GRANT select on sys.v_$sqlarea to CONSULTAS;
GRANT select on sys.gv_$sqlarea to CONSULTAS;
GRANT select on sys.gv_$sqlarea to CONSULTAS;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to CONSULTAS;
grant select on sys.dba_scheduler_jobs to CONSULTAS;
-- --------------------- --
-- Permisos securizacion --
-- --------------------- --
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO NORTER;' from dba_objects where owner='DEVINF' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO SURR;' from dba_objects where owner='DEVINF' and object_type in ('TABLE','SYNONYM')  order by 1;
spoo off
set feedback on;
@generado_permisos_devinf.sql
prompt
prompt PERMISOS REFRESCADOS
PROMPT
PROMPT
set echo on;

