-- ===============================================================
-- NAME: acls.sql
-- DESCRIPTION: Gets ACLs in a single list
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 210
col PRINCIPAL format a30
col HOST format a30
col ACL format a60
Spoo listado_acls_bbdd_PREBID.log
SELECT PRINCIPAL, HOST, lower_port, upper_port, acl, 'connect' AS PRIVILEGE, 
    DECODE(DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE_ACLID(aclid, PRINCIPAL, 'connect'), 1,'GRANTED', 0,'DENIED', NULL) PRIVILEGE_STATUS
FROM DBA_NETWORK_ACLS
    JOIN DBA_NETWORK_ACL_PRIVILEGES USING (ACL, ACLID)  
UNION ALL
SELECT PRINCIPAL, HOST, NULL lower_port, NULL upper_port, acl, 'resolve' AS PRIVILEGE, 
    DECODE(DBMS_NETWORK_ACL_ADMIN.CHECK_PRIVILEGE_ACLID(aclid, PRINCIPAL, 'resolve'), 1,'GRANTED', 0,'DENIED', NULL) PRIVILEGE_STATUS
FROM DBA_NETWORK_ACLS
    JOIN DBA_NETWORK_ACL_PRIVILEGES USING (ACL, ACLID);
Spoo off;

