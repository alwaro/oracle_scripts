-- ===============================================================
-- NAME: redo_in_timel.sql
-- DESCRIPTION: Displays redo by time
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set feedback off
compute sum label 'TOTAL_ARCH_30_DIAS' of TOTAL on report
break on report
set lines 180
col 00h format 99999
col 01h format 99999
col 02h format 99999
col 03h format 99999
col 04h format 99999
col 05h format 99999
col 06h format 99999
col 07h format 99999
col 08h format 99999
col 09h format 99999
col 10h format 99999
col 11h format 99999
col 12h format 99999
col 13h format 99999
col 14h format 99999
col 15h format 99999
col 16h format 99999
col 17h format 99999
col 18h format 99999
col 19h format 99999
col 20h format 99999
col 21h format 99999
col 22h format 99999
col 23h format 99999
select
 to_char(first_time,'YYYY-MM-DD') day,
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'00',1,0)),'999') "00h",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'01',1,0)),'999') "01h",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'02',1,0)),'999') "02h",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'03',1,0)),'999') "03h",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'04',1,0)),'999') "04h",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'05',1,0)),'999') "05h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'06',1,0)),'999') "06h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'07',1,0)),'999') "07h",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'08',1,0)),'999') "08h",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'09',1,0)),'999') "09h",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'10',1,0)),'999') "10h",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'11',1,0)),'999') "11h",
 to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'12',1,0)),'999') "12h",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'13',1,0)),'999') "13h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'14',1,0)),'999') "14h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'15',1,0)),'999') "15h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'16',1,0)),'999') "16h",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'17',1,0)),'999') "17h",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'18',1,0)),'999') "18h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'19',1,0)),'999') "19h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'20',1,0)),'999') "20h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'21',1,0)),'999') "21h",
   to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'22',1,0)),'999') "22h",
  to_char(sum(decode(substr(to_char(first_time,'HH24'),1,2),'23',1,0)),'999') "23h",
   COUNT(*) TOTAL
   from v$log_history where first_time>sysdate-30
 group by to_char(first_time,'YYYY-MM-DD')
 order by day desc;
set feedback on;

