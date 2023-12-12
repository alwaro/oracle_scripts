-- ===============================================================
-- NAME: que_usa_el_objeto.sql
-- DESCRIPTION: Generates a query that given the owner and object name it gives you detailed info of what it uses.
-- USAGE: Execute 
-- AUTHOR:
-- ---------------------------------------------------------------
set verify off
col OWNER for a20
col name for a26
col type for a20
col REFERENCED_OWNER for a20
col REFERENCED_NAME for a20
col REFERENCED_TYPE for a18
col REFERENCED_LINK_NAME for a20 
col DEPENDENCY_TYPE for a10
spoo que_usa_&&INTRODUZCA_OWNER..&&INTRODUZCA_NOMBRE_OBJETO..log
select * from all_dependencies where REFERENCED_OWNER='&&INTRODUZCA_OWNER' AND REFERENCED_NAME='&&INTRODUZCA_NOMBRE_OBJETO';
spoo off
undef INTRODUZCA_OWNER
undef INTRODUZCA_NOMBRE_OBJETO
set verify on;
