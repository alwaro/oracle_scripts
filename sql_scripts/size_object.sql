-- ===============================================================
-- NAME: size_object.sql
-- DESCRIPTION: Displays info about the size of objects in dba_segments.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
column object_name format a40
select segment_name OBJECT_NAME, sum(bytes)/1024/1024 SIZE_MB from dba_segments where segment_name like '%&OBJECT_NAME%' group by segment_name
/
