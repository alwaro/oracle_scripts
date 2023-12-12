-- ===============================================================
-- NAME: datafiles.sql
-- DESCRIPTION: Shows info of specified TS
-- USAGE: Can show a specified TS
-- AUTHOR:
-- ---------------------------------------------------------------
SET PAGESIZE 60
SET LINESIZE 300
COLUMN "Tablespace Name" FORMAT A20
COLUMN "File Name" FORMAT A60
COLUMN "AutoE" FOR A5
COLUMN "Max Mb" FOR 9999999
COLUMN "Inc by" FOR 9999999
SET verify off
PROMPT 
PROMPT Si quiere listar los datafiles de un TS concreto, introduzca su nombre. Si no, simplemente pulse INTRO
DEF ts_a_buscar='&1';
SELECT  substr(df.tablespace_name,1,20) "Tablespace Name",
        substr(df.file_name,1,80) "File Name",
        round(df.bytes/1024/1024,0) "Size (M)",
        decode(e.used_bytes,NULL,0,Round(e.used_bytes/1024/1024,0)) "Used (M)",
        decode(f.free_bytes,NULL,0,Round(f.free_bytes/1024/1024,0)) "Free (M)",
        decode(e.used_bytes,NULL,0,Round((e.used_bytes/df.bytes)*100,0)) "% Used",
        df.autoextensible "AutoE",
        df.maxbytes/1024/1024 "Max Mb",
        (df.increment_by*ts.block_size)/1024/1024 "Inc by"
FROM    dba_data_files df,
        dba_tablespaces ts,
       (SELECT file_id,
               sum(bytes) used_bytes
        FROM dba_extents
        GROUP by file_id) e,
       (SELECT Max(bytes) free_bytes,
               file_id
        FROM dba_free_space
        GROUP BY file_id) f
WHERE   e.file_id (+) = df.file_id
AND     df.file_id  = f.file_id (+)
AND     df.tablespace_name = ts.tablespace_name
AND 	df.tablespace_name like '%&&ts_a_buscar%'
ORDER BY 1,2
/
SET verify on
unset ts_a_buscar
