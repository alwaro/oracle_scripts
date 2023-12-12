-- ===============================================================
-- NAME: contenido_sysaux.sql
-- DESCRIPTION: show sysaux objects
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
set pages 999
col SEGMENT_NAME format a40
col SEGMENT_type format a30
SELECT
sum(bytes/1024/1024) Mb,
segment_name,
segment_type
FROM
dba_segments
WHERE
tablespace_name = 'SYSAUX'
AND
segment_type in ('INDEX','TABLE')
and 
rownum < 20
GROUP BY
segment_name,
segment_type
ORDER BY Mb DESC;

