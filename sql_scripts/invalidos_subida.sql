SELECT owner,object_type,object_name,status FROM dba_objects
WHERE status = 'INVALID' AND owner NOT IN('PUBLIC','SYSTEM','SYS','LINCE','LINCETEMP') ORDER BY owner, object_type, object_name
/
