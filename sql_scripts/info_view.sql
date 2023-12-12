-- ===============================================================
-- NAME: info_view.sql
-- DESCRIPTION: Search and display for a specified object
-- USAGE: Specify object
-- AUTHOR:
-- ---------------------------------------------------------------
set verify off
DEF owner='&&1';
DEF vista='&&2';
col OBJECT_NAME format a45
spoo vista_&&owner__&&vista..log
select OWNER,VIEW_NAME,TEXT from dba_views where owner='SCOTT' AND view_name='aaa';
undef owner;
undef vista;
undef 1;
undef 2;
spoo off

