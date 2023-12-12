-- ===============================================================
-- NAME: tablespaces.sql
-- DESCRIPTION: Displays a list of tablespaces and their used/full status.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
spool tablespaces4.log
SELECT   ts.tablespace_name
  , 'SQLDEV:GAUGE:0:100:0:0:'
    ||NVL ( ROUND ( ( ( datafile.bytes - NVL ( freespace.bytes, 0 ) ) / datafile.bytes ) * 100, 2 ), 0 ) percent_used
  , ROUND ( ( ( datafile.bytes         - NVL ( freespace.bytes, 0 ) ) / datafile.bytes ) * 100, 2 ) PCT_USED
  , datafile.bytes                     / 1024 / 1024 allocated
  , ROUND ( datafile.bytes             / 1024 / 1024 - NVL ( freespace.bytes, 0 ) / 1024 / 1024, 2 ) used
  , ROUND ( NVL ( freespace.bytes, 0 )  / 1024 / 1024, 2 ) free
  , datafile.datafiles
  FROM dba_tablespaces ts
  , (SELECT   tablespace_name
      , SUM ( bytes ) bytes
      FROM dba_free_space
      GROUP BY tablespace_name
    ) freespace
  , (SELECT   COUNT ( 1 ) datafiles
      , SUM ( bytes ) bytes
      , tablespace_name
      FROM dba_data_files
      GROUP BY tablespace_name
    ) datafile
  WHERE freespace.tablespace_name (+) = ts.tablespace_name
  AND datafile.tablespace_name (+)   = ts.tablespace_name
  ORDER BY NVL ( ( ( datafile.bytes - NVL ( freespace.bytes, 0 ) ) / datafile.bytes ), 0 ) DESC;
spoo off;

