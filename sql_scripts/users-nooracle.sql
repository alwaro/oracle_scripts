-- ===============================================================
-- NAME: users-nooracle.sql
-- DESCRIPTION: Displays info from all users but not oracle users
-- USAGE: Execute
-- AUTHOR: Alvaro
-- ---------------------------------------------------------------
SET LINES 300
col username FOR a25
col ac_status FOR a10
col default_tablespace for a35
col profile FOR a30
col OBJECT_NAME format a45
spoo users-nooracle.log
SELECT username, account_status,lock_date, expiry_date,created, default_tablespace,profile,  password_versions FROM dba_users WHERE username not in ('SYSTEM','SYS','SYSRAC','OJVMSYS','SYSKM','OUTLN','SYS$UMF','SYSDG','APPQOSSYS','DBSFWUSER','GGSYS','CTXSYS','APEX_030200','SI_INFORMTN_SCHEMA','ORDPLUGINS','GSMADMIN_INTERNAL','APEX_050000','MDSYS','OLAPSYS','ORDDATA','XDB','WMSYS','ORDSYS','DBSNMP','ANONYMOUS','FLOWS_FILES','OWBSYS','OWBSYS_AUDIT','GSMCATUSER','REMOTE_SCHEDULER_AGENT','GSMUSER','AUDSYS','DIP','ORACLE_OCM','XS$NULL','APEX_PUBLIC_USER','MDDATA','SYSBACKUP');
spoo off
