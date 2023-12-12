-- ===============================================================
-- NAME: crear_snapshot_awr.sql
-- DESCRIPTION: Force snapshot creation
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
BEGIN
DBMS_WORKLOAD_REPOSITORY.CREATE_SNAPSHOT();
END;
/

