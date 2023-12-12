-- ===============================================================
-- NAME: sumatorio_particiones.sql
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
 AND partition_name like 'BUL08%' OR partition_name like 'BUL07%' OR partition_name like 'BUL06%' OR partition_name like 'BUL05%'
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
 AND partition_name like 'CBS08%' OR partition_name like 'CBS07%' OR partition_name like 'CBS06%' OR partition_name like 'CBS05%'
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
 AND partition_name like 'CEC08%' OR partition_name like 'CEC07%' OR partition_name like 'CEC06%' OR partition_name like 'CEC05%'
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
 AND partition_name like 'CLR08%' OR partition_name like 'CLR07%' OR partition_name like 'CLR06%' OR partition_name like 'CLR05%'
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
 AND partition_name like 'DID08%' OR partition_name like 'DID07%' OR partition_name like 'DID06%' OR partition_name like 'DID05%'
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
 AND partition_name like 'HIN08%' OR partition_name like 'HIN07%' OR partition_name like 'HIN06%' OR partition_name like 'HIN05%'
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
 AND partition_name like 'HUC08%' OR partition_name like 'HUC07%' OR partition_name like 'HUC06%' OR partition_name like 'HUC05%'
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
 AND partition_name like 'REF08%' OR partition_name like 'REF07%' OR partition_name like 'REF06%' OR partition_name like 'REF05%'
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
 AND partition_name like 'TRZC08%' OR partition_name like 'TRZC07%' OR partition_name like 'TRZC06%' OR partition_name like 'TRZC05%'
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
 AND partition_name like 'TRZL08%' OR partition_name like 'TRZL07%' OR partition_name like 'TRZL06%' OR partition_name like 'TRZL05%'
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
 AND partition_name like 'TSE08%' OR partition_name like 'TSE07%' OR partition_name like 'TSE06%' OR partition_name like 'TSE05%'
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
 AND partition_name like 'TSI08%' OR partition_name like 'TSI07%' OR partition_name like 'TSI06%' OR partition_name like 'TSI05%'
ORDER BY partition_name;


