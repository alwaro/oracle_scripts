-- ===============================================================
-- NAME: refrescar_permisos_contra_trafico.sql
-- DESCRIPTION: Displays queerys to refresh the privileges of the schemas on trafico.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200;
set heading off
set echo off
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
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos los permisos sobre los objeto directorios de aplicacion (ATR_*)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'grant read, write on directory  "'||directory_name||'" TO DESABID;' from dba_directories where directory_name like 'ATR_%';
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
grant select on sys.dba_errors to DESABID;
grant execute on sys.NODO1 to DESABID;
grant exexute on sys.NODO2 to DESABID;

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

-- ###################################
-- # BLOQUE PARA EL USUARIO PROYTR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario proytr
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO PROYTR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PROYTR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PROYTR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO PROYTR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO PROYTR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PROYTR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PROYTR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to PROYTR;
grant select on sys.GV_$SESSION to PROYTR;
GRANT select on sys.v_$sqlarea to PROYTR;
GRANT select on sys.gv_$sqlarea to PROYTR;
GRANT select on sys.gv_$sqlarea to PROYTR;
GRANT SCHEDULER_ADMIN TO PROYTR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to PROYTR;
grant select on sys.dba_scheduler_jobs to PROYTR;

-- ###################################
-- # BLOQUE PARA EL USUARIO PRICSALR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario pricsalr
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO PRICSALR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PRICSALR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PRICSALR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO PRICSALR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO PRICSALR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PRICSALR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PRICSALR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to PRICSALR;
grant select on sys.GV_$SESSION to PRICSALR;
GRANT select on sys.v_$sqlarea to PRICSALR;
GRANT select on sys.gv_$sqlarea to PRICSALR;
GRANT select on sys.gv_$sqlarea to PRICSALR;
GRANT SCHEDULER_ADMIN TO PRICSALR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to PRICSALR;
grant select on sys.dba_scheduler_jobs to PRICSALR;

-- ###################################
-- # BLOQUE PARA EL USUARIO TRAFICORGAR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario TRAFICORGAR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO TRAFICORGAR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO TRAFICORGAR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO TRAFICORGAR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO TRAFICORGAR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO TRAFICORGAR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO TRAFICORGAR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO TRAFICORGAR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to TRAFICORGAR;
grant select on sys.GV_$SESSION to TRAFICORGAR;
GRANT select on sys.v_$sqlarea to TRAFICORGAR;
GRANT select on sys.gv_$sqlarea to TRAFICORGAR;
GRANT select on sys.gv_$sqlarea to TRAFICORGAR;
GRANT SCHEDULER_ADMIN TO TRAFICORGAR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to TRAFICORGAR;
grant select on sys.dba_scheduler_jobs to TRAFICORGAR;

-- ###################################
-- # BLOQUE PARA EL USUARIO INTEGRAR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario INTEGRAR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO INTEGRAR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INTEGRAR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INTEGRAR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO INTEGRAR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INTEGRAR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INTEGRAR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INTEGRAR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to INTEGRAR;
grant select on sys.GV_$SESSION to INTEGRAR;
GRANT select on sys.v_$sqlarea to INTEGRAR;
GRANT select on sys.gv_$sqlarea to INTEGRAR;
GRANT select on sys.gv_$sqlarea to INTEGRAR;
GRANT SCHEDULER_ADMIN TO INTEGRAR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to INTEGRAR;
grant select on sys.dba_scheduler_jobs to INTEGRAR;

-- ###################################
-- # BLOQUE PARA EL USUARIO INSUCLAIMSR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario INSUCLAIMSR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO INSUCLAIMSR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INSUCLAIMSR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INSUCLAIMSR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO INSUCLAIMSR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INSUCLAIMSR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INSUCLAIMSR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INSUCLAIMSR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to INSUCLAIMSR;
grant select on sys.GV_$SESSION to INSUCLAIMSR;
GRANT select on sys.v_$sqlarea to INSUCLAIMSR;
GRANT select on sys.gv_$sqlarea to INSUCLAIMSR;
GRANT select on sys.gv_$sqlarea to INSUCLAIMSR;
GRANT SCHEDULER_ADMIN TO INSUCLAIMSR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to INSUCLAIMSR;
grant select on sys.dba_scheduler_jobs to INSUCLAIMSR;



-- ###################################
-- # BLOQUE PARA EL USUARIO PROMANR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario PROMANR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO PROMANR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PROMANR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PROMANR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO PROMANR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO PROMANR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PROMANR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PROMANR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to PROMANR;
grant select on sys.GV_$SESSION to PROMANR;
GRANT select on sys.v_$sqlarea to PROMANR;
GRANT select on sys.gv_$sqlarea to PROMANR;
GRANT select on sys.gv_$sqlarea to PROMANR;
GRANT SCHEDULER_ADMIN TO PROMANR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to PROMANR;
grant select on sys.dba_scheduler_jobs to PROMANR;


