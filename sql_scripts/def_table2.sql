-- ===============================================================
-- NAME: def_table2.sql
-- DESCRIPTION: Show info of table
-- USAGE: Specify table and owner
-- AUTHOR:
-- ---------------------------------------------------------------
set echo off
set scan on
set lines 150
set pages 66
set verify off
set feedback off
set termout off
column uservar new_value Table_Owner noprint
select user uservar from dual;
set termout on
set timing off

undefine v_owner
undefine v_table_name

prompt "1er parametro = owner" 
prompt "2do parametro = table_name"
prompt ============================

define v_owner = &1
define v_table_name = &2

prompt

column IOT_TYPE heading "IOT|Type" format a12
column TABLE_NAME heading "Table|Name" format a30
column PARTITION_NAME heading "Partition|Name" format a30
column SUBPARTITION_NAME heading "SubPartition|Name" format a30
column NUM_ROWS heading "Number|of Rows" format 9999,999990
column rows-nulls  format 9999,999990
column BLOCKS heading "Blocks" format 99,999990
column Bloq_opt format 9,999990
column EMPTY_BLOCKS heading "Empty|Blocks" format 999,999990

column AVG_SPACE heading "Average|Space" format 9,990
column CHAIN_CNT heading "Chain|Count" format 999,990
column AVG_ROW_LEN heading "Average|Row Len" format 990
column COLUMN_NAME  heading "Column|Name" format a25
column NULLABLE heading Null|able format a4
column NUM_DISTINCT heading "Distinct|Values" format 9999,999990
column NUM_NULLS heading "Number|Nulls" format 9999,999990
column NUM_BUCKETS heading "Number|Buckets" format 990
column DENSITY heading "Density" format 990
column INDEX_NAME heading "Index|Name" format a30
column PARTITIONING_TYPE heading "Partitioning|Type" format a15
column SUBPARTITIONING_TYPE heading "Subpartitioning|Type" format a15
column indice heading "Index|Name" format a30
column UNIQU heading "Uni|que" format a3
column BLEV heading "B|Level" format 90
column LEAF_BLOCKS heading "Leaf|Blks" format 99,999990
column DISTINCT_KEYS heading "Distinct|Keys" format 9999,999990
column AVG_LEAF_BLOCKS_PER_KEY heading "Av Leaf|Blocks|Per Key" format 999990
column AVG_DATA_BLOCKS_PER_KEY heading "Av Data|Blocks|Per Key" format 999990
column CLUSTERING_FACTOR heading "Cluster|Factor" format 999,999,990
column COLUMN_POSITION heading "Col|Pos" format 990
column SUBPARTITION_POSITION heading "Sub|Pos" format 990
column col heading "Column|Details" format a24
column COLUMN_LENGTH heading "Col|Len" format 9,990
column PARTITION_COUNT heading "Parti|count" format 9,990
column GLOBAL_STATS heading "Global|Stats" format a6
column LOCALITY heading "Local|Global" format a6
column USER_STATS heading "User|Stats" format a6
column SAMPLE_SIZE heading "Sample|Size" format 999,999,990
column to_char(t.last_analyzed,'MM-DD-YYYY') heading "Date|MM-DD-YYYY" format a10

col AVG_Row_key format 999,999,999
col "%opt"      format a5
col indice      format a25
col num_nulos   format a12
col histogram heading histg format a6
col DEG format a3
col COLUMN_NAME2 format a15
col "nulos"     format a5

spool datos_&&v_Table_name

prompt
prompt ***********
prompt OWNER : &&v_owner
prompt TABLE : &&v_table_name
prompt ***********
prompt

prompt
prompt ***********
prompt Table Level
prompt ***********
prompt
select distinct
    IOT_TYPE,
    NUM_ROWS,
    BLOCKS,
    CEIL((AVG_ROW_LEN*NUM_ROWS)/tam_bloque) as bloq_opt,
    CEIL((BLOCKS - CEIL((AVG_ROW_LEN*NUM_ROWS)/tam_bloque) ) * 100 / CEIL((AVG_ROW_LEN*NUM_ROWS)/tam_bloque) )||'%' as "%opt",
    EMPTY_BLOCKS,
    AVG_SPACE,
    CHAIN_CNT,
    AVG_ROW_LEN,
    GLOBAL_STATS,
    USER_STATS,
    SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY') as analyzed, 
    substr(trim(DEGREE),1,3) deg
