-- ===============================================================
-- File Name: https://oracle-base.com/dba/monitoring/code_dep_tree.sql
-- NAME: ver_dependencias_objeto.sql
-- DESCRIPTION: Displays a tree of dependencies of specified object.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

SET VERIFY OFF
SET LINESIZE 255
SET PAGESIZE 1000

COLUMN referenced_object FORMAT A50
COLUMN referenced_type FORMAT A20
COLUMN referenced_link_name FORMAT A20

SELECT RPAD(' ', level*2, ' ') || a.referenced_owner || '.' || a.referenced_name AS referenced_object,
       a.referenced_type,
       a.referenced_link_name
FROM   all_dependencies a
WHERE  a.owner NOT IN ('SYS','SYSTEM','PUBLIC')
AND    a.referenced_owner NOT IN ('SYS','SYSTEM','PUBLIC')
AND    a.referenced_type != 'NON-EXISTENT'
START WITH a.owner = UPPER('&OWNER__OBJETO')
AND        a.name  = UPPER('&NOMBRE_OBJETO')
CONNECT BY a.owner = PRIOR a.referenced_owner
AND        a.name  = PRIOR a.referenced_name
AND        a.type  = PRIOR a.referenced_type;

SET VERIFY ON
SET PAGESIZE 22
