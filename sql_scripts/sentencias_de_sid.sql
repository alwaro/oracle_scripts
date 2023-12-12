-- ===============================================================
-- NAME: sentencias_de_sid.sql
-- DESCRIPTION: Generates a sentence to select de SID from sessions
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
spoo sentencias_sid_&&INTRODUCE_SID..log
select sql_id, count(*), count(*)*100/sum(count(*)) over() pctload from v$active_session_history where sample_time > sysdate - 5/24 and session_id =&&INTRODUCE_SID group by sql_id order by count(*) desc;
spoo off
undef INTRODUCE_SID


