-- ===============================================================
-- NAME: redo_status.sql
-- DESCRIPTION: Displays the status of the redo.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT thread#, dest_id, gvad.status, error, fail_sequence FROM gv$archive_dest gvad, gv$instance gvi WHERE gvad.inst_id = gvi.inst_id AND destination is NOT NULL ORDER BY thread#, dest_id;