from dba_tables t,
   (Select ts.block_size-(ts.block_size*pct_free/100)as tam_bloque  -- restamos pctfree para saber cuanto bloque util hay
    from dba_tablespaces ts, dba_tables t
    where ts.tablespace_name in 
        (select tablespace_name 
         from dba_segments s 
         where s.segment_name=upper('&&v_Table_name') 
           and s.owner=upper(nvl('&&v_Owner',user))
        )
     and t.table_name=upper('&&v_Table_name')
     and t.owner=upper(nvl('&&v_Owner',user))
    ) bloque 
where owner = upper(nvl('&&v_Owner',user))
  and table_name = upper('&&v_Table_name')
/

select
    tc.COLUMN_NAME,
    decode(tc.DATA_TYPE,
           'NUMBER',tc.DATA_TYPE||'('||
           decode(tc.DATA_PRECISION,
                  null,tc.DATA_LENGTH||')',
                  tc.DATA_PRECISION||','||tc.DATA_SCALE||')'),
                  'DATE',tc.DATA_TYPE,
                  'LONG',tc.DATA_TYPE,
                  'LONG RAW',tc.DATA_TYPE,
                  'ROWID',tc.DATA_TYPE,
                  'MLSLABEL',tc.DATA_TYPE,
                  tc.DATA_TYPE||'('||tc.DATA_LENGTH||')') ||' '||
    decode(tc.nullable,
              'N','NOT NULL',
              'n','NOT NULL',
              NULL) col,
    tc.NUM_DISTINCT, tc.DENSITY, tc.NUM_BUCKETS, tc.NUM_NULLS
    ,(tab.num_rows - tc.num_nulls) as "rows-nulls"
    , CEIL(DECODE(tc.NUM_DISTINCT,0,NULL,((tab.num_rows - tc.num_nulls)/tc.NUM_DISTINCT))) as AVG_Row_key
    , DECODE (col.histogram,'HEIGHT BALANCED','HEIG_B','FREQUENCY','FREQ',col.histogram) as histogram
from dba_tab_columns tc, dba_tables tab, dba_tab_col_statistics col
where tc.table_name = upper('&&v_Table_name')
  and tc.owner = upper(nvl('&&v_Owner',user))
  and tc.table_name=tab.table_name
  and tc.owner=tab.owner
  and tc.owner=col.owner(+)
  and tc.table_name=col.table_name(+)
  and tc.column_name=col.column_name(+)
order by tc.NUM_DISTINCT
/

col analyzed format a10
select 
    i.INDEX_NAME,
    DECODE(i.UNIQUENESS,'UNIQUE','YES','NOT') UNIQU,
    i.BLEVEL BLev,
    i.LEAF_BLOCKS,
    i.DISTINCT_KEYS,
    i.NUM_ROWS,
    i.AVG_LEAF_BLOCKS_PER_KEY,
    i.AVG_DATA_BLOCKS_PER_KEY,
    i.GLOBAL_STATS, i.PREFIX_LENGTH as "compress",
    to_char(i.last_analyzed,'MM-DD-YYYY') as analyzed,
    nvl(p.LOCALITY,'GLOBAL') as "¿LOCAL?",
    substr(trim(DEGREE),1,3) deg, substr(VISIBILITY,1,3) VIS
from 
    dba_indexes i,
    dba_part_indexes p
where i.table_name = upper('&&v_Table_name')
  and i.table_owner = upper(nvl('&&v_Owner',user))
  and i.index_name = p.index_name(+)  
/

with maxind as
(select INDEX_NAME indice, max(ic.COLUMN_POSITION) pos
 from dba_ind_columns ic
 where ic.table_name = upper('&&v_Table_name')
   and ic.table_owner= upper('&&v_owner')
 group by INDEX_NAME
), ind_col_fn as
(select ic.table_name, ic.index_name, ic.index_owner, ic.table_owner, ic.column_position, ic.column_name, if.COLUMN_EXPRESSION column_name2
 from dba_ind_columns ic, 
      DBA_IND_EXPRESSIONS if
where ic.table_name = upper('&&v_Table_name')
  and ic.table_owner= upper('&&v_owner')
  and ic.table_name=if.table_name(+)
  and ic.index_name=if.index_name(+)
  and ic.index_owner=if.index_owner(+)
  and ic.table_owner=if.table_owner(+)
  and ic.column_position=if.column_position(+)
)
select DECODE(COLUMN_POSITION,1,ic.INDEX_NAME,NULL) indice, ic.COLUMN_NAME, ic.COLUMN_POSITION
    , col.AVG_COL_LEN, col.NUM_DISTINCT, DECODE(col.NULLABLE,'N','NO   ','SI   ') as "nulos"
    , DECODE(ic.COLUMN_POSITION,maxind.pos,col.num_nulls||CHR(10)||CHR(13),col.num_nulls) as "num_nulos"
    ,(tab.num_rows - col.num_nulls) as "rows-nulls"
    , CEIL(DECODE (col.NUM_DISTINCT,0,NULL,((tab.num_rows - col.num_nulls)/col.NUM_DISTINCT))) as AVG_Row_key
    , DECODE (col.histogram,'HEIGHT BALANCED','HEIG_B','FREQUENCY','FREQ',col.histogram) as histogram
    , ic.column_name2
