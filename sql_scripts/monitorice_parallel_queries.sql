-- ===============================================================
-- NAME: monitorice_parallel_queris.sql
-- DESCRIPTION: Monitors parallel querys.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
col username for a12
col "QC SID" for A6
col "SID" for A6
col "QC/Slave" for A8
col "Req. DOP" for 9999
col "Actual DOP" for 9999
col "Slaveset" for A8
col "Slave INST" for A9
col "QC INST" for A6
set lines 250 pages 5000
col wait_event format a30
select
decode(px.qcinst_id,NULL,username,
' - '||lower(substr(pp.SERVER_NAME,
length(pp.SERVER_NAME)-4,4) ) )"Username",
decode(px.qcinst_id,NULL, 'QC', '(Slave)') "QC/Slave" ,
to_char( px.server_set) "SlaveSet",
to_char(s.sid) "SID",
to_char(px.inst_id) "Slave INST",
decode(sw.state,'WAITING', 'WAIT', 'NOT WAIT' ) as STATE,
case sw.state WHEN 'WAITING' THEN substr(sw.event,1,30) ELSE NULL end as wait_event ,
decode(px.qcinst_id, NULL ,to_char(s.sid) ,px.qcsid) "QC SID",
to_char(px.qcinst_id) "QC INST",
px.req_degree "Req. DOP",
px.degree "Actual DOP"
from gv$px_session px,
gv$session s ,
gv$px_process pp,
gv$session_wait sw
where px.sid=s.sid (+)
and px.serial#=s.serial#(+)
and px.inst_id = s.inst_id(+)
and px.sid = pp.sid (+)
and px.serial#=pp.serial#(+)
and sw.sid = s.sid
and sw.inst_id = s.inst_id
order by
decode(px.QCINST_ID, NULL, px.INST_ID, px.QCINST_ID),
px.QCSID,
decode(px.SERVER_GROUP, NULL, 0, px.SERVER_GROUP),
px.SERVER_SET,
px.INST_ID
/


set lines 250 pages 5000
col wait_event format a30
select
sw.SID as RCVSID,
decode(pp.server_name,
NULL, 'A QC',
pp.server_name) as RCVR,
sw.inst_id as RCVRINST,
case sw.state WHEN 'WAITING' THEN substr(sw.event,1,30) ELSE NULL end as wait_event ,
decode(bitand(p1, 65535),
65535, 'QC',
'P'||to_char(bitand(p1, 65535),'fm000')) as SNDR,
mod(bitand(p1,16711680) , 65535) as SNDRINST,
decode(bitand(p1, 65535),
65535, ps.qcsid,
(select
sid
from
gv$px_process
where
server_name = 'P'||to_char(bitand(sw.p1, 65535),'fm000') and
inst_id = bitand(sw.p1, 16711680) - 65535)
) as SNDRSID,
decode(sw.state,'WAITING', 'WAIT', 'NOT WAIT' ) as STATE
from
gv$session_wait sw,
gv$px_process pp,
gv$px_session ps
where
sw.sid = pp.sid (+) and
sw.inst_id = pp.inst_id (+) and
sw.sid = ps.sid (+) and
sw.inst_id = ps.inst_id (+) and
p1text = 'sleeptime/senderid' and
bitand(p1, 268435456) = 268435456
order by
decode(ps.QCINST_ID, NULL, ps.INST_ID, ps.QCINST_ID),
ps.QCSID,
decode(ps.SERVER_GROUP, NULL, 0, ps.SERVER_GROUP),
ps.SERVER_SET,
ps.INST_ID
/


set lines 250 pages 5000
col "Username" for a12
col "QC/Slave" for A8
col "Slaveset" for A8
col "Slave INST" for A9
col "QC SID" for A6
col "QC INST" for A6
col "operation_name" for A30
col "target" for A30
select
decode(px.qcinst_id,NULL,username,
' - '||lower(substr(pp.SERVER_NAME,
length(pp.SERVER_NAME)-4,4) ) )"Username",
decode(px.qcinst_id,NULL, 'QC', '(Slave)') "QC/Slave" ,
to_char( px.server_set) "SlaveSet",
to_char(px.inst_id) "Slave INST",
substr(opname,1,30) operation_name,
substr(target,1,30) target,
sofar,
totalwork,
units,
start_time,
timestamp,
decode(px.qcinst_id, NULL ,to_char(s.sid) ,px.qcsid) "QC SID",
to_char(px.qcinst_id) "QC INST"
from gv$px_session px,
gv$px_process pp,
gv$session_longops s
where px.sid=s.sid
and px.serial#=s.serial#
and px.inst_id = s.inst_id
and px.sid = pp.sid (+)
and px.serial#=pp.serial#(+)
order by
decode(px.QCINST_ID, NULL, px.INST_ID, px.QCINST_ID),
px.QCSID,
decode(px.SERVER_GROUP, NULL, 0, px.SERVER_GROUP),
px.SERVER_SET,
px.INST_ID
/


set lines 250 pages 5000
col sql_text for a50
col sid for 99999
col status for a11
col slv_req for 99999
col slv_alloc for 99999
col sql_id format a16 
col secs_in_q for 99999 
SELECT sql_id, sid, 
session_serial# sess#,
status ,
px_servers_requested slv_req,
px_servers_allocated slv_alloc,
substr(sql_text,1,50)||'...' sql_text,
queuing_time/1000000 secs_in_q
FROM gv$sql_monitor
WHERE status in ('QUEUED','EXECUTING') and sql_text is not null
ORDER BY status desc, secs_in_q desc, sql_id
/

