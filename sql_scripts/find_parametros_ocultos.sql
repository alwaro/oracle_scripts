-- ===============================================================
-- NAME: find_parametros_ocultos.sql
-- DESCRIPTION: Search and display hidden parameters
-- USAGE: Specify parameters
-- AUTHOR:
-- ---------------------------------------------------------------
set verify off
DEF PARAMETRO='&1';
SPOO info_parametro_oculto_&&PARAMETRO..log
SET LINES 250
SET PAGES 999
col parameter for a52
col "session value" for a14
col "instance value" for a14
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
AND    x.ksppinm LIKE '/_%' escape '/'
AND    x.ksppinm LIKE '%&&PARAMETRO%'
order by x.ksppinm;
spoo off;
UNDEF PARAMETRO;
UNDEF 1;
SET VERIFY ON;
