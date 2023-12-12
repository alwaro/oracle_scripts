-- ===============================================================
-- NAME: nls.sql
-- DESCRIPTION: Displays the nls parameters of a database.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
set pages 999
col parameter format a25
col SESSION format a30
col DATABASE  format a30
col INSTANCE  format a30
select * from
(select 'SESSION' SCOPE,nsp.* from nls_session_parameters nsp
union
select 'DATABASE' SCOPE,ndp.* from nls_database_parameters ndp
union
select 'INSTANCE' SCOPE,nip.* from nls_instance_parameters nip
) a
pivot  (LISTAGG(VALUE) WITHIN GROUP (ORDER BY SCOPE)
FOR SCOPE
in ('SESSION' as "SESSION",'DATABASE' as DATABASE,'INSTANCE' as INSTANCE));

