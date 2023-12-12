-- ===============================================================
-- NAME: busca_objeto.sql
-- DESCRIPTION: Search and describes an object
-- USAGE: Ask for object_name
-- AUTHOR:
-- ---------------------------------------------------------------
prompt BUSCANDO.....: '&&Nombre_del_objeto'
select owner, object_name, object_type,status from dba_objects where object_name='&&Nombre_del_objeto';
undef Nombre_del_objeto

