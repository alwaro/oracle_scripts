-- ===============================================================
-- NAME: query_muestra.sql
-- DESCRIPTION: Display everything about an specific table field
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
(SELECT * FROM TARIFAS_COSTES_COORDINACION WHERE CODIGO = 4444 AND CONCEPTO = 'MAN' AND TIPO = 'E' AND TIPOFRACCION = 'EM' AND TRUNC (FECHA_VALIDEZ) <= TRUNC (SYSDATE-7) AND TRUNC(FECHA_VALIDEZ)
 IN ( SELECT TRUNC(MAX(FECHA_VALIDEZ)) FROM TARIFAS_COSTES_COORDINACION WHERE CODIGO = 4444 AND CONCEPTO = 'MAN' AND (KEYTST = 9 OR KEYTST = 0) ) AND (KEYTST = 9 OR KEYTST = 0))
 ORDER BY FRACCION ASC, KEYTST DESC;
