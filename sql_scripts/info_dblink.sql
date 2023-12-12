-- ===============================================================
-- NAME: info_dblink.sql
-- DESCRIPTION: Search and display info for a specific dblink
-- USAGE: Specify object
-- AUTHOR: Alvaro Anaya
-- ---------------------------------------------------------------
set verify off
col OWNER for a28;
col DB_LINK for a28;
col USERNAME  for a28;
col HOST for a30;
col CREATED  for a12;
col HIDDEN  for a6;
col VALID  for a5;
col INTRA_CDB for a5;
spoo info_&&owner._&&dblink_name..log
select OWNER,DB_LINK, USERNAME ,HOST,CREATED,HIDDEN,VALID,INTRA_CDB
from dba_db_links where owner='&&owner' and db_link='&&dblink_name';
undef owner;
undef objeto;
spoo off

