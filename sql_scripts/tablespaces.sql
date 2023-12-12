-- ===============================================================
-- NAME: tablespaces.sql
-- DESCRIPTION: Displays a list of tablespaces and their used/full status or just one if you write it's name.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
column total_space format 999,999,999,999
column free_space format 999,999,999,999
column pct_libre format 999.99
SET verify off
PROMPT 
PROMPT Si quiere listar un tablespace en particular introduzca su nombre. Si no, simplemente pulse INTRO
DEF tablespace_a_buscar='&1';

select a.tablespace_name,
total_space/1024/1024 espacio_total_MB,
free_space/1024/1024 espacio_libre_MB,
--free_space / total_space * 100 PCT_libre,
100 - (free_space / total_space * 100) as PCT_ocupado
from (select tablespace_name, sum(bytes)
total_space from dba_data_files
group by tablespace_name) a,
(select tablespace_name, sum(bytes)
free_space from dba_free_space
group by tablespace_name) b
where a.tablespace_name = b.tablespace_name(+)
and a.tablespace_name like '%&&tablespace_a_buscar%'
order by PCT_ocupado desc;      
undef tablespace_a_buscar;
undef 1;

