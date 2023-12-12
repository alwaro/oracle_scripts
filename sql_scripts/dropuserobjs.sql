-- ===============================================================
-- NAME: dropuserobjs.sql
-- DESCRIPTION: Generate queries to drop objects of an specific schema
-- USAGE: Specify schema
-- AUTHOR:
-- ---------------------------------------------------------------

-- borrar objetos de usuario


set trimspool on wrap off
set heading off feedback off
set verify off
set pages 1000 lines 1000

select '&&username' from dual;

spool dropuserobjs_&username..sql

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





