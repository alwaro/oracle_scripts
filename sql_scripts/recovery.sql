-- ===============================================================
-- NAME: recovery.sql
-- DESCRIPTION: Displays the information about the configuration and usage of the FRA, FLASHBACK and RESTORE POINT
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 300
set pages 999
prompt
prompt =========================================================================================
prompt ==........ CONFIGURACION Y USO DE LA FRA, FLASHBACK Y RESTORE POINTS DE LA BBDD........==
PROMPT =========================================================================================
prompt ______________________________________________________________________________
prompt CONFIGURACION DE LA FRA
prompt ______________________________________________________________________________
prompt
show parameter db_recovery_file
prompt 
prompt ______________________________________________________________________________
prompt INFORMACION DEL ASM
PROMPT ______________________________________________________________________________
prompt
SELECT name, round(total_mb/1024,2) TOTAL_GB, round(free_mb/1024,2)  FREE_GB, round(USABLE_FILE_MB/1024,2)FREE_REAL_GB,  round(free_mb/total_mb*100,2) as "% FREE" FROM v$asm_diskgroup;
PROMPT
prompt ______________________________________________________________________________
PROMPT USO DE LA FRA
PROMPT ______________________________________________________________________________
prompt
select * from v$recovery_area_usage;
prompt 
prompt ______________________________________________________________________________
PROMPT CONFIGURACION DE FLASHBACK y RETENCION
PROMPT ______________________________________________________________________________
prompt
select log_mode,flashback_on from v$database;
prompt
prompt
prompt 
show parameter flashback
prompt
prompt ______________________________________________________________________________
prompt RESTORE POINTS ACTIVADOS
prompt ______________________________________________________________________________
prompt
select name,time,STORAGE_SIZE/1024/1024/1024 as Size_Gb from v$restore_point;
prompt
prompt



