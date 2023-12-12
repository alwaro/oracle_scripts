-- ===============================================================
-- NAME: listar_cambios_plan_24h.sql
-- DESCRIPTION: Display sql_ids with changes in plan hash value
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set line 300
col PARSING_SCHEMA_NAME for a30
col action for a40
SELECT ACTION, PARSING_SCHEMA_NAME, PARSING_USER_ID, sql_id, COUNT(1) CUENTA         
FROM   
(              
select ACTION, PARSING_SCHEMA_NAME, PARSING_USER_ID, ss.sql_id, ss.PLAN_HASH_VALUE,  COUNT(1) OVER (PARTITION BY ACTION, PARSING_SCHEMA_NAME, PARSING_USER_ID, ss.sql_id) NUM_PLANES,            
sum(executions_DELTA),             
trunc(sum(ELAPSED_TIME_DELTA)/(sum(decode(executions_delta,0,1))*1000)) "Elapsed Average ms", 
trunc(sum(CPU_TIME_DELTA)/(sum(decode(executions_delta,0,1))*1000)) "CPU Average ms", 
trunc(sum(IOWAIT_DELTA)/(sum(decode(executions_delta,0,1))*1000)) "IO Average ms",          
trunc(sum(BUFFER_GETS_DELTA)/sum(decode(executions_delta,0,1))) "Average buffer gets",  
trunc(sum(DISK_READS_DELTA)/sum(decode(executions_delta,0,1))) "Average disk reads"         
from DBA_HIST_SQLSTAT ss, DBA_HIST_SNAPSHOT sn  
where ss.snap_id=sn.snap_id
--and ss.action IN ('USP_COMC_AGGR_STK_CD_CMPORDSAL','USP_COMC_CSTKAG_TND_DG_FEC_MC')             
and ss.dbid=sn.dbid       
and ss.instance_number=sn.instance_number  
and begin_interval_time>sysdate-1                 -- **** SE ANALIZAN LOS ULTIMOS X DIAS  ****  
and action not like '%ORA$AT%'
group by ACTION, PARSING_SCHEMA_NAME, PARSING_USER_ID, ss.sql_id, ss.PLAN_HASH_VALUE         
)              
WHERE NUM_PLANES>1    --  ***** MAS DE 2 PLANES DISTINTOS PARA LA MISMA SENTENCIA ****
GROUP BY ACTION, PARSING_SCHEMA_NAME, PARSING_USER_ID, sql_id           
order by CUENTA DESC; 

