-- ===============================================================
-- NAME: find_parametros_todos.sql
-- DESCRIPTION: Search and display parameters
-- USAGE: Specify parameters
-- AUTHOR:
-- ---------------------------------------------------------------
set verify off
DEF PARAMETRO='&1';
SPOO info_parametros_&&PARAMETRO..log
SET LINES 250
SET PAGES 999
col parameter for a52
col "session value" for a32
col "instance value" for a32
COL Description FOR A98
SELECT x.ksppinm "Parameter",
       Y.ksppstvl "Session Value",
       Z.ksppstvl "Instance Value",
       x.ksppdesc "Description"
FROM   x$ksppi X,
       x$ksppcv Y,
       x$ksppsv Z
WHERE  x.indx = Y.indx
AND    x.indx = z.indx
AND    x.ksppinm LIKE '%&&PARAMETRO%'
order by x.ksppinm;
spoo off;
UNDEF PARAMETRO;
UNDEF 1;
SET VERIFY ON;
