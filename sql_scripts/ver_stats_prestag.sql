select owner, table_name,LAST_ANALYZED,STATTYPE_LOCKED,STALE_STATS 
from dba_tab_statistics where owner in ('USR_TGN','USR_TGN_SNAP_DEF','USR_TGN_SNAP_PRO')
and LAST_ANALYZED > sysdate-1 order by LAST_ANALYZED asc;

