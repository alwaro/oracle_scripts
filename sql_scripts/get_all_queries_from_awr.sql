-- ===============================================================
-- NAME: get_all_queries_form_awr.sql
-- DESCRIPTION: Display a history of queries executed in database
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
set lines 200
set pages 0
set long 9999999
set trimspool on
col sql_id for a14
col sql_text for a150 WORD_WRAPPED
select * from (select sql_id, sql_text from dba_hist_sqltext)
where rownum < 10000;

