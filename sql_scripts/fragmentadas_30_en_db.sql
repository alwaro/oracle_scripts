set lines 200
set pages 999
col TABLE_NAME for a26
PROMPT
PROMPT LAS 30 TABLAS DE LA BBDD CON MAYOR FRAGMENTACION
PROMPT   (las tablas particionadas se excluyen)
PROMPT ------------------------------------------------_
PROMPT
SPOO fragmentadas_30_en_db.log
SELECT * FROM
(SELECT
    SUBSTR(OWNER, 1, 11) OWNER,
    SUBSTR(TABLE_NAME, 1, 26) TABLE_NAME,
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
    ORDER BY 8 DESC)
WHERE ROWNUM <=30;
spoo off

