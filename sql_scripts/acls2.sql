-- ===============================================================
-- NAME: acls2.sql
-- DESCRIPTION: Gets ACLs in separate views
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col ACL format a50
col PRINCIPAL format a20
col PRIVILEGE format a15
col ACL_OWNER format a15
col START_DATE format a30
col HOST format a15
set lines 300
select ACL,ACLID,PRINCIPAL,PRIVILEGE,ACL_OWNER from dba_network_acl_privileges;
select * from dba_network_acls;
