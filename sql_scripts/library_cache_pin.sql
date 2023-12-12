-- ===============================================================
-- NAME: library_cache_pin.sql
-- DESCRIPTION: 
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
set pages 100
select decode(lob.kglobtyp, 0, 'NEXT OBJECT', 1, 'INDEX', 2, 'TABLE', 3, 'CLUSTER',
                      4, 'VIEW', 5, 'SYNONYM', 6, 'SEQUENCE',
                      7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
                      11, 'PACKAGE BODY', 12, 'TRIGGER',
                      13, 'TYPE', 14, 'TYPE BODY',
                      19, 'TABLE PARTITION', 20, 'INDEX PARTITION', 21, 'LOB',
                      22, 'LIBRARY', 23, 'DIRECTORY', 24, 'QUEUE',
                      28, 'JAVA SOURCE', 29, 'JAVA CLASS', 30, 'JAVA RESOURCE',
                      32, 'INDEXTYPE', 33, 'OPERATOR',
                      34, 'TABLE SUBPARTITION', 35, 'INDEX SUBPARTITION',
                      40, 'LOB PARTITION', 41, 'LOB SUBPARTITION',
                      42, 'MATERIALIZED VIEW',
                      43, 'DIMENSION',
                      44, 'CONTEXT', 46, 'RULE SET', 47, 'RESOURCE PLAN',
                      48, 'CONSUMER GROUP',
                      51, 'SUBSCRIPTION', 52, 'LOCATION',
                      55, 'XML SCHEMA', 56, 'JAVA DATA',
                      57, 'SECURITY PROFILE', 59, 'RULE',
                      62, 'EVALUATION CONTEXT',
                     'UNDEFINED') object_type,
       lob.KGLNAOBJ object_name,
       pn.KGLPNMOD lock_mode_held,
       pn.KGLPNREQ lock_mode_requested,
       ses.sid,
       ses.serial#,
       ses.username
  FROM
       x$kglpn pn,
       v$session ses,
       x$kglob lob,
       v$session_wait vsw
  WHERE
   pn.KGLPNUSE = ses.saddr and
   pn.KGLPNHDL = lob.KGLHDADR
   and lob.kglhdadr = vsw.p1raw
   and vsw.event = 'library cache pin'
order by lock_mode_held desc
/
