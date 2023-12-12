 /************************************************************************************************************************************
 * Name     : zdlra-client-metrics-catalog.sql
 * Author   : David Robbins, Senior Sales Engineer - Oracle Corporation
 * Version  : 4.0 (19-OCT-2022)
 * Purpose  : Script to gather information from an RMAN Catalog that will be used to estimate the ZDLRA
 *            resources that are required to service the databases registered in the catalog.
 ************************************************************************************************************************************
 *  Disclaimer:
 *  -----------                                                                                                                      
 *  Although this program has been tested and used successfully, it is not supported by Oracle Support Services.                     
 *  It has been tested internally, however, and works as documented. We do not guarantee that it will work for you,                  
 *  so be sure to test it in your environment before relying on it.  We do not clam any responsibility for any problems              
 *  and/or damage caused by this program.  This program comes "as is" and any use of this program is at your own risk!!              
 *  Proofread this script before using it! Due to the differences in the way text editors, e-mail packages and operating systems     
 *  handle text formatting (spaces, tabs and carriage returns).  
 *
 *  Hardware and software sizing and related information contained herein is an estimate provided for discussion purposes only, 
 *  based on information provided by you, and shall not be construed as any representation or warranty, express or implied,
 *  on behalf of oracle, including any warranties or conditions of merchantability and fitness for a particular purpose.
 ************************************************************************************************************************************
 *
 *  Usage:
 *  ------                                                                                                                      
 *  To execute this script, please follow the steps below:                                                                           
 *   1)- Copy this script to the desired location.                                                                                   
 *   2)- Review the following variables near the top of the script and modify according to your preferences.
 *       (Note: Descriptions on how to set are included in the comments for each variable.)
 *
 *         mask  
 *         mask_db_key  
 *         include_standby
 *         backup_age_limit
 *         compression_ratio
 * 
 *   3)- OPTIONAL - Modify the file name for the SPOOL file. (Default: zdlra-client-metrics-catalog.lst in the working directory)
 *   4)- Execute the script at the SQL prompt (SQL> @zdlra-client-metrics-catalog.sql) as the RMAN Catalog owner.
 *   5)- Please provide the script's output to the Oracle resource assisting you with ZDLRA sizing.                                     
 *
 *   This script needs to run in each RMAN Catalog that contains databases that will be migrated to the ZDLRA.
 *
 *   This script will report all databases in the catalog that have had a full, incremental, or achivelog backup in the past 30 days.
 *
 *   *** ANY DATABASE THAT HAS HAD NO BACKUPS IN THE PAST 30 DAYS WILL BE EXCLUDED FROM THE REPORT. ***
 * 
 *   NOTE: If databases without a backup in the past 30 days need to be included, modify the backup_age_limit variable near the top
 *         of the script to reflect the desired number of days to include.
 *
 *   A compression ratio is defined near the top of the DECLARE list. This will be used to estimate the uncompressed size of a full backup
 *   when the backupset sizing method is used and the backupset is compressed. The compression ratio can be manually modified if a better
 *   ratio is known. (See the definition of the Method output column below for more information.)
 *
 *   If any reported databases are not to be included in the sizing, they must be manually deleted from the report 
 *   before sending it the Oracle resource assisting you with the ZDLRA sizing.
 *
 * Definitions of output columns
 * -----------------------------
 *
 * NOTE: An "*" in any column indicates the value was NULL.
 *       If incremntal backups are not being run, redo generation is used for the incremental size.
 *
 * Include - YES or NO; Include the database in the sizing? (Databases are not included if the last backup is older than backup_age_limit (Default: 30 days)
 * DBID - database id of the database. (Not needed for sizing, but reported for clarification, in case multiple databases have the same name.)
 * DBKey - primary key within the recovery catalog. (Not needed for sizing, but recorded for ease in drilling down into any anomolies in the data.)
 * DBName - database name.
 * DBUnqName - database unique name.
 * DBRole - database role.
 * DB Size GB - Size of the database; not including tempfiles.
 * Method - the method used to caculate the full backup size.
 *   BDF - BLOCKS field from RC_BACKUP_DATAFILE - this is the preferred method
 *   BSET - BYTES field from RC_BACKUP_PIECE - this is used when a datafile is backed up in multiple pieces. The BLOCKS field from RC_BACKUP_DATAFILE is not reliable in these cases.
 *   COMP BSET - BYTES field from RC_BACKUP_PIECE * compression_ratio - this is used if the backupset is compressed. The reported size is an estimate of the uncompressed size.
 * Full GB - Size of a full/incremental level 0 backup. (Does not include empty blocks.)
 * Incr GB/Day - Average daily size of an incremental level 1 backup. 
 * Incr Pct/Day - Ratio of daily size of a level 1 backup to a full/level 0 backup.
 * Redo GB/Day - Average daily redo generation. 
 * Redo Pct/Day - Ration of daily size of redo to a full/level 0 backup.
 * Rcvry Window - Recovery window for the database.
 * Instances - The number of instances that will send real-time redo, if enabled.
 * Datafiles - The number of datafiles in the database.
 * Largest Datafile GB - Largest datafile in the database.
 * Backup Rate GB/HR - The average backup rate for backups jobs that run at least 5 minutes.
 * Last Full - Date of the last full/level 0 backup.
 * Last Incr - Date of the last incremental level 1 backup.
 * Last Arch - Date of the last archivelog backup.
 *
 *
 * CHANGE LOG
 * ----------
 *
 * 4.0 19-OCT-2022 DaveR - Added the following fields to the output.
 *                           Instances
 *                           Datafiles
 *                           Largest Datafile GB
 *                           Backup Rate GB/HR
 *
 *                         Added check to exit if run in a ZDLRA catalog.
 *
 *                         Changed percentages to be outputted as decimals. (Not X100) The Excel spreadsheet will handle them as percentages.
 *
 * 3.0 01-MAY-2017 DaveR - Added mask variable to allow for masking the DBID, NAME, and DB_UNIQUE_NAME.
 *                         Added mask_db_key variable to mask the DB_KEY.
 *                         Added include_standby variable to allow for optioanlly including standby databases.
 *                         Added catalog version check to support 10g catalogs by setting include_standby to FALSE.
 *                         Added check to ensure the full backup size is never reported larger than the database size.
 *
 * 1.5.1 03-NOV-2016 DaveR - Changed compression_ratio from 5 to 3 for compressed backupsets.
 *
 ************************************************************************************************************************************/
 
