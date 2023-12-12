-- ===============================================================
-- NAME: generate_pass_hast_11.sql
-- DESCRIPTION: Generate a query to reset a password
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

prompt ===============================================================================
prompt Este script genera la linea que habra que lanzar para reestablecer una pass
prompt usando la misma que tiene a traves del HASH, pero para la version 11 de oracle
prompt
prompt Es decir, no cambia nada, solo genera la orden que habria que lanzar en una v11
prompt ===============================================================================
prompt 
SET lines 250;
set heading off;
set feedback off;
set verify off;
select 'Para reestablecer al usuario ' || u.username || ' con su misma pass, ejecuta: '
 ,'alter user '||u.username||' identified by values '''||s.password||''';'
 from dba_users u
 join sys.user$ s
 on u.user_id = s.user#
 where u.username = upper('&username');
set heading on;
set feedback on;
set verify on;
