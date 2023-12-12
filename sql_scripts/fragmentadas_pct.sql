-- ===============================================================
-- NAME: fragmentadas_pct.sql
-- DESCRIPTION: Displays framentation percent of specified table
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT * FROM
(SELECT
    SUBSTR(TABLE_NAME, 1, 21) TABLE_NAME,
    ROUND((AVG_ROW_LEN + 1) * NUM_ROWS / 1000000, 0) NET_MB,
    ROUND(BLOCKS * (8000 - 23 * INI_TRANS) * (1 - PCT_FREE / 100) / 1000000, 0) as GROSS_MB,
    ROUND((BLOCKS * (8000 - 23 * INI_TRANS) * (1 - PCT_FREE / 100) - (AVG_ROW_LEN + 1) * NUM_ROWS) / 1000000) as WASTED_MB,
    (ROUND((BLOCKS * (8000 - 23 * INI_TRANS) * (1 - PCT_FREE / 100) - (AVG_ROW_LEN + 1) * NUM_ROWS) / 1000000)/ROUND(BLOCKS * (8000 - 23 * INI_TRANS) * (1 - PCT_FREE / 100) / 1000000, 0))*100 as "FRAG_PCT"
    FROM DBA_TABLES
    WHERE
    NUM_ROWS IS NOT NULL AND
    --OWNER LIKE '%ADM_AZKA%' AND
    PARTITIONED = 'NO' AND
    (IOT_TYPE != 'IOT' OR IOT_TYPE IS NULL)
    ORDER BY 4 DESC)
WHERE ROWNUM <=20;

