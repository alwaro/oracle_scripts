-- ===============================================================
-- NAME: schemasize.sql
-- DESCRIPTION: Generates the sentence to displaythe schemasize.
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
spo schemasize.log
select owner, sum(bytes)/1024/1024 tsize
from dba_segments
group by owner
order by tsize desc
/
spo off
