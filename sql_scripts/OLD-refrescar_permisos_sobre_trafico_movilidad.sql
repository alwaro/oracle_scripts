-- ===============================================================
-- NAME: OLD-refrescar_permisos_sobre_trafico_movilidad.sql
--###############################################################################################
-- DESCRIPTION:  SCRIPT PARA REFRESCAR LOS PERMISOS DE LOS USARIOS PARA EVITAR EL USO DE TRAFICO DIRECTAMENTE
-- ##############################################################################################
--   Este script genera las sentencias necesarias para dar los permisos correspondientes a
--   todos los tipos de objetos especificados en el ticket de mantis
--
-- 	0473595 Solicitud creacion usuarios con permisos RW en base de DATOS de PREBID y PROBID
--
--   El script genera un spool con las ordenes de GRANT necesarias para dar permisos sobre todos
--    los objetos de TRAFICO y MOVILIDAD especificados.
--
-- La idea es que, no solo se ejecute la primera vez sino que, cada vez que haya una subida en la
-- que se añn objetos, no haya que estar pendiente de dar los permisos correspondientes para cada
-- cada uno de estos usuarios, sino que con incluir este script al final para ejecutar como SYS seria
-- todo lo necesario para añr los nuevos objetos.
--
-- 	     WHEN  VERSION        WHO  WHAT
-- ----------  -------  ---------  ----------------------------------------------------------------------
-- 27-07-2021      1.0    A.ANAYA  Implementacion del script
--
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ##################################################################################################
set heading off
set echo off
set feedback off
spoo generado.sql
-- ##################################
-- # BLOQUE PARA EL USUARIO SOPAPPRW
-- ##################################
SELECT 'grant unlimited tablespace to ' sopapprw;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO sopapprw;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO sopapprw;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO sopapprw;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT EXECUTE ON "'||owner||'"."'||object_name||'" TO sopapprw;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO sopapprw;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name like '%V_$SESSION';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO sopapprw;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name like '%V_$SQLAREA';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO sopapprw;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name = 'DBA_OBJECTS';

-- ##################################
-- # BLOQUE PARA EL USUARIO INDRARW
-- ##################################
grant unlimited tablespace to INDRARW;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT EXECUTE ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name like '%V_$SESSION';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name like '%V_$SQLAREA';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name = 'DBA_OBJECTS';
-- ##################################
-- # BLOQUE PARA EL USUARIO APSINDRA
-- ##################################
grant unlimited tablespace to APSINDRA;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='TRAFICO' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='TRAFICO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='MOVILIDAD' and object_type in ('TABLE','SYNONYM') order by 1;
SELECT 'GRANT EXECUTE ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name like '%V_$SESSION';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name like '%V_$SQLAREA';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO APSINDRA;' from dba_objects where owner='SYS' and object_type='VIEW' and object_name = 'DBA_OBJECTS';
-- ###################################
-- # BLOQUE PARA EL USUARIO CONSULTAS
-- ###################################
--SELECT 'GRANT DEBUG ON "'||owner||'"."'||object_name||'" TO CONSULTAS;' from dba_objects where owner='TRAFICO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
spoo off
@generado.sql
PROMPT ##############################################################################################
PROMPT "FIN DE LA EJECUCION DEL SCRIPT"
PROMPT ##############################################################################################

