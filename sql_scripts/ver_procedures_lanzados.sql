-- ===============================================================
-- NAME: ver_procedures_lanzados.sql
-- DESCRIPTION: Displays the procedures that are running at the moment
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

set lines 200
col object_name format a30
select 'PLSQL EJECUTADO', vs.username, d_o.object_name,vs.osuser,vs.SID,vs.machine
  from dba_objects d_o
       inner join
       v$session vs
          on d_o.object_id = vs.plsql_entry_object_id
union all
select 'PLSQL EN EJECUCION', vs.username, d_o.object_name,vs.osuser,vs.SID,vs.machine
  from dba_objects d_o
       inner join
       v$session vs
          on d_o.object_id = vs.plsql_object_id

/

