-- ===============================================================
-- NAME: running_transactions.sql
-- DESCRIPTION: Display running transactions
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

SELECT a.sid, a.username, b.xidusn, b.used_urec, b.used_ublk, b.status
  FROM v$session a, v$transaction b
  WHERE a.saddr = b.ses_addr
  order by b.used_urec;
