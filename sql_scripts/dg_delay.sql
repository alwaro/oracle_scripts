-- ===============================================================
-- NAME: dg_delay.sql
-- DESCRIPTION: Displays DG status, lag and info
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
select b.name as DB_NAME,
decode(d.gap_status,'NO GAP', 'ACTIVE','BROKEN') as status,
d.gap_status as GAP,
decode(d.recovery_mode,'IDLE','RECOVER PARADO!!!',d.recovery_mode) as recovery_mode,
to_char(next_time, 'dd/mm/yyyy HH24:MI') as last_applied,
       round((sysdate-next_time)*24*60) as delay_min
from (
       select max(first_time) as first_time, max(next_time) as next_time
       from (
              select first_time, next_time
              from v$archived_log
              where sequence#=(select max(sequence#)
                               from v$archived_log
                               where applied='YES'
                                 and thread#=1)
              and thread#=1
              union all
              select first_time, next_time
              from v$archived_log
              where sequence#=(select max(sequence#)
                               from v$archived_log
                               where applied='YES'
                                 and thread#=2)
              and thread#=2
       )
) a,
v$database b,
v$archive_dest_status d
where d.type(+)='PHYSICAL';
