-- ===============================================================
-- NAME: esperas2.sql
-- DESCRIPTION: Shows wait events
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select

       count(*) cnt,
       o.object_name obj,
       o.object_type otype,
       ash.CURRENT_OBJ#,
       ash.SQL_ID,
       decode(substr(ash.p3,1,1),1,'read',2,'write',p3) p3
from v$active_session_history ash,
      all_objects o
where event='buffer busy waits'
   and o.object_id (+)= ash.CURRENT_OBJ#
group by o.object_name, o.object_type, ash.sql_id, ash.p3,ash.CURRENT_OBJ#
order by cnt
/