-- ###################################
-- # BLOQUE PARA EL USUARIO CONTROLLR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario CONTROLLR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO CONTROLLR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONTROLLR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONTROLLR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO CONTROLLR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO CONTROLLR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONTROLLR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CONTROLLR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to CONTROLLR;
grant select on sys.GV_$SESSION to CONTROLLR;
GRANT select on sys.v_$sqlarea to CONTROLLR;
GRANT select on sys.gv_$sqlarea to CONTROLLR;
GRANT select on sys.gv_$sqlarea to CONTROLLR;
GRANT SCHEDULER_ADMIN TO CONTROLLR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to CONTROLLR;
grant select on sys.dba_scheduler_jobs to CONTROLLR;


-- ###################################
-- # BLOQUE PARA EL USUARIO NETORGANIR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario NETORGANIR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO NETORGANIR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO NETORGANIR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO NETORGANIR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO NETORGANIR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO NETORGANIR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO NETORGANIR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO NETORGANIR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to NETORGANIR;
grant select on sys.GV_$SESSION to NETORGANIR;
GRANT select on sys.v_$sqlarea to NETORGANIR;
GRANT select on sys.gv_$sqlarea to NETORGANIR;
GRANT select on sys.gv_$sqlarea to NETORGANIR;
GRANT SCHEDULER_ADMIN TO NETORGANIR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to NETORGANIR;
grant select on sys.dba_scheduler_jobs to NETORGANIR;


-- ###################################
-- # BLOQUE PARA EL USUARIO ADMONR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario ADMONR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO ADMONR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ADMONR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ADMONR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO ADMONR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO ADMONR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ADMONR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ADMONR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to ADMONR;
grant select on sys.GV_$SESSION to ADMONR;
GRANT select on sys.v_$sqlarea to ADMONR;
GRANT select on sys.gv_$sqlarea to ADMONR;
GRANT select on sys.gv_$sqlarea to ADMONR;
GRANT SCHEDULER_ADMIN TO ADMONR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to ADMONR;
grant select on sys.dba_scheduler_jobs to ADMONR;


-- ###################################
-- # BLOQUE PARA EL USUARIO CATALUNAR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario CATALUNAR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO CATALUNAR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CATALUNAR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CATALUNAR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO CATALUNAR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO CATALUNAR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CATALUNAR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CATALUNAR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to CATALUNAR;
grant select on sys.GV_$SESSION to CATALUNAR;
GRANT select on sys.v_$sqlarea to CATALUNAR;
GRANT select on sys.gv_$sqlarea to CATALUNAR;
GRANT select on sys.gv_$sqlarea to CATALUNAR;
GRANT SCHEDULER_ADMIN TO CATALUNAR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to CATALUNAR;
grant select on sys.dba_scheduler_jobs to CATALUNAR;


-- ###################################
-- # BLOQUE PARA EL USUARIO ARAGONR
-- ###################################
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- Damos permisos de edicion sobre los objetos de codigo al usuario ARAGONR
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO ARAGONR;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos los permisos concretos a 2 secuencias necesarias en INTTRAFICO (Enlazadas desde TRAFICO mediante sinonimos)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ARAGONR;' from dba_objects where owner='INTTRAFICO' and object_type='SEQUENCE' AND OBJECT_NAME IN ('FICH_SEC','TSI_SEC') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ARAGONR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO ARAGONR;' from dba_objects where owner='TRAFICO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO ARAGONR;' from dba_objects where owner='TRAFICO' and object_type='TYPE';
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Generamos el resto de sentencias mas estandar tambien sobre movilidad ademas de trafico.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ARAGONR;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ARAGONR;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to ARAGONR;
grant select on sys.GV_$SESSION to ARAGONR;
GRANT select on sys.v_$sqlarea to ARAGONR;
GRANT select on sys.gv_$sqlarea to ARAGONR;
GRANT select on sys.gv_$sqlarea to ARAGONR;
GRANT SCHEDULER_ADMIN TO ARAGONR;
grant select on sys.DBA_SCHEDULER_RUNNING_JOBS to ARAGONR;
grant select on sys.dba_scheduler_jobs to ARAGONR;

-- ###################################
-- # BLOQUE PARA EL USUARIO NORTER
-- ###################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO NORTER;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;

-- ###################################
-- # BLOQUE PARA EL USUARIO LEVANTER
-- ###################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO LEVANTER;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;

-- ###################################
-- # BLOQUE PARA EL USUARIO HOR
-- ###################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO HOR;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;

spoo off
set feedback on;
@generado.sql
prompt
prompt PERMISOS REFRESCADOS
PROMPT
PROMPT
set echo on;

prompt "IMPORTANTE IMPORTANTE IMPORTANTE"
PROMPT "LISTAMOS EL NUMERO DE OBJETOS INVALIDOS POR SI ESTE PROCESO SE PISA CON OTROS Y DEJA OBJETOS INVALIDOS, QUE YA HA PASADO"
select count(*) from dba_objects where status='INVALID';

