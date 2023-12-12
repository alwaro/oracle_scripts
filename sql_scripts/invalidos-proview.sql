SELECT owner,object_type,object_name,status FROM dba_objects  WHERE status = 'INVALID' and owner not in ('SYS','SYSTEM','TRAFICO','STR2','STRMADMIN') ORDER BY owner, object_type, object_name
/
