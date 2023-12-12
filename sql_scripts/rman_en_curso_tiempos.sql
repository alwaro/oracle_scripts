-- ===============================================================
-- NAME: rman_en_curso_tiempo.sql
-- DESCRIPTION: Displays info of the time that the RMAN sessions have been active
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT DISTINCT a.*
  FROM (SELECT    DECODE (TRUNC (SYSDATE - LOGON_TIME),
                          0, NULL,
                          TRUNC (SYSDATE - LOGON_TIME) || ' Days' || ' + ')
               || TO_CHAR (
                     TO_DATE (TRUNC (MOD (SYSDATE - LOGON_TIME, 1) * 86400),
                              'SSSSS'),
                     'HH24:MI:SS')
                  LOGON,
               v$session.SID,
               v$session.SERIAL#,
               status,
               v$session.USERNAME,
               v$session.osuser,
               v$session.machine,
               v$session.module,
               MESSAGE,
               ROUND ( (SOFAR / TOTALWORK) * 100, 2) || '%' PERC,
               DECODE (
                  TRUNC (time_remaining / 86400),
                  0, TO_CHAR (TO_DATE (time_remaining, 'SSSSS'),
                              'HH24:MI:SS'),
                     TRUNC (time_remaining / 86400)
                  || ' Days + '
                  || TO_CHAR (
                        TO_DATE (
                             time_remaining
                           - (TRUNC (time_remaining / 86400)) * 86400,
                           'SSSSS'),
                        'HH24:MI:SS'))
                  REMAINING,
               DECODE (
                  TRUNC (ELAPSED_SECONDS / 86400),
                  0, TO_CHAR (TO_DATE (ELAPSED_SECONDS, 'SSSSS'),
                              'HH24:MI:SS'),
                     TRUNC (ELAPSED_SECONDS / 86400)
                  || ' Days + '
                  || TO_CHAR (
                        TO_DATE (
                             ELAPSED_SECONDS
                           - (TRUNC (ELAPSED_SECONDS / 86400)) * 86400,
                           'SSSSS'),
                        'HH24:MI:SS'))
                  ELAPSED,
               sql_text
          FROM v$sql,
               (SELECT *
                  FROM v$session_longops
                 WHERE TIME_REMAINING > 0) v$session_longops,
               v$session
         WHERE     v$session.SID = v$session_longops.SID
               AND v$session_longops.sql_address = v$sql.address(+)
               AND v$session_longops.sql_hash_value = v$sql.hash_value(+)--and v$session.sid = 1644
                                                                         --and osuser = 'kaparelis'
                                                                         --order by address, hash_value, child_number
       ) a;

