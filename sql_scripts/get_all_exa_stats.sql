-- ===============================================================
-- NAME: get_all_exa_stats.sql
-- DESCRIPTION: Gets exadata stats
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 180
set pages 10000
col TM2 for a14
col cioub_GB for 999990.99
col cpiobsbsi_GB for 999990.99
col cpioibrbsc_GB for 999990.99
col cpiobefpo_GB for 999990.99
col prtb_GB for 999990.99
col prtbo_GB for 999990.99
col SScan_Eligibility_Rt for 990.99
col Stg_Ix_Filter_Rt for 990.99
col SScan_Eff_Rt for 990.99
col SFC_Rt for 990.99

with estadistics as (
        select
            /*+ PARALLEL */
            id,
            tm,
            tm1,
            dur_min,
            cioub,
            cpiobsbsi,
            cpioibrbsc,
            cpiobefpo,
            prtb,
            prtbo
        from
            (
                select
                    snaps.id,
                    snaps.tm,
                    snaps.tm1,
                    snaps.dur_min,
                    (
                        (
                            sysstat.cioub - lag (sysstat.cioub, 1) over (
                                order by
                                    snaps.id
                            )
                        )
                    ) cioub,
                    (
                        (
                            sysstat.cpiobsbsi - lag (sysstat.cpiobsbsi, 1) over (
                                order by
                                    snaps.id
                            )
                        )
                    ) cpiobsbsi,
                    (
                        (
                            sysstat.cpioibrbsc - lag (sysstat.cpioibrbsc, 1) over (
                                order by
                                    snaps.id
                            )
                        )
                    ) cpioibrbsc,
                    (
                        (
                            sysstat.cpiobefpo - lag (sysstat.cpiobefpo, 1) over (
                                order by
                                    snaps.id
                            )
                        )
                    ) cpiobefpo,
                    (
                        (
                            sysstat.prtb - lag (sysstat.prtb, 1) over (
                                order by
                                    snaps.id
                            )
                        )
                    ) prtb,
                    (
                        (
                            sysstat.prtbo - lag (sysstat.prtbo, 1) over (
                                order by
                                    snaps.id
                            )
                        )
                    ) prtbo
                from
                    (
                        /* DBA_HIST_SNAPSHOT */
                        select
                            distinct id,
                            dbid,
                            tm,
                            to_date(tm, 'dd-mon-yy hh24:mi') tm1,
                            round(max(dur) over (partition by id), 2) dur_min
                        from
                            (
                                select
                                    distinct s.snap_id id,
                                    s.dbid,
                                    to_char(s.end_interval_time, 'DD-MON-RR HH24:MI') tm,
                                    1440 *(
                                        (
                                            cast(s.end_interval_time as date) - lag(cast(s.end_interval_time as date), 1) over (
                                                order by
                                                    s.snap_id
                                            )
                                        )
                                    ) dur
                                from
                                    dba_hist_snapshot s,
                                    v$database d
                                where
                                    s.dbid = d.dbid
                                    and begin_interval_time > sysdate - &&dias -- ultimo / s d í a / s
                            )
                    ) snaps,
                    (
                        /* DBA_HIST_SYSSTAT */
                        select
                            *
                        from
                            (
                                select
                                    snap_id,
                                    dbid,
                                    stat_name,
                                    value
                                from
                                    dba_hist_sysstat
                            ) pivot (
                                sum(value) for (stat_name) in (
                                    'cell IO uncompressed bytes' as cioub,
                                    'cell physical IO bytes saved by storage index' as cpiobsbsi,
                                    'cell physical IO interconnect bytes returned by smart scan' as cpioibrbsc,
                                    'cell physical IO bytes eligible for predicate offload' as cpiobefpo,
                                    'physical read total bytes' as prtb,
                                    'physical read total bytes optimized' as prtbo
                                )
                            )
                   ) sysstat
                where
                    dur_min > 0
                    and snaps.id = sysstat.snap_id
                    and snaps.dbid = sysstat.dbid
            )
    )
select
    to_char(tm1, 'dd-MON-yy hh24') TM2,
    round(sum(cioub) / 1024 / 1024 / 1024, 2) "cioub_GB",
    round(sum(cpiobsbsi) / 1024 / 1024 / 1024, 2) "cpiobsbsi_GB",
    round(sum(cpioibrbsc) / 1024 / 1024 / 1024, 2) "cpioibrbsc_GB",
    round(sum(cpiobefpo) / 1024 / 1024 / 1024, 2) "cpiobefpo_GB",
    round(sum(prtb) / 1024 / 1024 / 1024, 2) "prtb_GB",
    round(sum(prtbo) / 1024 / 1024 / 1024, 2) "prtbo_GB",
    decode(
        sum(prtb),
        0,
        0,
        round(100 / sum(prtb) * sum(cpiobefpo), 2)
    ) "SScan_Eligibility_Rt",
    decode(
        sum(cpiobefpo),
        0,
        0,
        round(100 / sum(cpiobefpo) * sum(cpiobsbsi), 2)
    ) "Stg_Ix_Filter_Rt",
    decode(
        sum(cpiobefpo),
        0,
        0,
        round(100 -((100 / sum(cpiobefpo)) * sum(cpioibrbsc)), 2)
    ) "SScan_Eff_Rt",
    decode(sum(prtb), 0, 0, round(sum(prtbo) / sum(prtb) * 100, 2)) "SFC_Rt"
from
    estadistics
group by
    to_char(tm1, 'dd-MON-yy hh24')
order by
    to_date(to_char(tm1, 'dd-MON-yy hh24'), 'dd-MON-yy hh24');

