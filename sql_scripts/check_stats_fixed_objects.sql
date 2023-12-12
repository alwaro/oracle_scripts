-- ===============================================================
-- NAME: check_fixed_objects_stats.sql
-- DESCRIPTION: Shows statistics for objects
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
alter session set nls_date_format='YYYY-Mon-DD';
col last_analyzed for a13
set termout off
set trimspool off
set feedback off
spool dictionary_statistics

prompt 'Statistics for SYS tables'
SELECT NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed, COUNT(*) dictionary_tables
FROM dba_tables
WHERE owner = 'SYS'
GROUP BY TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 1 DESC;

prompt 'Statistics for Fixed Objects'
select NVL(TO_CHAR(last_analyzed, 'YYYY-Mon-DD'), 'NO STATS') last_analyzed, COUNT(*) fixed_objects
FROM dba_tab_statistics
WHERE object_type = 'FIXED TABLE'
GROUP BY TO_CHAR(last_analyzed, 'YYYY-Mon-DD')
ORDER BY 1 DESC;

spool off

