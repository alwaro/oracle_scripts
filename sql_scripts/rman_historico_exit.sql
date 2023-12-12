-- ===============================================================
-- NAME: rman_historico_exit.sql
-- DESCRIPTION: Generates a sentece that displays the size of RMAN
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col MB for 99,999,999,999,999.99
col min for 9,999,999,999,999.99
col TOTAL_MB for 99,999,999,999.99
break on report
COMPUTE sum of MB on report
spoo rman_size_time_historico.log
SELECT TRUNC(completion_time) completion_time, type, round(sum(MB),2) MB, round(sum(elapsed_seconds)/60,2) min
FROM (
SELECT
CASE
WHEN s.backup_type='L' THEN 'ARCHIVELOG'
WHEN s.controlfile_included='YES' THEN 'CONTROLFILE'
WHEN s.backup_type='D' AND s.incremental_level=0 THEN 'LEVEL0'
WHEN s.backup_type='I' AND s.incremental_level=1 THEN 'LEVEL1'
WHEN s.backup_type='D' AND s.incremental_level IS NULL THEN 'FULL'
END type,
TRUNC(s.completion_time) completion_time,
round(p.bytes/1048576,2) MB,
s.elapsed_seconds
FROM v$backup_piece p, v$backup_set s
WHERE p.status='A'
AND s.set_stamp = p.set_stamp
AND s.set_count = p.set_count
-- UNION ALL
-- SELECT 'DATAFILECOPY' type, TRUNC(completion_time), output_bytes, 0 elapsed_seconds FROM v$backup_copy_details
)
GROUP BY TRUNC(completion_time), type
ORDER BY 1 asc,2,3
;
SELECT grouping(type) grp, type, round(sum(MB),2) TOTAL_MB
FROM (
SELECT
CASE
WHEN s.backup_type='L' THEN 'ARCHIVELOG'
WHEN s.controlfile_included='YES' THEN 'CONTROLFILE'
WHEN s.backup_type='D' AND s.incremental_level=0 THEN 'LEVEL0'
WHEN s.backup_type='I' AND s.incremental_level=1 THEN 'LEVEL1'
WHEN s.backup_type='D' AND s.incremental_level IS NULL THEN 'FULL'
END type,
TRUNC(s.completion_time) completion_time,
round(p.bytes/1048576,2) MB,
s.elapsed_seconds
FROM v$backup_piece p, v$backup_set s
WHERE p.status='A'
AND s.set_stamp = p.set_stamp
AND s.set_count = p.set_count
-- UNION ALL
-- SELECT 'DATAFILECOPY' type, TRUNC(completion_time), output_bytes, 0 elapsed_seconds FROM v$backup_copy_details
)
GROUP BY ROLLUP(type)
ORDER BY 1 asc,2,3
;
spoo off;
exit;
