---------------------------------------------------------------------------------------------
-- Este script lista los indices a compactar partiendo de unos valores minimos configurables
-- 
-- Es una modificacion sobre el script original de Carlos Sierra (2017/07/12)
-- Puede ejecutarse en bbdd estandar y PDB sin problema
--
-- Nombre del script original de carlos sierra indexes_2b_shrunk.sql
--
-- Los valores configurables como minimos son:
-- MINIMO DE MEJORA EN % (VAR savings_percent)
-- MINIMO DE SIZE PARA EL INDEX (VAR minimum_size_mb)
---------------------------------------------------------------------------------------
 
-- Solo usara indices con un % de mejora superior al indicado en la var savings_percent
VAR savings_percent NUMBER;
EXEC :savings_percent := 3;
-- Solo listara indices cuyo size (basado en cbo stats) sea mayor que la var minimun_size_mb
VAR minimum_size_mb NUMBER;
EXEC :minimum_size_mb := 2;
 
SET SERVEROUT ON ECHO OFF FEED OFF VER OFF TAB OFF LINES 300;

-- estas lineas eran para sacar la fecha y ponerla como parte del nombre del spool
-- pero la hora usaba los ":" y hacian poco practico el fichero resultado. 
-- En su lugar he puesto que el spool tenga el nombre de instancia.
-- COL report_date NEW_V report_date;
-- SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD"T"HH24:MI:SS') report_date FROM DUAL;
COL instancia NEW_V instancia;
select TRIM(instance_name) instancia from v$instance;
-- SPO indexes_to_rebuild_&&instancia._&&report_date..txt;
SPO indexes_to_rebuild_&&instancia..txt; 

-- comienza la magia :)
DECLARE
l_used_bytes NUMBER;
l_alloc_bytes NUMBER;
l_percent NUMBER;
BEGIN
DBMS_OUTPUT.PUT_LINE('DB: '||SYS_CONTEXT('USERENV', 'CON_NAME'));
DBMS_OUTPUT.PUT_LINE('---');
DBMS_OUTPUT.PUT_LINE(
RPAD('OWNER.INDEX_NAME', 45)||' '||
LPAD('A MEJORAR %', 10)||' '||
LPAD('SIZE ACTUAL', 20)||' '||
LPAD('SIZE ESTIMADO', 20)||' '||
LPAD('SENTENCIA', 90))
;
DBMS_OUTPUT.PUT_LINE(
RPAD('-', 45, '-')||' '||
LPAD('-', 10, '-')||' '||
LPAD('-', 20, '-')||' '||
LPAD('-', 20, '-')||' '||
LPAD('-', 90, '-'));
FOR i IN (SELECT x.owner, x.index_name, SUM(s.leaf_blocks) * TO_NUMBER(p.value) index_size,
REPLACE(DBMS_METADATA.GET_DDL('INDEX',x.index_name,x.owner),CHR(10),CHR(32)) ddl,
'SHOW '||x.owner||'.'||x.index_name||';' COMMAND
FROM dba_ind_statistics s, dba_indexes x, dba_users u, v$parameter p
WHERE u.oracle_maintained = 'N'
AND x.owner = u.username
AND x.tablespace_name NOT IN ('SYSTEM','SYSAUX')
AND x.index_type LIKE '%NORMAL%'
AND x.table_type = 'TABLE'
AND x.status = 'VALID'
AND x.temporary = 'N'
AND x.dropped = 'NO'
AND x.visibility = 'VISIBLE'
AND x.segment_created = 'YES'
AND x.orphaned_entries = 'NO'
AND p.name = 'db_block_size'
AND s.owner = x.owner
AND s.index_name = x.index_name
--AND s.STATTYPE_LOCKED is NULL
GROUP BY
x.owner, x.index_name, p.value
HAVING
SUM(s.leaf_blocks) * TO_NUMBER(p.value) > :minimum_size_mb * POWER(2,20)
ORDER BY
index_size DESC)
LOOP
DBMS_SPACE.CREATE_INDEX_COST(i.ddl,l_used_bytes,l_alloc_bytes);
IF i.index_size * (100 - :savings_percent) / 100 > l_alloc_bytes THEN
l_percent := 100 * (i.index_size - l_alloc_bytes) / i.index_size;
DBMS_OUTPUT.PUT_LINE(
RPAD(i.owner||'.'||i.index_name, 45)||' '||
LPAD(TO_CHAR(ROUND(l_percent, 1), '990.0')||' % ', 10)||' '||
LPAD(TO_CHAR(ROUND(i.index_size / POWER(2,20), 1), '999,999,990.0')||' MB', 20)||' '||
LPAD(TO_CHAR(ROUND(l_alloc_bytes / POWER(2,20), 1), '999,999,990.0')||' MB', 20)||' '||
LPAD('ALTER INDEX '||i.owner||'.'||i.index_name||' REBUILD ONLINE;', 90));
END IF;
END LOOP;
END;
/
PROMPT 
PROMPT 

SPO OFF;
