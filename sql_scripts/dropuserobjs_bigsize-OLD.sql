-- borrar objetos de usuario
PROMPT 
PROMPT 
prompt =====================================================================
prompt Esta version del script, antes de generar los drop de los objetos
prompt hace TRUNCATE de las tablas. Para ello realiza un paso antes y despues
prompt que consiste en desactivar y activar constraints.
prompt =====================================================================
PROMPT
PROMPT Pulsa INTRO para continuar...
pause

set trimspool on wrap off
set heading off feedback off
set verify off
set pages 1000 lines 1000

select '&&username' from dual;

spool dropuserobjs_&username..sql

-- DISABLE CONSTRAINTS
SELECT 'ALTER TABLE'||' '||owner||'.'||table_name||' DISABLE CONSTRAINT '||constraint_name||' ;' 
FROM dba_constraints 
WHERE constraint_type = 'R' 
and owner=trim(upper('&username')) 
and status = 'ENABLED';

-- TRUNCATE TABLES
SELECT 'TRUNCATE TABLE '||OWNER||'.'||TABLE_NAME||' ;' 
FROM DBA_TABLES 
WHERE OWNER=trim(upper('&username'));

-- ENABLE CONSTRAINTS
SELECT 'ALTER TABLE'||' '||owner||'.'||table_name||' ENABLE CONSTRAINT '||constraint_name||' ;' 
FROM dba_constraints 
WHERE constraint_type = 'R' 
and owner=trim(upper('&username')) 
and status = 'ENABLED';


select 'alter table ' ||  owner || '.' || table_name || ' drop primary key cascade;'
from dba_constraints
where owner = trim(upper('&username'))
and constraint_type = 'P'
/

select 'alter table ' ||  owner || '.' || table_name || ' drop constraint ' || constraint_name || ' cascade;'
from dba_constraints
where owner = trim(upper('&username'))
and constraint_type = 'U'
/

select 'drop table ' || owner || '.' || table_name || ';'
from dba_tables
where owner = trim(upper('&username'))
/

select 'drop ' || object_type || ' '|| owner || '.' || object_name || ';'
from dba_objects
where owner = trim(upper('&username'))
and object_type not in ('TABLE', 'INDEX', 'DATABASE LINK', 'JAVA CLASS', 'JAVA RESOURCE')
/

-- drop java objects
select 'drop ' || object_type || ' '|| owner || '."' || object_name || '";'
from dba_objects
where owner = trim(upper('&username'))
and object_type in ('JAVA CLASS', 'JAVA RESOURCE')
/

spool off

set heading on feedback on
undef username

--- borra los LOB de la papelera
purge dba_recyclebin;





