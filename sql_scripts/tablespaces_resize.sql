-- ===============================================================
-- NAME: tablespaces_resize.sql
-- DESCRIPTION: After giving a percentage and a tablespace name it gives you the free space you can use
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

SET PAGESIZE 60
SET LINESIZE 300
COLUMN "TABLESPACE_NAME" FORMAT A20
COLUMN "AUTOEXTEND" FORMAT A10
COLUMN "FILE_NAME" FORMAT A80
COLUMN "SIZE MB" FORMAT 9999999999

  SELECT B.TABLESPACE_NAME,
         B.FILE_NAME,
         ROUND (B.BYTES / 1024 / 1024, 2) "SIZE MB",
		 ROUND (SUM (A.BYTES) / 1024 / 1024, 2) "FREE SPACE MB",
		 B.AUTOEXTENSIBLE "AUTOEXTEND",
	 ROUND ((B.BYTES / 1024 / 1024) - ((B.BYTES / 1024 / 1024) * &PERCENT / 100) + (B.BYTES / 1024 / 1024) ,2) "SIZE MB TO INCREASE",
         ROUND (B.MAXBYTES / 1024 / 1024, 2) "MAX SIZE MB (IF AUTOEXT ON)",
         CASE
            WHEN MAXBYTES = 0
            THEN
               ROUND (SUM (A.BYTES) / 1024 / 1024, 2)
            ELSE
               ROUND (
                    ( (B.MAXBYTES - B.BYTES) + SUM (A.BYTES)) / 1024 / 1024, 2)
         END
            "MAX FREE SPACE (IF AUTOEXT ON)"
    FROM DBA_FREE_SPACE A, DBA_DATA_FILES B
   WHERE A.FILE_ID = B.FILE_ID AND B.TABLESPACE_NAME IN ('&TBS_NAME')
GROUP BY B.TABLESPACE_NAME,
		 B.AUTOEXTENSIBLE,
         B.FILE_NAME,
         B.BYTES,
         B.MAXBYTES
ORDER BY 1, 2;
