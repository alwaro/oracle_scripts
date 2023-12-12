-- ===============================================================
-- NAME: refrescar_permisos_prestag.sql
-- DESCRIPTION: Displays queerys to refresh the privileges of users on the database prestag.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200;
set heading off
set echo off
set feedback off
spoo permisos_autogenerados_prestag.sql
-- ##################################
-- # BLOQUE PARA EL USUARIO INDRARW
-- ##################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos tipicos (tablas, sinonimos, vistas, secuencias...)
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INDRAW;' from dba_objects where owner='USR_TGN' and object_type='TYPE';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;

SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_DEF' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_DEF' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INDRAW;' from dba_objects where owner='USR_DEF' and object_type='TYPE';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_DEF' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_DEF' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;

SELECT 'GRANT SELECT, insert, update, delete ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_PRO' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_PRO' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INDRAW;' from dba_objects where owner='USR_PRO' and object_type='TYPE';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_PRO' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_PRO' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;

SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN_REPLICA' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN_REPLICA' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INDRAW;' from dba_objects where owner='USR_TGN_REPLICA' and object_type='TYPE';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN_REPLICA' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN_REPLICA' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;

SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN_REPLICA_MON' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN_REPLICA_MON' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO INDRAW;' from dba_objects where owner='USR_TGN_REPLICA_MON' and object_type='TYPE';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN_REPLICA_MON' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO INDRARW;' from dba_objects where owner='USR_TGN_REPLICA_MON' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;

SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO TIBCORW ;' from dba_objects where owner='USR_TGN_REPLICA' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT on "'||owner||'"."'||object_name||'" TO TIBCORW ;' from dba_objects where owner='USR_TGN_REPLICA' and object_type='SEQUENCE';
SELECT 'GRANT EXECUTE on "'||owner||'"."'||object_name||'" TO TIBCORW ;' from dba_objects where owner='USR_TGN_REPLICA' and object_type='TYPE';
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO TIBCORW ;' from dba_objects where owner='USR_TGN_REPLICA' and object_type in ('VIEW','MATERIALIZED VIEW') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO TIBCORW ;' from dba_objects where owner='USR_TGN_REPLICA' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;
SELECT 'GRANT DEBUG, EXECUTE ON "'||owner||'"."'||object_name||'" TO TIBCORW ;' from dba_objects where owner='USR_TGN' and object_type in ('FUNCTION','PROCEDURE','PACKAGE','JAVA CLASS') order by 1;

-- ######################### --
-- # Permisos securizacion # --
-- ######################### --

-- Permisos solo lectura
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO NORTER;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO SURR;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO PORTOR;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO CATALUNAR;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO ARAGONR;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO INSUCLAIMSR;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO NETORGANIR;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO LEVANTER;' from dba_objects where owner='USR_TGN' and object_type in ('TABLE','SYNONYM')  order by 1;

-- Permisos de lectura/escritura
SELECT 'GRANT SELECT,INSERT,UPDATE,DELETE ON "'||owner||'"."'||object_name||'" TO PROYTRW;' from dba_objects where owner='USR_TGN' or (owner in ('USR_TGN_SNAP_DEF'.'USR_TGN_SNAP_PRO') and object_name='CNN') and object_type in ('TABLE','SYNONYM') order by 1;

-- Permisos clonicos
select 'grant select on '||owner||'.'||table_name||' to PRICSALR;' from dba_tab_privs where grantee='CONSULTAS' and privilege='SELECT'; 
select 'grant select on '||owner||'.'||table_name||' to PROYTR;' from dba_tab_privs where grantee='LECSTAG' and privilege='SELECT'; 
select 'grant select on '||owner||'.'||table_name||' to CONTROLLR;' from dba_tab_privs where grantee='LECSTAG' and privilege='SELECT' and owner='USR_TGN';

-- ###################################
-- # BLOQUE PARA EL USUARIO HOR
-- ###################################
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Asignamos todos los permisos a los sinonimos excluyendo las 2 secuencias que por ser secuencias tienen otros permisos y generarian mensajes de err
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'GRANT SELECT ON "'||owner||'"."'||object_name||'" TO HOR;' from dba_objects where owner='HOR' and object_type in ('TABLE','SYNONYM') and object_name not in ('SINT_FICH_SEC','SINT_TSI_SEC') order by 1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Permisos asignados directamente sobre objetos de sistema para temas de administracion
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
grant select on sys.V_$SESSION to INDRARW;
grant select on sys.GV_$SESSION to INDRARW;
GRANT select on sys.v_$sqlarea to INDRARW;
GRANT select on sys.gv_$sqlarea to INDRARW;
GRANT select on sys.gv_$sqlarea to INDRARW;
spoo off
set feedback on;
@permisos_autogenerados_prestag.sql
prompt
prompt PERMISOS REFRESCADOS
PROMPT
PROMPT
set echo on;
