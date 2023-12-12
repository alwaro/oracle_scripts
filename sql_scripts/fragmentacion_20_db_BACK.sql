-- ===============================================================
-- NAME: fragmentacion_20_db.sql
-- DESCRIPTION: Displays 20 most fragmented tables
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
PROMPT
PROMPT LAS 20 TABLAS DE LA BBDD CON MAYOR FRAGMENTACION
PROMPT   (las tablas particionadas se excluyen)
PROMPT --------------------------------------------------_
PROMPT 
SPOO tablas_fragmentadas_en_db.log
SELECT * FROM
(SELECT
    SUBSTR(TABLE_NAME, 1, 28) TABLE_NAME,
    NUM_ROWS,
    AVG_ROW_LEN ROWLEN,
    BLOCKS,
    ROUND((AVG_ROW_LEN + 1) * NUM_ROWS / 1000000, 0) NET_MB,
    ROUND(BLOCKS * (8000 - 23 * INI_TRANS) *
        (1 - PCT_FREE / 100) / 1000000, 0) GROSS_MB,
    ROUND((BLOCKS * (8000 - 23 * INI_TRANS) * (1 - PCT_FREE / 100) -
            (AVG_ROW_LEN + 1) * NUM_ROWS) / 1000000) "WASTED_MB"
    FROM DBA_TABLES
    WHERE
    NUM_ROWS IS NOT NULL AND
    --OWNER LIKE '%ADM_AZKA%' AND
    PARTITIONED = 'NO' AND
    (IOT_TYPE != 'IOT' OR IOT_TYPE IS NULL)
    ORDER BY 7 DESC)
WHERE ROWNUM <=20;
spoo off

