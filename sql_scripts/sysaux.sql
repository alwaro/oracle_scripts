-- ===============================================================
-- NAME: sysaux.sql
-- DESCRIPTION: Displays detailed info of the SYSAUX and the components like AWR or STATS
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
spo def_sysaux.log
prompt
prompt =========================================================================
prompt  SCRIPT PARA MOSTRAR TODA LA INFORMACION DEL SYSAUX Y DE LOS COMPONENTES
PROMPT     QUE EN EL SE GUARDAN POR DEFECTO COMO RETENCIONES AWR O STATS
prompt =========================================================================
PROMPT
PROMPT CONTENIDO DEL SYSAUX Y METODO PARA MOVER CADA TIPO DE DATO 
PROMPT __________________________________________________________________________
set linesize 200
set pagesize 999
COLUMN "Item" FORMAT A25
COLUMN "Space Used (GB)" FORMAT 999.99
COLUMN "Schema" FORMAT A25
COLUMN "Move Procedure" FORMAT A40

SELECT  occupant_name "Item",
        space_usage_kbytes/1048576 "Space Used (GB)",
        schema_name "Schema",
        move_procedure "Move Procedure"
FROM v$sysaux_occupants
ORDER BY 1
/
PROMPT
PROMPT
PROMPT
PROMPT ============================================================================
PROMPT    DETALLE CON SUMATORIO DE LOS COMPONENTES Y SU SIZE POR SEPARADO
PROMPT ============================================================================
break on report
compute sum OF MB on report
select occupant_desc, space_usage_kbytes/1024 MB
from v$sysaux_occupants
where space_usage_kbytes > 0
order by space_usage_kbytes;
prompt
PROMPT
prompt DIAS DE RETENCION DE LAS ESTADISTICAS (historicos)
PROMPT __________________________________________________________________________
select dbms_stats.get_stats_history_retention from dual;
prompt
PROMPT
PROMPT
PROMPT =========================================================================
PROMPT INFORMACION SOBRE EL AWR
PROMPT =========================================================================
prompt
SELECT extract(day from snap_interval) *24*60+extract(hour from snap_interval) *60+extract(minute from snap_interval) snapshot_Interval,extract(day from retention) *24*60+extract(hour from retention) *60+extract(minute from retention) retention_Interval FROM dba_hist_wr_control;
prompt
prompt
prompt
prompt =========================================================================
prompt  LISTA DE LOS 10 OBJETOS MAS GRANDES
PROMPT =========================================================================
col MB for 999G990
col blocks for 9999999999
col segment_name for a30
col partition_name for a30
col segment_type for a20
col tablespace_name for a20
select * from (
               select bytes/1024/1024 MB, blocks, s.SEGMENT_NAME, s.partition_name, s.segment_type, s.tablespace_name
                 from dba_segments s
                where owner='SYS'
             order by bytes desc
)
where rownum <=10;

spool off

