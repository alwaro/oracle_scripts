-- ===============================================================
-- NAME: asm_enteros.sql
-- DESCRIPTION: Gets ACLs in a single list
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
-- SELECT name, round(total_mb/1024) TOTAL_GB, round(free_mb/1024)  FREE_GB, round(USABLE_FILE_MB/1024)FREE_REAL_GB,  round(free_mb/total_mb*100) as "% FREE" FROM v$asm_diskgroup;
SELECT name,
  round(total_mb/1024,2) AS GB_TOTALES,
  round(free_mb/1024,2)  AS FREE_TOTAL_GB,
  round(USABLE_FILE_MB/1024,2)FREE_USABLE_GB,
  round(free_mb/total_mb*100,2) AS "% FREE TOTAL",
  round(USABLE_FILE_MB/total_mb*100,2) AS "% FREE USABLE"
FROM v$asm_diskgroup;

