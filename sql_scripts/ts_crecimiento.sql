-- ===============================================================
-- NAME: ts_crecimiento.sql
-- DESCRIPTION: Displays the growth of the tablespaces
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 2000
set pages 10000
set long 999999
col ts_mb for 999,999,999,999.90
col max_mb for 999,999,999,999.90
col used_mb for 999,999,999,999.90
col last_mb for 999,999,999,999.90
col incr for 999,999.90
set feedback off
alter session set nls_date_format='DD-MM-YYYY HH24:MI:SS';
spoo ts_crecimiento.log
prompt ========================= INFORME DE CRECIMIENTO DE TABLESPACES =========================
  select * from (
  select v.name
,        v.ts#
,        s.instance_number
,        h.tablespace_size
       * p.value/1024/1024              ts_mb
,        h.tablespace_maxsize
       * p.value/1024/1024              max_mb
,        h.tablespace_usedsize
       * p.value/1024/1024              used_mb
,        to_date(h.rtime, 'MM/DD/YYYY HH24:MI:SS') resize_time
,        lag(h.tablespace_usedsize * p.value/1024/1024, 1, h.tablespace_usedsize * p.value/1024/1024)
         over (partition by v.ts# order by h.snap_id) last_mb
,        (h.tablespace_usedsize * p.value/1024/1024)
       - lag(h.tablespace_usedsize * p.value/1024/1024, 1, h.tablespace_usedsize * p.value/1024/1024)
         over (partition by v.ts# order by h.snap_id) incr
    from dba_hist_tbspc_space_usage     h
,        dba_hist_snapshot              s
,        v$tablespace                   v
,        dba_tablespaces                t
,        v$parameter                    p
   where h.tablespace_id                = v.ts#
     and v.name                         = t.tablespace_name
     and t.contents                not in ('UNDO', 'TEMPORARY')
     and p.name                         = 'db_block_size'
     and h.snap_id                      = s.snap_id
         /* For a specific time */
    and s.begin_interval_time          > sysdate - 30
         /* For a specific tablespace */
     --and v.ts# = 1
order by v.name, h.snap_id asc)
   where incr > 0;
set feedback on;
spoo off


