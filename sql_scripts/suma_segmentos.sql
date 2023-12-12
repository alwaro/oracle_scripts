-- ===============================================================
-- NAME: suma_segmentos.sql
-- DESCRIPTION: Displays a sum of the space used from dba_segments.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select sum(bytes)/1024/1024/1024 as GB from dba_segments;

