col comments for a50
select to_char(ACTION_TIME,'dd.mm.yyyy hh24:mi'), ACTION, VERSION, ID, BUNDLE_SERIES, COMMENTS from  registry$history;

