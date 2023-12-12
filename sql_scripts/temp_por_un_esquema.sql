-- ===============================================================
-- NAME: temp_por_un_esquema.sql
-- DESCRIPTION: Displays info about the given schema
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col hash_value for 999999999999
select hash_value, sorts, rows_processed/executions
 from v$sql
 where hash_value in (select hash_value from v$open_cursor where sid=7448)
 and sorts > 0
 and PARSING_SCHEMA_NAME=UPPER('&NOMBRE_ESQUEMA')
 order by rows_processed/executions;

