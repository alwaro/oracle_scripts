-- ===============================================================
-- NAME: locks2.sql
-- DESCRIPTION: Display locks in db showing serial
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select  'SID ' || l1.sid,l1.serial# ||' is blocking  ' || l2.sid blocking
from    gv$lock l1, gv$lock l2
where   l1.block =1 and l2.request > 0
and     l1.id1=l2.id1
and     l1.id2=l2.id2
/

