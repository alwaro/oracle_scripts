-- ===============================================================
-- NAME: licencias.sql
-- DESCRIPTION: Display oracle geatures usage stats
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set pages 999

col c1 heading 'feature'    format a65
col c2 heading 'times|used' format 999,999
col c3 heading 'first|used'
col c4 heading 'used|now'
spoo licencias.log
select
   name             c1,
   detected_usages  c2,
   first_usage_date c3,
   currently_used   c4
from
   dba_feature_usage_statistics
where
   first_usage_date is not null;
spoo off;

