-- ===============================================================
-- NAME: list_particiones_size.sql
-- DESCRIPTION: Display partition size from an specific table
-- USAGE: Ask table_name
-- AUTHOR:
-- ---------------------------------------------------------------
rem
rem Name: tab_subpart.sql
rem Function : Report on partitioned table structure
rem
PROMPT ============= script en curso, aun no saca size ============
prompt ____________________________________________________________
COLUMN table_owner NEW_VALUE owner1 NOPRINT
COLUMN table_name FORMAT a15 HEADING 'Table'
COLUMN partition_name FORMAT a15 HEADING 'Partition'
COLUMN tablespace_name FORMAT a15 HEADING 'Tablespace'
COLUMN initial_extent FORMAT 9,999 HEADING 'Initial|Extent (K)'
COLUMN next_extent FORMAT 9,999 HEADING 'Next|Extent (K)'
COLUMN pct_increase FORMAT 999 HEADING 'PCT|Increase'
SET LINES 130
ttitle 'Table Sub-Partition Files For &owner1'
BREAK ON table_owner ON table_name ON partition_name
SPOOL particiones_&&NOMBRE_TABLA..log
SELECT
table_owner,
table_name,
partition_name,
tablespace_name,
logging,
initial_extent/1024 initial_extent,
next_extent/1024 next_extent,
pct_increase
FROM dba_tab_partitions
where table_name='&&NOMBRE_TABLA'
ORDER BY table_owner,table_name,partition_name
/
spoo off;
undef NOMBRE_TABLA
