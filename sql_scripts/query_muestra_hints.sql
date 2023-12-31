-- ===============================================================
-- NAME: query_muestra_hints.sql
-- DESCRIPTION: Display everything about an specific table field
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
(SELECT 
/*+ 
BEGIN_OUTLINE_DATA 
IGNORE_OPTIM_EMBEDDED_HINTS 
OPTIMIZER_FEATURES_ENABLE('12.2.0.1') 
DB_VERSION('12.2.0.1') 
ALL_ROWS 
OUTLINE_LEAF(@"SEL$2") 
OUTLINE_LEAF(@"SEL$1") 
INDEX_RS_ASC(@"SEL$1" "TARIFAS_COSTES_COORDINACION"@"SEL$1" ("TARIFAS_COSTES_COORDINACION"."CODIGO" 
"TARIFAS_COSTES_COORDINACION"."CONCEPTO" "TARIFAS_COSTES_COORDINACION"."TIPO" "TARIFAS_COSTES_COORDINACION"."KEYTST" 
"TARIFAS_COSTES_COORDINACION"."TIPOFRACCION" "TARIFAS_COSTES_COORDINACION"."FRACCION")) 
PUSH_SUBQ(@"SEL$2") 
INDEX_RS_ASC(@"SEL$2" "TARIFAS_COSTES_COORDINACION"@"SEL$2" ("TARIFAS_COSTES_COORDINACION"."CODIGO" 
"TARIFAS_COSTES_COORDINACION"."CONCEPTO" "TARIFAS_COSTES_COORDINACION"."TIPO" "TARIFAS_COSTES_COORDINACION"."KEYTST" 
"TARIFAS_COSTES_COORDINACION"."TIPOFRACCION" "TARIFAS_COSTES_COORDINACION"."FRACCION")) 
END_OUTLINE_DATA 
*/ 
* FROM TARIFAS_COSTES_COORDINACION WHERE CODIGO = 4444 AND CONCEPTO = 'MAN' AND TIPO = 'E' AND TIPOFRACCION = 'EM' AND TRUNC (FECHA_VALIDEZ) <= TRUNC (SYSDATE-7) AND TRUNC(FECHA_VALIDEZ)
 IN ( SELECT TRUNC(MAX(FECHA_VALIDEZ)) FROM TARIFAS_COSTES_COORDINACION WHERE CODIGO = 4444 AND CONCEPTO = 'MAN' AND (KEYTST = 9 OR KEYTST = 0) ) AND (KEYTST = 9 OR KEYTST = 0))
 ORDER BY FRACCION ASC, KEYTST DESC;

