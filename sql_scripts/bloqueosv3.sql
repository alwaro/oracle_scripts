-- ===============================================================
-- NAME: bloqueosv3
-- DESCRIPTION: 
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set heading off
set lines 170
SELECT
'_________________________________________________________________________' || CHR(13) || CHR(10) ||
'BLOQUEADOR --> Usuario='||a.username||' SID,serial='||a.sid||','||a.serial#||' Obj='||o3.object_name|| CHR(13) || CHR(10) ||
'   sql="'||c.sql_text||'"'|| CHR(13) || CHR(10) ||
'BLOQUEADO --> Usuario='||b.username||' SID-serial='||b.sid||'-'||b.serial#||' Obj='||o4.object_name || CHR(13) || CHR(10) ||
'   sql="'||d.sql_text||'"'|| CHR(13) || CHR(10) ||
'bloqueado_durante(Seg)='||b.seconds_in_wait || CHR(13) || CHR(10) || CHR(13) || CHR(10)
FROM
 v$session a,
 v$session b,
 v$sqlarea c,
 v$sqlarea d,
 v$lock l1,
 v$lock l2,
 v$locked_object o1,
 v$locked_object o2,
 dba_objects o3,
 dba_objects o4
WHERE
 l1.BLOCK = 1
 AND l2.request > 0
 AND l1.id1 = l2.id1
 AND l1.id2 = l2.id2
 and l1.sid = a.SID
 AND l2.sid = b.SID
 AND a.sql_address = c.address(+)
 AND b.sql_address = d.address
 AND l1.sid = o1.session_id
 AND l2.sid = o2.session_id
 AND o1.object_id = o3.object_id
 AND o2.object_id = o4.object_id
/

