break on gname skip page on dbname skip 1 on report 
compute sum label total of "GB" "#FILES" on dbname
compute sum label total of "GB" "#FILES" on gname 
column gname new_value gnvar noprint
ttitle left 'Group name: ' gnvar skip 1 - 
left ==================== skip 2
btitle off
set lines 2000
set pages 2000
set trimspool on
set colsep '|'
set verify off
col gname for a10
col dbname for a10
col file_type for a20
prompt "Database?"
def dbn='&1';
select 
    gname,
    dbname,
    file_type,
    round(SUM(space)/1024/1024/1024) "GB",
    COUNT(*) "#FILES"
FROM
    (SELECT
		gname,
		regexp_substr(full_alias_path, '[[:alnum:]_]*',1,4) dbname,
		file_type,
		space,
		aname,
		system_created,
		alias_directory
        FROM
            (SELECT
				concat('+'||gname, sys_connect_by_path(aname, '/')) full_alias_path,
				system_created,
				alias_directory,
				file_type,
				space,
				level,
				gname,
				aname
			FROM
				(SELECT
					b.name            gname,
					a.parent_index    pindex,
					a.name            aname,
					a.reference_index rindex ,
					a.system_created,
					a.alias_directory,
					c.type file_type,
					c.space
				FROM
					v$asm_alias a,
					v$asm_diskgroup b,
					v$asm_file c
				WHERE
					a.group_number = b.group_number
					AND a.group_number = c.group_number(+)
					AND a.file_number = c.file_number(+)
					AND a.file_incarnation = c.incarnation(+) ) START WITH (mod(pindex, power(2, 24))) = 0
					AND rindex IN
						(SELECT
							a.reference_index
						FROM
                            v$asm_alias a,
                            v$asm_diskgroup b
                        WHERE
                            a.group_number = b.group_number
                        AND (mod(a.parent_index, power(2, 24))) = 0) CONNECT BY prior rindex = pindex )
			WHERE
				NOT file_type IS NULL
				and system_created = 'Y')
WHERE 
	dbname like '%&&dbn%'
GROUP BY
    gname,
    dbname,
    file_type
ORDER BY
    gname,
    dbname,
    file_type
/
undef dbn;
set verify on;
