-- ===============================================================
-- NAME: estimacion_archivado_diario.sql
-- DESCRIPTION: Displays daily archive count
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT to_char(first_time,'DD-MON-YYYY'), count(*) as cantidad
 FROM v$loghist
 WHERE first_time > '01-NOV-2020'
 GROUP BY to_char(first_time,'DD-MON-YYYY')
 ORDER BY to_char(first_time,'DD-MON-YYYY') asc;
