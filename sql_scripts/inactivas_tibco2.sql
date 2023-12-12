COL INST_ID FOR 99999
COL MACHINE FOR A30
COL USERNAME FOR A8
select 
inst_id
, username
,sid || ',' || serial# "ID"
,status
,last_call_et/60 "Mins inactivo"
,osuser
,program
,machine
,module
,port
,logon_time	
from   gv$session
where  username='TIBCO2'
and status='INACTIVE'
order by 5 desc;