from ind_col_fn ic, 
     dba_tab_columns col, 
     dba_tables tab, 
     maxind
where ic.table_name = upper('&&v_Table_name')
  and ic.table_owner = upper(nvl('&&v_Owner',user))
  and ic.table_name = col.table_name(+)
  and ic.table_owner = col.owner(+)
  and ic.COLUMN_NAME = col.column_name(+)
  and ic.index_name(+) = maxind.indice
  and col.table_name=tab.table_name(+)
  and col.owner=tab.owner(+)
order by ic.index_name,ic.column_position
/

prompt
prompt ***************
prompt Index partition
prompt ***************
select INDEX_NAME,PARTITIONING_TYPE,SUBPARTITIONING_TYPE,PARTITION_COUNT,
       LOCALITY
  from DBA_PART_INDEXES
 where table_name = upper('&&v_Table_name')
   and owner = upper(nvl('&&v_Owner',user))
/

select  DECODE(COLUMN_POSITION,1,NAME,NULL) indice,COLUMN_NAME 
  from DBA_PART_INDEXES a,dba_part_key_columns b
 where a.table_name = upper('&&v_Table_name')
   and a.owner = upper(nvl('&&v_Owner',user))
   and a.owner =b.owner 
   and NAME=INDEX_NAME
 order by name,column_position
/



prompt
prompt ***************
prompt Partition Level
prompt ***************




select  DECODE(COLUMN_POSITION,1,PARTITIONING_TYPE,NULL) PARTITIONING_TYPE,
        DECODE(COLUMN_POSITION,1,PARTITION_COUNT,NULL) PARTITION_COUNT,COLUMN_NAME 
  from DBA_PART_TABLES a,dba_part_key_columns b
 where a.table_name = upper('&&v_Table_name')
   and a.owner = upper(nvl('&&v_Owner',user))
   and a.owner =b.owner 
   and NAME=a.table_name
 order by column_position
/

select  DECODE(COLUMN_POSITION,1,SUBPARTITIONING_TYPE,NULL) SUBPARTITIONING_TYPE,
        COLUMN_NAME 
  from DBA_PART_TABLES a,DBA_SUBPART_KEY_COLUMNS  b
 where a.table_name = upper('&&v_Table_name')
   and a.owner = upper(nvl('&&v_Owner',user))
   and a.owner =b.owner 
   and NAME=a.table_name
 order by column_position
/


select
    PARTITION_NAME,
    NUM_ROWS,
    BLOCKS,
    EMPTY_BLOCKS,
    AVG_SPACE,
    CHAIN_CNT,
    AVG_ROW_LEN,
    GLOBAL_STATS,
    USER_STATS,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from 
    dba_tab_partitions t
where 
    table_owner = upper(nvl('&&v_Owner',user))
and table_name = upper('&&v_Table_name')
order by partition_position
/

select PARTITION_NAME,  HIGH_VALUE
from 
    dba_tab_partitions t
where 
    table_owner = upper(nvl('&&v_Owner',user))
and table_name = upper('&&v_Table_name')
order by partition_position
/

prompt
prompt ***************
prompt SubPartition Level
prompt ***************

select 
    PARTITION_NAME,
    SUBPARTITION_POSITION,
    NUM_ROWS,
    BLOCKS,
    EMPTY_BLOCKS,
    AVG_SPACE,
    CHAIN_CNT,
    AVG_ROW_LEN,
    GLOBAL_STATS,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from 
    dba_tab_subpartitions t
where 
    table_owner = upper(nvl('&&v_Owner',user))
and table_name = upper('&&v_Table_name')
order by SUBPARTITION_POSITION
/
prompt
prompt ***************
prompt Referencias
prompt ***************

select OWNER,NAME,TYPE
  from dba_dependencies 
 where REFERENCED_NAME=upper('&&v_Table_name')
   and REFERENCED_OWNER= upper(nvl('&&v_Owner',user))
   and REFERENCED_TYPE='TABLE'
order by TYPE,OWNER,NAME
/
clear breaks

undefine v_owner
undefine v_table_name

undefine 1
undefine 2

set echo on
spool off
