-- ===============================================================
-- NAME: sumatorio_particiones-todas.sql
-- DESCRIPTION: Displays a sum of the space of the tables with partitions.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
-- VERSION BUENA RHO
COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'RHO'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


-- VERSION BUENA HES
COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'HES'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


-- VERSION BUENA CBC
COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'CBC'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;

COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'BUL'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;




COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'CBS'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'CEC'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'CLR'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'DID'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'HIN'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'HUC'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'REF'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'TRZC'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'TRZL'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'TSE'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


COL TABLE_NAME FOR A10
COL PARTITION_NAME FOR A14
clear breaks
clear computes
compute sum label "TOTAL MB" of Fragmentado_Mb on report
break on report
SELECT table_name,
    partition_name,
    ROUND ( (blocks / 1024 * 16), 2) "Total_Mb",
    ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2) "Datos_Mb",
    (  ROUND ( (blocks / 1024 * 16), 2) - ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2)) "Fragmentado_Mb"
    FROM dba_tab_partitions
   WHERE (ROUND ( (blocks / 1024 * 16), 2) >
 ROUND ( (num_rows * avg_row_len / 1024 / 1024), 2))
 AND table_name = 'TSI'
 AND TABLE_OWNER='TRAFICO'
ORDER BY partition_name;


