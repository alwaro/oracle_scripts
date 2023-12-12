-- ===============================================================
-- NAME: esperas_cluster.sql
-- DESCRIPTION: Shows wait events
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT instance_number, sql_opname,event, p1, p2, p3,  current_obj#,  COUNT (*) cnt
FROM dba_hist_active_sess_history
WHERE sample_time BETWEEN TIMESTAMP '2020-09-16  08:50:00'
      AND TIMESTAMP '2020-09-16  08:59:00'
  AND wait_class = 'Cluster'
GROUP BY instance_number, event, sql_opname,p1, p2, p3, current_obj#
ORDER BY cnt DESC
/

