set lines 200;
set heading off
set echo on
set feedback off
spoo generado.sql
-- ##################################
-- # BLOQUE PARA EL USUARIO SOPAPPRW
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, ALTER ON "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO SOPAPPRW;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos sobre los objetos directorios de aplicativo y jobs de app
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT READ ON DIRECTORY "'||DIRECTORY_NAME||'" TO SOPAPPRW;' from dba_directories where directory_path like '%utl_file%';
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
-- # BLOQUE PARA EL USUARIO DESABID
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, ALTER ON "'||owner||'"."'||object_name||'" TO DESABID;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO DESABID;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT, ALTER on "'||owner||'"."'||object_name||'" TO DESABID;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO DESABID;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO DESABID;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO DESABID;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO DESABID;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to DESABID;
grant select on sys.GV_$SESSION to DESABID;
GRANT select on sys.v_$sqlarea to DESABID;
GRANT select on sys.gv_$sqlarea to DESABID;
GRANT select on sys.gv_$sqlarea to DESABID;
GRANT SCHEDULER_ADMIN TO DESABID;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to DESABID;
grant select on sys.dba_scheduler_jobs to DESABID;

-- ##################################
-- # BLOQUE PARA EL USUARIO INDRARW
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, ALTER ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INDRAW;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to INDRARW;
grant select on sys.GV_$SESSION to INDRARW;
GRANT select on sys.v_$sqlarea to INDRARW;
GRANT select on sys.gv_$sqlarea to INDRARW;
GRANT select on sys.gv_$sqlarea to INDRARW;

-- ##################################
-- # BLOQUE PARA EL USUARIO APSINDRA
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, ALTER ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to APSINDRA;
grant select on sys.GV_$SESSION to APSINDRA;
GRANT select on sys.v_$sqlarea to APSINDRA;
GRANT select on sys.gv_$sqlarea to APSINDRA;
GRANT select on sys.gv_$sqlarea to APSINDRA;

-- ##################################
-- # BLOQUE PARA EL USUARIO TIBCO2
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, ALTER ON "'||owner||'"."'||object_name||'" TO TIBCO2;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO TIBCO2;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO TIBCO2;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO TIBCO2;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO TIBCO2;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO TIBCO2;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO TIBCO2;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to TIBCO2;
grant select on sys.GV_$SESSION to TIBCO2;
GRANT select on sys.v_$sqlarea to TIBCO2;
GRANT select on sys.gv_$sqlarea to TIBCO2;
GRANT select on sys.gv_$sqlarea to TIBCO2;

-- ###################################
-- # BLOQUE PARA EL USUARIO CONSULTAS
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario consultas
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to CONSULTAS;
grant select on sys.GV_$SESSION to CONSULTAS;
GRANT select on sys.v_$sqlarea to CONSULTAS;
GRANT select on sys.gv_$sqlarea to CONSULTAS;
GRANT select on sys.gv_$sqlarea to CONSULTAS;
GRANT SCHEDULER_ADMIN TO CONSULTAS;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to CONSULTAS;
grant select on sys.dba_scheduler_jobs to CONSULTAS;
spoo off
set feedback on;
@generado.sql
prompt
prompt PERMISOS REFRESCADOS
PROMPT
PROMPT
set echo on;

