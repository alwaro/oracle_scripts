-- ===============================================================
-- NAME: indexcols.sql
-- DESCRIPTION: Displays Index Columns
-- USAGE: Execute
-- AUTHOR: Pablo Bustamante
-- ---------------------------------------------------------------

col table_owner new_value tabown noprint
col table_name new_value tabnam noprint
col "Index" for a30
col "Column" for a30
col "Pos" for 999
set colsep '|'
set verify off
ttitle left tabown'.'tabnam skip 2
break on "Index" skip 1
btitle off
prompt "De que schema?"
DEF indown='&1';
prompt "De alguna tabla en concreto?"
DEF indtab='&2'
select 
	table_owner,
	table_name,
	index_name as "Index"
	,column_name as "Column",
	column_position as "Pos"
from dba_ind_columns
where 
	table_owner like '%&&indown%'
	and table_name like '%&&indtab%'
order by 1,2,3,4,5
/
UNDEF indown;
UNDEF indtab;

