-- ===============================================================
-- NAME: list_type_objects.sql
-- DESCRIPTION: lists all objects for a given type and from a given owner
-- USAGE: the owner and type of object can be passed as arg or are asked for by script
-- AUTHOR:
-- ---------------------------------------------------------------
prompt ================================ SCRIPT PARA LISTAR OBJETOS ================================
prompt Este script utiliza 2 parametros, que se le pueden pasar como argumentos siendo estos:
prompt @list_type_objects.sql  OWNER  TIPO_DE_OBJETO
prompt
prompt O bien, si no se le pasa argumento alguno, preguntara por ellos siendo:
prompt -   1: El owner
prompt -   2: El tipo de objeto a buscar
prompt
prompt Por ultimo, es posible listar todos los objetos de un usuario si no pasamos tipo de objeto
prompt y es posible listar todos los objetos, de todos los owner, si cuando pregunta, no indicamos
prompt owner (Para esto, debemos no debemos usar argumentos y dejaremos vacio el valor para 1)
prompt ============================================================================================
SET VERIFY OFF
DEF owner='&1';
DEF tipo_objeto='&2';
col OWNER format a40
col OBJECT_NAME format a45
spoo listando_&&tipo_objeto._de_&&owner..log
select owner, object_name, object_type,CREATED,STATUS, LAST_DDL_TIME from dba_objects where owner like '%&&owner%' and object_type like '%&&tipo_objeto%';
spoo off;
undef owner;
undef tipo_objeto;
undef 1;
undef 2;

