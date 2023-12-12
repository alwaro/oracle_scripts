-- ===============================================================
-- NAME: get_fks.sql
-- DESCRIPTION: Displays fk from an specific table and owner
-- USAGE: Specify table and owner
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
set pages 30
set verify off
col table_name for a25
col column_name for a30
col constraint_name for a30
col owner for a20
col r_owner for a20
col r_table_name for a25
col r_pk for a20
spool listado_foreign_keys_tabla_&&Nombre_del_propiertario..&&Nombre_de_la_tabla..log
SELECT a.table_name, a.column_name, a.constraint_name, c.owner, 
       -- referenced pk
       c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
 WHERE c.constraint_type = 'R'
   AND a.table_name = '&&Nombre_de_la_tabla'
   AND a.owner='&&Nombre_del_propiertario';
spoo off
set verify on;
undefine Nombre_de_la_tabla
undefine Nombre_del_propiertario
