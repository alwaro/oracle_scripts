-- ===============================================================
-- NAME: usuarios_no_oracle.sql
-- DESCRIPTION: Displays info about the users that are not related to oracle.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

@$DBA/f
prompt
prompt ===============================================================================================
prompt                        USUARIOS NO ORACLE EN BBDD
prompt ===============================================================================================
clear breaks
clear computes
set linesize 300
set pagesize 100
set feedback off
select username, account_status, created from dba_users
where username not in ('SYSTEM','SYS','OUTLN','DIP','ORACLE_OCM','DBSNMP','APPQOSSYS','WMSYS','EXFSYS','CTXSYS','XDB','ANONYMOUS','XS$NULL',
'ORDPLUGINS','ORDDATA','MDSYS','ORDSYS','SI_INFORMTN_SCHEMA','OLAPSYS','MDDATA','SPATIAL_WFS_ADMIN_USR',
'SPATIAL_CSW_ADMIN_USR','SYSMAN','MGMT_VIEW','FLOWS_FILES','APEX_PUBLIC_USER','APEX_030200','OWBSYS','OWBSYS_AUDIT','SCOTT'
,'XDB','TRACESVR ','TSMSYS','SYSBACKUP','SYSRAC','OJVMSYS','SYSKM','SYS$UMF','SYSDG','DBSFWUSER','GGSYS','GSMADMIN','GSMCATUSER','REMOTE_SCHEDULER_AGENT','AUDSYS','GSMUSER','GSMADMIN_INTERNAL');
prompt
prompt
prompt
