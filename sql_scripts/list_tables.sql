-- ===============================================================
-- NAME: info_tablas.sql
-- DESCRIPTION: Search all the tables for an schema or all tables like inserted patron
-- USAGE: Execute
-- AUTHOR: Alvaro Anaya
-- ---------------------------------------------------------------
SET LINES 300
col username FOR a25
col ac_status FOR a10
col default_tablespace for a30
col profile FOR  a30
col profile FOR a30
SET verify off
PROMPT
PROMPT Si quiere listar las tablas de un schema en particular introduzca su nombre
DEF owner_de_tablas='&1';
col OBJECT_NAME format a45
spoo users.log
select OWNER,TABLE_NAME,TABLESPACE_NAME,STATUS,NUM_ROWS,DEGREE,LAST_ANALYZED,PARTITIONED,TEMPORARY,FLASH_CACHE,CELL_FLASH_CACHE,ROW_MOVEMENT,COMPRESSION,READ_ONLY,EXTERNAL
from dba_tables 
wherE owner LIKE '%&&owner_de_tablas%';
undef 1;
undef owner_de_tablas;
spoo off

