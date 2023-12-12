-- ===============================================================
-- NAME: particiones_tabla.sql
-- DESCRIPTION: Displays the partitions on the selected table.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "size (mb)",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "actual_data (mb)",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "wasted_space (mb)"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = '&NOMBRE_TABLA'
ORDER BY 1 DESC;
UNDEF NOMBRE_TABLA
