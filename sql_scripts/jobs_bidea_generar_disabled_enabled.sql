prompt =================================================================================
prompt  Esta es la lista de jobs de trafico en estado enabled ANTES de la intervencion
prompt =================================================================================
prompt
set feedback off
set heading off
alter session set nls_date_format='DD-MON-YYYY HH24:MI:SS';
select 'Script generado con fecha '|| sysdate ||'' from dual;
prompt
select  distinct job_name from dba_scheduler_jobs where owner='TRAFICO' and ENABLED='TRUE';
prompt
prompt
set heading off
set feedback off
prompt GENERANDO LISTA DE SENTENCIAS DE REACTIVACION...
spoo jobs_bidea_intervencion_reactivar.sql
select 'execute dbms_scheduler.enable(' || '''' ||owner ||'.' ||job_name ||'''' ||');'  from dba_scheduler_jobs where owner='TRAFICO' and ENABLED='TRUE' and JOB_NAME NOT IN ('JOB_SINC_PRO_RUTAS','JOB_SALIDAS_OLD_NO_ARRANCAR');
spoo off
PROMPT
PROMPT GENERANDO LISTA DE SENTENCIAS DE DESACTIVACION...
spoo jobs_bidea_intervencion_desactivar.sql
select 'execute dbms_scheduler.disable(' || '''' ||owner ||'.' ||job_name ||'''' ||');'  from dba_scheduler_jobs where owner='TRAFICO' and ENABLED='TRUE' and JOB_NAME NOT IN ('JOB_SINC_PRO_RUTAS','JOB_SALIDAS_OLD_NO_ARRANCAR');
spoo off;
set feedback on;
set heading on;
prompt ==========================================================================================
prompt   Se han generado 2 scripts, uno para desactivar estos jobs y otro para activarlos de nuevo
prompt     AMBOS SCRIPTS IGNORAN LOS JOBS:
prompt              JOB_SINC_PRO_RUTAS
prompt              JOB_SALIDAS_OLD_NO_ARRANCAR
prompt
prompt Script para desactivar esos jobs:
prompt =======================================
prompt [dir de invocacion de script] \ jobs_bidea_intervencion_desactivar.sql
prompt
prompt Script para reactivar esos jobs:
prompt =======================================
prompt [dir de invocacion de script] \ jobs_bidea_intervencion_reactivar.sql
prompt
prompt
prompt Ejecutelos segun necesite activar o desactivar los jobs de la lista
prompt
prompt

