-- ===============================================================
-- NAME: locks4kill.sql
-- DESCRIPTION: Display locks in db formating the output in the kill order for them
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
spoo bloqueoss.sql
col id1 for 999999999
col id2 for 999999999
col lmode for 999999999
col request for 999999999
col WAIT_CLASS for a14
col event for a36
col sql_id for a16
col DATOS_DE_SESION for a60
col datos_de_sesion for a70
SELECT DECODE(L.request,0,'- Holder: ','\ Waiter: ')||'Alter system kill session '''||L.sid||','||S.SERIAL#||',@'||L.inst_id||''' immediate;' as  datos_de_sesion,
L.id1, L.id2, L.lmode, L.request,S.sql_id,S.WAIT_CLASS,S.EVENT
FROM GV$LOCK L, gv$session S
WHERE (L.id1, L.id2, L.type) IN
(SELECT id1, id2, type FROM gV$LOCK WHERE request>0)
AND S.sid=L.sid AND
 S.inst_id=L.inst_id
ORDER BY L.id1, L.request;
spoo off;

