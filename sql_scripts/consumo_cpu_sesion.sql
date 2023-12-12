-- ===============================================================
-- NAME: consumo_cpu_sesion.sql
-- DESCRIPTION: Shows cpu usage values
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT se.username, se.osuser,  ss.sid, ROUND (value/100) "CPU Usage"
FROM v$session se, v$sesstat ss, v$statname st
WHERE ss.statistic# = st.statistic#
   AND name LIKE  '%CPU used by this session%'
   AND se.sid = ss.SID
   AND se.username IS NOT NULL
   AND ROUND (value/100) > 0
  ORDER BY value DESC;

