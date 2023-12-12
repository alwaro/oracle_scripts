set serveroutput on;
set verify off;
DECLARE
sqI VARCHAR2(20);
BEGIN
sqI := '&&sqlid';
for r in (select * from (select distinct
				to_char(begin_interval_time,'YYYY/MM/DD HH24:MI:SS') as snD, 		--Timestamp
				parsing_schema_name as psn,module as mod,				--Schema and Name
				sql_id as sqi,plan_hash_value as phv,optimizer_cost as oc,		--SQL Info
				executions_total as et,executions_delta as ed,				--Executions
				fetches_total as ft,fetches_delta as fd,				--Fetches
				parse_calls_total as pct,parse_calls_delta as pcd,			--Parse Calls
				disk_reads_total as drt,disk_reads_delta as drd,			--Disk Reads
				rows_processed_total as rpt,rows_processed_delta as rpd,		--Rows Processed
				cpu_time_total as ctt, cpu_time_delta ctd,				--CPU Time
				elapsed_time_total as ett, elapsed_time_delta as etd,			--Elapsed Time
				ccwait_total as cwt, ccwait_delta as cwd,				--Concurrent Wait
				sql_profile as sqp, version_count as vcn				--SQL Profile and Versions
			from dba_hist_snapshot hsn, dba_hist_sqlstat hsq
			where hsn.snap_id = hsq.snap_id
				and sql_id in (sqI)
			order by 1 desc)
			where rownum < 6)
loop
dbms_output.put_line('[====================== '||r.snD||' ========================]'||chr(10)||'');
dbms_output.put_line('#----------------------------- Info Query --------------------------#');
dbms_output.put_line('| SQL_id:         '||rpad(r.sqi,20)||'   '||' Plan: '||rpad(r.phv,20)||'|');
dbms_output.put_line('| Operation Cost: '||rpad(r.oc,20)||'   '||' Vers: '||rpad(r.vcn,20)||'|');
dbms_output.put_line('| Schema:         '||rpad(r.psn,20)||'   '||' Mod:  '||rpad(r.mod,20)||'|');
dbms_output.put_line('#----------------------------- ---------- --------------------------#'||chr(10)||'');
dbms_output.put_line('#---------------------------- Performance --------------------------#');
dbms_output.put_line('|Stat              '||chr(9)||lpad('Total',20)||chr(9)||lpad('Delta',20)||'|');
dbms_output.put_line('|                                                                   |');
dbms_output.put_line('|Executions:       '||chr(9)||lpad(r.et,20)||chr(9)||lpad(r.ed,20)||'|');
dbms_output.put_line('|Fetches:          '||chr(9)||lpad(r.ft,20)||chr(9)||lpad(r.fd,20)||'|');
dbms_output.put_line('|Parsing calls:    '||chr(9)||lpad(r.pct,20)||chr(9)||lpad(r.pcd,20)||'|');
dbms_output.put_line('|Disk reads:       '||chr(9)||lpad(r.drt,20)||chr(9)||lpad(r.drd,20)||'|');
dbms_output.put_line('|Rows processed:   '||chr(9)||lpad(r.rpt,20)||chr(9)||lpad(r.rpd,20)||'|');
dbms_output.put_line('|CPU time:         '||chr(9)||lpad(r.ctt,20)||chr(9)||lpad(r.ctd,20)||'|');
dbms_output.put_line('|Concurrent Wait:  '||chr(9)||lpad(r.cwt,20)||chr(9)||lpad(r.cwd,20)||'|');
dbms_output.put_line('|Elapsed time:     '||chr(9)||lpad(r.ett,20)||chr(9)||lpad(r.etd,20)||'|');
dbms_output.put_line('#---------------------------- ----------- --------------------------#'||chr(10)||chr(10)||'');
end loop;
END;
/
set verify on;
