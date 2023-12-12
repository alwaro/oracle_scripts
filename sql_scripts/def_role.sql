-- ===============================================================
-- NAME: def_role.sql
-- DESCRIPTION: Shows role info
-- USAGE: Specify role
-- AUTHOR:
-- ---------------------------------------------------------------
set echo off
set long 100000
set longchunksize 200
set heading off
set feedback off
set verify off
spoo definition-role-&&role..log
select (case
when ((select count(*)
from dba_roles
where role = upper('&&role')) > 0)
then dbms_metadata.get_ddl ('ROLE', upper('&&role'))
else to_clob ('Role does not exist')
end ) Extracted_DDL from dual
UNION ALL
select (case
when ((select count(*)
from dba_role_privs
where grantee = upper('&&role')) > 0)
then dbms_metadata.get_granted_ddl ('ROLE_GRANT', upper('&&role'))
end ) from dual
UNION ALL
select (case
when ((select count(*)
from dba_role_privs
where grantee = upper('&&role')) > 0)
then dbms_metadata.get_granted_ddl ('DEFAULT_ROLE', upper('&&role'))
end ) from dual
UNION ALL
select (case
when ((select count(*)
from dba_sys_privs
where grantee = upper('&&role')) > 0)
then dbms_metadata.get_granted_ddl ('SYSTEM_GRANT', upper('&&role'))
end ) from dual
UNION ALL
select (case
when ((select count(*)
from dba_tab_privs
where grantee = upper('&&role')) > 0)
then dbms_metadata.get_granted_ddl ('OBJECT_GRANT', upper('&&role'))
end ) from dual;
undefine role;
set echo on;
spoo off
