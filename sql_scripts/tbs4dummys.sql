set lines 300
set verify off
col "Operativa recomendada..." for a150
col "Data_file" for a50
col "Current Mb" for 999999
col "Total Autoextend Mb" for a20
--col "Occupation Graph" for a27
PROMPT "Tablespace?"
DEF tbs='&1';
select 
	file_name as "Data_file",
	round(bytes/1024/1024) as "Current Mb",
	decode(round(maxbytes/1024/1024),33554432,'Unlimited',round(maxbytes/1024/1024)) as "Total Autoextend Mb"--,	
	--rpad(' |'||rpad('#',round((maxbytes-bytes/maxbytes)*20,0),'#'),20,'-')||'| '||round((bytes-maxbytes)/maxbytes*100,0)||'%' as "Occupation Graph"
from dba_data_files df
where 
	tablespace_name like '%&&tbs%'
/
PROMPT 
PROMPT
select
        case BIGFILE
                when 'NO'
                        then decode(round((maxbytes/1024/1024/1024)),
						32,'El datafile ya tiene el autoextend al maximo, verificar si es necesario crear uno nuevo:'||chr(10)||chr(10)||'alter tablespace '||df.tablespace_name||' add datafile ''+DATA'' size 1000M autoextend on next 50M maxsize 32000M;',
                        'El datafile no tiene autoextend o no esta al maximo, lo fijamos a 32G:'||chr(10)||chr(10)||'alter database datafile '''||file_name||''' autoextend on next 50M maxsize 32000M;')
                else
                        'El tablespace es bigfile, le ponemos autoextend ilimitado:'||chr(10)||chr(10)||'alter database datafile '''||file_name||''' autoextend on next 50M maxsize unlimited;'
        end "Operativa recomendada..."
from
        dba_tablespaces ts,dba_data_files df,
        (select tablespace_name,max(file_id) as fid
                from dba_data_files
                group by tablespace_name) mfi
where
        ts.tablespace_name = df.tablespace_name
        and df.file_id = mfi.fid
        and df.tablespace_name like '%&&tbs%'
/
undef tbs
set verify off
