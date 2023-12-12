-- ===============================================================
-- NAME: memoria_desglose.sql
-- DESCRIPTION: Displays a detailed report on the memory usage of the database.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
COLUMN sum_bytes new_value divide_by noprint
COLUMN percent format 999.99999
SET pages 60 lines 80 feedback off verify off
BREAK on report
COMPUTE sum of bytes on report
COMPUTE sum of percent on report
SELECT SUM (VALUE) sum_bytes
  FROM SYS.v_$sga;
TTITLE left _date center 'SGA Component Sizes Report' skip 2
WITH total_size AS
     (SELECT SUM (VALUE) sum_bytes
        FROM SYS.v_$sga)
SELECT   a.NAME, a.BYTES, a.BYTES / b.sum_bytes * 100 PERCENT
    FROM SYS.v_$sgastat a, total_size b
ORDER BY BYTES ASC
/
CLEAR columns
CLEAR breaks
SET pages 22 lines 80 feedback on verify on
TTITLE off
