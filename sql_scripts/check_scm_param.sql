-- ===============================================================
-- NAME: check_scm_param.sql
-- DESCRIPTION: 
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
col param for a30
col value for a30
select * from (select x.ksppinm param, y.ksppstvl value from x$ksppi x , x$ksppcv y where x.indx = y.indx and x.ksppinm like '\_%' escape '\' order by x.ksppinm) where param='_dlm_stats_collect';