SET SERVEROUTPUT ON
SET LINES 400 TRIMS ON
SET TIMING ON
SET TERMOUT OFF
SET FEEDBACK OFF

COLUMN db_name NEW_VALUE mydb_name
SELECT SYS_CONTEXT('USERENV', 'DB_NAME') AS db_name 
  FROM dual;

-- Edit the spool file name, if desired.
--SPOOL zdlra-client-metrics-catalog.lst
SPOOL &mydb_name._zdlra-client-metrics-catalog.lst

DECLARE
  -- Set mask to TRUE to mask the DBID, NAME, and DB_UNIQUE_NAME from the output.
  mask                          CONSTANT BOOLEAN := FALSE;
  
  -- Set mask_db_key to TRUE to mask the DB_KEY. 
  -- Note: The DB_KEY has no meaning outside the RMAN catalog.
  -- Without the RMAN catalog data, it cannot be used to identify a database name or dbid.
  -- It can be useful to have he DB_KEY in the output to allow for discussion on specific databases. 
  -- The customer can map it to a database name by querying the RMAN catalog (RC_DATABASE). 
  mask_db_key                   CONSTANT BOOLEAN := FALSE;
  
  -- Set include_standby to TRUE to include standby databases in the output.
  -- Typically, only set to TRUE if ONLY the standby databases will be replicated to a remote ZDLRA.
  -- include_standby will automatically be set to FALSE for catalog versions prior to 11g to avoid ORA-00942 errors.
  include_standby               BOOLEAN := FALSE;
  
  -- Set backup_age_limit to the number of days back to consider backups. Any database not backed up since the backup_age_limit will not be included in the output.
  -- Not usually modified.
  --###
  backup_age_limit              CONSTANT NUMBER := 30;
  
  -- Set compression_ratio to the RMAN compression ratio for compressed backupsets.
  -- Not usually modified, unless the customer knows the compression ratio is different.
  compression_ratio             CONSTANT NUMBER := 3;
  
  --
  -- DO NOT EDIT BELOW THIS LINE
  --
  
  zdlra_catalog EXCEPTION;
  
  TYPE cv_typ IS REF CURSOR;
  TYPE database_typ IS RECORD (db_key         VARCHAR2(15),
                               dbid           VARCHAR2(15),
                               name           VARCHAR2(8),
                               db_unique_name VARCHAR2(30),
                               database_role  VARCHAR2(7));
  --###                             
  script_version                CONSTANT VARCHAR2(30) := '4.0 - 28-SEP-2022';
  cv                            cv_typ;
  d                             database_typ;
  db_size_bytes                 NUMBER;
  db_full_backup_bytes          NUMBER;
  cf_total_bytes                NUMBER;
  full_backup_bytes             NUMBER;
  full_backupset_bytes          NUMBER;
  incr_history_days             NUMBER;
  incr_backup_bytes_per_day     NUMBER;
  incr_backup_pct               NUMBER;
  redo_bytes_per_day            NUMBER;
  redo_pct                      NUMBER;
  recovery_window_days          NUMBER;
  incr_days                     NUMBER;
  arch_days                     NUMBER;
  datafile_cnt                  NUMBER;
  datafile_max_bytes            NUMBER;
  thread_cnt                    NUMBER;
  backup_rate                   NUMBER;
  db_exclude_cnt                NUMBER := 0;
  db_include_cnt                NUMBER := 0;
  incr_begin_date               DATE;
  incr_end_date                 DATE;
  min_completion_time           DATE;
  max_completion_time           DATE;
  full_last_completion_time     DATE;
  incr_last_completion_time     DATE;
  arch_last_completion_time     DATE;
  max_last_completion_time      DATE;
  begin_time                    DATE;
  cat_dbname                    VARCHAR2(30);
  cat_host                      VARCHAR2(30);
  cat_schema                    VARCHAR2(30);
  cat_version                   VARCHAR2(30);
  cat_major_version             NUMBER;
  pieces                        NUMBER;
  include_db                    VARCHAR2(3);

  db_size_bytes_out             VARCHAR2(20);
  full_backup_bytes_out         VARCHAR2(20);
  full_backupset_bytes_out      VARCHAR2(20);
  incr_backup_bytes_per_day_out VARCHAR2(20);
  incr_backup_pct_out           VARCHAR2(20);
  redo_bytes_per_day_out        VARCHAR2(20);
  redo_pct_out                  VARCHAR2(20);
  datafile_cnt_out              VARCHAR2(20);
  datafile_max_bytes_out        VARCHAR2(20);
  thread_cnt_out                VARCHAR2(20);
  backup_rate_out               VARCHAR2(20);
  recovery_window_days_out      VARCHAR2(20);
  full_last_completion_time_out VARCHAR2(20);
  incr_last_completion_time_out VARCHAR2(20);
  arch_last_completion_time_out VARCHAR2(20);
  incr_days_out                 VARCHAR2(20);
  arch_days_out                 VARCHAR2(20);
  method_out                    VARCHAR2(9);
  
  c_include_standby             VARCHAR2(1000) := 'SELECT TO_CHAR(rd.db_key) AS db_key,
                                                          TO_CHAR(rd.dbid) AS dbid,
                                                          rd.name AS name,
                                                          NVL(rs.db_unique_name,rd.name) AS db_unique_name,
                                                          rs.database_role AS database_role
                                                     FROM
                                                          rc_database rd,
                                                          rc_site rs
                                                    WHERE rd.db_key = rs.db_key
                                                   ORDER BY rs.database_role,
                                                            rd.name,
                                                            rs.db_unique_name,
                                                            dbid';

  c_exclude_standby             VARCHAR2(1000) := 'SELECT TO_CHAR(rd.db_key) AS db_key,
                                                          TO_CHAR(rd.dbid) AS dbid,
                                                          rd.name AS name,
                                                          rd.name AS db_unique_name,
                                                          ''PRIMARY'' AS database_role
                                                     FROM
                                                          rc_database rd
                                                  ORDER BY rd.name,
                                                           dbid';

  FUNCTION is_zdlra
    RETURN BOOLEAN
  AS
     tab_cnt   PLS_INTEGER;
  BEGIN
    SELECT COUNT(*)     
      INTO tab_cnt
      FROM all_tables
     WHERE owner = 'RASYS'
       AND table_name IN ('BP', 'BRL', 'DB', 'DF', 'ODB')
    ;

    IF tab_cnt = 5 THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END is_zdlra;
  
BEGIN
  -- Ensure this catalog is not on a ZDLRA.
  -- A different script must be used for ZDLRA catalogs.
  IF is_zdlra THEN
    RAISE zdlra_catalog;
  END IF;
  
  -- Record the begin time
  begin_time := SYSDATE;

  -- Record catalog information
 SELECT sys_context('userenv','db_name'),
        sys_context('userenv', 'server_host'),
        sys_context ('userenv', 'session_user')
   INTO cat_dbname,
        cat_host,
        cat_schema
   FROM dual;
   
  -- Get the catalog version
  SELECT MAX(version) 
    INTO cat_version
    FROM rcver;

  cat_major_version := TO_NUMBER(SUBSTR(cat_version,1,INSTR(cat_version,'.') - 1));

  -- Write out the report header
  dbms_output.put_line('********* Start of ZDLRA Client Sizing Metrics - Catalog (4.x) ****************');
  dbms_output.put_line(RPAD('-',312,'-'));
  dbms_output.put_line(RPAD('|Include',8)||'|'||
                       RPAD('DBID',15)||'|'||
                       RPAD('DBKey',15)||'|'||
                       RPAD('DBName',8)||'|'||
                       RPAD('DBUnqName',30)||'|'||
                       RPAD('DBRole',7)||'|'||
                       LPAD('DBCount',7)||'|'||
                       LPAD('Instances',9)||'|'||
                       LPAD('DB Size GB',14)||'|'||
                       LPAD('Full GB',14)||'|'||
                       RPAD('Method',9)||'|'||
                       LPAD('Incr GB/Day',14)||'|'||
                       LPAD('Incr Pct/Day',15)||'|'||
                       LPAD('Redo GB/Day',14)||'|'||
                       LPAD('Redo Pct/Day',15)||'|'||
                       LPAD('Rcvry Window',15)||'|'||
                       LPAD('Datafiles',9)||'|'||
                       LPAD('Largest Datafile GB',22)||'|'||
                       LPAD('Backup Rate GB/HR',17)||'|'||
                       LPAD('Last Full',11)||'|'||
                       LPAD('Last Incr',11)||'|'||
                       LPAD('Last Arch',11)||'|');
  dbms_output.put_line(RPAD('-',312,'-'));

  --If the catalog version is less than 11g, then include_standby must be set to false
  --to avoid ORA-00942
  IF cat_major_version < 11 THEN
    include_standby := FALSE;
  END IF;
  
  --Gather protected database information 
  IF include_standby THEN
    OPEN cv FOR c_include_standby; 
  ELSE
    OPEN cv FOR c_exclude_standby;    
  END IF;
  LOOP
    FETCH cv INTO d;
    EXIT WHEN cv%NOTFOUND;
    
    -- Initialize all variables to null
    db_full_backup_bytes := '';
    db_size_bytes := '';
    cf_total_bytes := '';
    full_backup_bytes := '';
    full_backupset_bytes :='';
    pieces := '';
    incr_history_days := '';
    incr_backup_bytes_per_day := '';
    incr_backup_pct := '';
    redo_bytes_per_day := '';
    redo_pct := '';
    recovery_window_days := '';
    incr_begin_date := '';
    incr_end_date := '';
    full_last_completion_time := '';
    incr_last_completion_time := '';
    arch_last_completion_time := '';
    max_last_completion_time := '';
    incr_days := '';
    arch_days := '';
    datafile_cnt := '';
    datafile_max_bytes := '';
    thread_cnt := '';
    backup_rate := '';
    method_out := 'BDF';


    -- Get the number of datafiles and size of largest datafile for each database.
     SELECT COUNT(*),
            MAX(blocks * block_size)
       INTO datafile_cnt,
            datafile_max_bytes
       FROM rc_datafile
      WHERE db_key = d.db_key
        AND (drop_change# IS NULL
              OR creation_change# = drop_change#);
             
     -- Get the number of instances (redo threads) for each database. 
     SELECT COUNT(DISTINCT thread#)
       INTO thread_cnt
      FROM rc_redo_log
      WHERE db_key = d.db_key;
      
     -- Get the median backup rate for each database in GB/HR. 
     -- Ignore backup jobs that run less than 5 minutes to avoid startup skew.
     SELECT ROUND(MEDIAN(mbytes_processed / 1024 / (end_time - start_time) / 24) , 0)
       INTO backup_rate
      FROM rc_rman_status
     WHERE db_key = d.db_key
       AND operation = 'BACKUP'
       AND status = 'COMPLETED'        
       AND mbytes_processed > 0
       AND (end_time - start_time) * 1440 >= 5;
    
     -- Get the latest full backup size, based on actual blocks written per datafile to the backup;
    -- not the size of the datafile itself. This method does not count empty blocks that have never 
    -- contained data.
    SELECT SUM(rbd.blocks * rbd.block_size),
           SUM(rbd.datafile_blocks * rbd.block_size),
           MAX(pieces),
           MAX(rbd.completion_time)
      INTO db_full_backup_bytes,
           db_size_bytes,
           pieces,
           full_last_completion_time
      FROM rc_backup_datafile rbd,
           (SELECT file#,
                   MAX(completion_time) completion_time
              FROM rc_backup_datafile
             WHERE db_key = d.db_key
               AND (incremental_level = 0 OR incremental_level IS NULL)
             GROUP BY file#) mct
     WHERE db_key = d.db_key
       AND rbd.file# = mct.file#
       AND rbd.completion_time = mct.completion_time
       AND (rbd.incremental_level = 0 OR rbd.incremental_level IS NULL);
        
     -- The blocks column in rc_backup_datafile is not reliable for multi-piece backups. So, use the backupset size. 
     -- If the backupset is compressed, use a standard compression ratio to report an estimated uncompressed size.
     
     IF pieces > 1 THEN
       SELECT SUM(bytes * TO_NUMBER(DECODE(compressed,'YES',compression_ratio,'NO','1','1'))),
              DECODE(MAX(compressed),'YES','COMP BSET','NO','BSET','BSET')
         INTO db_full_backup_bytes,
              method_out
         FROM rc_backup_piece
        WHERE bs_key IN (SELECT bs_key
                           FROM rc_backup_datafile rbd,
                               (SELECT file#,
                                       MAX(completion_time) completion_time
                                  FROM rc_backup_datafile
                                 WHERE db_key = d.db_key
                                   AND (incremental_level = 0 OR incremental_level IS NULL)
                                GROUP BY file#) mct
                         WHERE db_key = d.db_key
                           AND rbd.file# = mct.file#
                           AND rbd.completion_time = mct.completion_time
                           AND (rbd.incremental_level = 0 OR rbd.incremental_level IS NULL));
     END IF;
  
  -- The backup size cannot be greater than the database size. If it is, the compression ratio must be wrong. So limit the full backup size to the database size
  IF db_full_backup_bytes > db_size_bytes OR db_full_backup_bytes = 0 THEN
    db_full_backup_bytes := db_size_bytes;
  END IF;

    -- Track last completion of any type of backup for excluding old backups from the report.
    max_last_completion_time := full_last_completion_time;

    -- Get the size of the controlfile backup.
    SELECT MAX(blocks * block_size)
      INTO cf_total_bytes
      FROM rc_backup_controlfile
     WHERE db_key = d.db_key;


    -- Add the size of the latest full backup and controlfile backup
    full_backup_bytes := db_full_backup_bytes + cf_total_bytes;

    -- Get the average daily size of the incremental backups.     
     SELECT SUM(avg_incr_bytes),
            MAX(max_completion_time),
            ROUND(MAX(incr_days),0)
       INTO incr_backup_bytes_per_day,
            incr_last_completion_time,
            incr_days
       FROM (SELECT file#,
                    SUM(incr_bytes) / GREATEST(SUM(incr_days),1) AS avg_incr_bytes,
                    MAX(completion_time) AS max_completion_time,
                    SUM(incr_days) AS incr_days
               FROM (SELECT rbd.file#,
                            SUM(blocks * block_size) AS incr_bytes,
                            MAX(rbd.completion_time) AS completion_time,
                            MAX(rbd.completion_time) - fct.last_full_time AS incr_days    
                       FROM rc_backup_datafile rbd,
                            (SELECT file#, 
                                    db_key,
                                    completion_time AS last_full_time,
                                    LEAD(rbd.completion_time, 1, SYSDATE) OVER (PARTITION BY rbd.file# ORDER BY rbd.completion_time) AS next_full_time
                               FROM rc_backup_datafile rbd
                              WHERE db_key = d.db_key
                                AND (incremental_level = 0 OR incremental_level IS NULL)
                                AND rbd.completion_time >= SYSDATE - backup_age_limit) fct
                      WHERE rbd.db_key = fct.db_key
                        AND rbd.file# = fct.file#
                        AND rbd.incremental_level = 1
                        AND rbd.completion_time BETWEEN fct.last_full_time AND fct.next_full_time
                     GROUP BY rbd.file#,
                              fct.last_full_time,
                              fct.next_full_time) 
             GROUP BY file#)
;
    -- Track last completion of any type of backup for excluding old backups from the report.
    IF incr_last_completion_time > max_last_completion_time THEN
      max_last_completion_time := incr_last_completion_time;
    END IF;

    -- Get the average daily redo generation
    SELECT SUM(blocks * block_size) / GREATEST(MAX(next_time) - MIN(first_time),1),
           MAX(next_time),
           ROUND(GREATEST(MAX(next_time) - MIN(first_time),1),0)
      INTO redo_bytes_per_day,
           arch_last_completion_time,
           arch_days
      FROM rc_backup_redolog 
     WHERE db_key = d.db_key
       AND first_time >= SYSDATE - backup_age_limit;

    -- Track last completion of any type of backup for excluding old backups from the report.
    IF arch_last_completion_time > max_last_completion_time THEN
      max_last_completion_time := arch_last_completion_time;
    END IF;

    -- Get the recovery window
    SELECT MAX(TO_NUMBER(REGEXP_SUBSTR(value, '([[:digit:]]+)', 1, 1)))
      INTO recovery_window_days
      FROM rc_rman_configuration 
     WHERE db_key = d.db_key
       AND  name = 'RETENTION POLICY';

    -- Use the redo generation for incremental, if incrementals are not being run
    IF incr_backup_bytes_per_day IS NULL THEN
      incr_backup_bytes_per_day := redo_bytes_per_day;
    END IF;

    -- Calculate the incremental change percentage
    IF incr_backup_bytes_per_day IS NOT NULL THEN
      --incr_backup_pct := ROUND(incr_backup_bytes_per_day / full_backup_bytes * 100,2);
       incr_backup_pct := ROUND(incr_backup_bytes_per_day / full_backup_bytes,6);
    END IF;
    
    -- Calculate the redo percentage
    IF redo_bytes_per_day IS NOT NULL THEN
      --redo_pct := ROUND(redo_bytes_per_day / full_backup_bytes * 100,2);
       redo_pct := ROUND(redo_bytes_per_day / full_backup_bytes,6);
    END IF;
    
    -- Convert all bytes to GB
    IF db_size_bytes IS NOT NULL THEN
      db_size_bytes := ROUND(db_size_bytes/POWER(1024,3),6);
    END IF;

    IF full_backup_bytes IS NOT NULL THEN
      full_backup_bytes := ROUND(full_backup_bytes/POWER(1024,3),6);
    END IF;
     
     IF full_backupset_bytes IS NOT NULL THEN
      full_backupset_bytes := ROUND(full_backupset_bytes/POWER(1024,3),6);
    END IF;

    IF incr_backup_bytes_per_day IS NOT NULL THEN
      incr_backup_bytes_per_day := ROUND(incr_backup_bytes_per_day/POWER(1024,3),6);
    END IF;

    IF redo_bytes_per_day IS NOT NULL THEN
      redo_bytes_per_day := ROUND(redo_bytes_per_day/POWER(1024,3),6);
    END IF;
     
     IF datafile_max_bytes IS NOT NULL THEN
      datafile_max_bytes := ROUND(datafile_max_bytes/POWER(1024,3),6);
    END IF;

    -- Convert values to character for output, ensuring null values are handled for reporting purposes
    IF db_size_bytes IS NOT NULL THEN
      db_size_bytes_out := TO_CHAR(db_size_bytes);
    ELSE
      db_size_bytes_out := ' ';
    END IF;

    IF full_backup_bytes IS NOT NULL THEN
      full_backup_bytes_out := TO_CHAR(full_backup_bytes);
    ELSE
      full_backup_bytes_out := ' ';
    END IF;
     
     IF full_backupset_bytes IS NOT NULL THEN
      full_backupset_bytes_out := TO_CHAR(full_backupset_bytes);
    ELSE
      full_backupset_bytes_out := ' ';
    END IF;

    IF incr_backup_bytes_per_day IS NOT NULL THEN
      incr_backup_bytes_per_day_out := TO_CHAR(incr_backup_bytes_per_day);
    ELSE
      incr_backup_bytes_per_day_out := ' ';
    END IF;

    IF incr_backup_pct IS NOT NULL THEN
      incr_backup_pct_out := TO_CHAR(incr_backup_pct);
    ELSE
      incr_backup_pct_out := ' ';
    END IF;

    IF recovery_window_days IS NOT NULL THEN
      recovery_window_days_out := TO_CHAR(recovery_window_days);
    ELSE
      recovery_window_days_out := ' ';
    END IF;

    IF redo_bytes_per_day IS NOT NULL THEN
      redo_bytes_per_day_out := TO_CHAR(redo_bytes_per_day);
    ELSE
      redo_bytes_per_day_out := ' ';
    END IF;

    IF redo_pct IS NOT NULL THEN
      redo_pct_out := TO_CHAR(redo_pct);
    ELSE
      redo_pct_out := ' ';
    END IF;

    IF full_last_completion_time IS NOT NULL THEN
      full_last_completion_time_out := TO_CHAR(full_last_completion_time,'DD-MON-YYYY');
    ELSE
      full_last_completion_time_out := ' ';
    END IF;

    IF incr_last_completion_time IS NOT NULL THEN
      incr_last_completion_time_out := TO_CHAR(incr_last_completion_time,'DD-MON-YYYY');
    ELSE
      incr_last_completion_time_out := ' ';
    END IF;

    IF arch_last_completion_time IS NOT NULL THEN
      arch_last_completion_time_out := TO_CHAR(arch_last_completion_time,'DD-MON-YYYY');
    ELSE
      arch_last_completion_time_out := ' ';
    END IF;

    IF arch_days IS NOT NULL THEN
      arch_days_out := TO_CHAR(arch_days);
    ELSE
      arch_days_out := ' ';
    END IF;

    IF incr_days IS NOT NULL THEN
      incr_days_out := TO_CHAR(incr_days);
    ELSE
      incr_days_out := ' ';
    END IF;
     
     IF datafile_cnt IS NOT NULL THEN
      datafile_cnt_out := TO_CHAR(datafile_cnt);
    ELSE
      datafile_cnt_out := ' ';
    END IF;
     
     IF datafile_max_bytes IS NOT NULL THEN
      datafile_max_bytes_out := TO_CHAR(datafile_max_bytes);
    ELSE
      datafile_max_bytes_out := ' ';
    END IF;
     
     IF thread_cnt IS NOT NULL THEN
      thread_cnt_out := TO_CHAR(thread_cnt);
    ELSE
      thread_cnt_out := ' ';
    END IF;
     
     IF backup_rate IS NOT NULL THEN
      backup_rate_out := TO_CHAR(backup_rate);
    ELSE
      backup_rate_out := ' ';
    END IF;
    
    -- Mask DBID, NAME, and DB_UNIQUE_NAME, if mask is set to TRUE
    IF mask THEN
      d.dbid := '########';
      d.name := '########';
      d.db_unique_name := '########';
    END IF;
    
     -- Mask DB_KEY, if mask_db_key is set to TRUE
    IF mask_db_key THEN
      d.db_key := '########';
    END IF;

     -- Include or exclude the database from the sizing based on age of last backup.
     IF max_last_completion_time >= SYSDATE - backup_age_limit THEN
       include_db := 'YES';
       db_include_cnt := db_include_cnt + 1;
     ELSE
       include_db := 'NO';
       db_exclude_cnt := db_exclude_cnt + 1;
     END IF;
       
    -- Output the data
    dbms_output.put_line('|'||
                          RPAD(include_db,7)||'|'||
                          RPAD(d.dbid,15)||'|'||
                         RPAD(d.db_key,15)||'|'||
                         RPAD(d.name,8)||'|'||
                         RPAD(d.db_unique_name,30)||'|'||
                         RPAD(d.database_role,7)||'|'||
                               LPAD(1,7)||'|'||
                               LPAD(thread_cnt_out,9)||'|'||
                         LPAD(db_size_bytes_out,14)||'|'||
                         LPAD(full_backup_bytes_out,14)||'|'||
                         RPAD(method_out,9)||'|'||
                         LPAD(incr_backup_bytes_per_day_out,14)||'|'||
                         LPAD(incr_backup_pct_out,15)||'|'||
                         LPAD(redo_bytes_per_day_out,14)||'|'||
                         LPAD(redo_pct_out,15)||'|'||
                         LPAD(recovery_window_days_out,15)||'|'||
                               LPAD(datafile_cnt_out,9)||'|'||
                               LPAD(datafile_max_bytes_out,22)||'|'||
                               LPAD(backup_rate_out,17)||'|'||
                         LPAD(full_last_completion_time_out,11)||'|'||
                         LPAD(incr_last_completion_time_out,11)||'|'||
                         LPAD(arch_last_completion_time_out,11)||'|');
  END LOOP;
  dbms_output.put_line(RPAD('-',312,'-'));
  dbms_output.put_line('********* End of ZDLRA Client Sizing Metrics ****************');
  dbms_output.put_line('Catalog schema        : '||cat_schema);
  dbms_output.put_line('Catalog database      : '||cat_dbname);
  dbms_output.put_line('Catalog host          : '||cat_host);
  dbms_output.put_line('Catalog version       : '||cat_version);
  dbms_output.put_line('Begin time            : '||TO_CHAR(begin_time,'DD-MON-YYYY HH24:MI:SS'));
  dbms_output.put_line('End time              : '||TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS'));
  dbms_output.put_line('Databases incldued    : '||db_include_cnt);
  dbms_output.put_line('Databases excluded    : '||db_exclude_cnt||' (No backups in past '||backup_age_limit||' days.)');
  dbms_output.put_line('Script version        : '||script_version);

  EXCEPTION
    WHEN zdlra_catalog THEN
      dbms_output.put_line('This script cannot be run on a ZDLRA catalog.');
END;
/
SPOOL OFF
EXIT
