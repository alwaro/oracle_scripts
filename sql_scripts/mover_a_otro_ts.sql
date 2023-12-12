-- ===============================================================
-- NAME: mover_a_otro_ts.sql
-- DESCRIPTION: SCRIPT PARA MOVER LOS OBJETOS DE UN TABLESPACE A OTRO
-- SOLO MUEVE TABLAS, INDICES Y LOBS
--
-- IMPORTANTE:
-- Hay una variable v_debug que DEBE estar en 1 para que no trate
-- de ejecutar directamente cada sentencia ya que no entiende el
-- salto de linea y da error, por eso se cambia la salida a un
-- spool, que puede ser ejecutado despues o no, segun se quiera
--
-- El spool se llama: sentencias_ordenes_mover.sql
--
-- Variables a configurar
-- v_curr_tbs --> Tablespace origen
-- v_dest_tbs --> Tablespace destino
-- v_debug -----> Modo debug (1 activo y 0 desactivado)

-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
set serveroutput on;
spool sentencias_ordenes_mover.sql
DECLARE
  v_curr_tbs VARCHAR2(50);
  v_dest_tbs VARCHAR2(50);
  v_sql VARCHAR2(1000);
  v_sql2 VARCHAR2(1000);
  v_titulo VARCHAR2(1000);
  v_debug SMALLINT;
  
BEGIN
  v_curr_tbs := 'INDICES_LECTURAS';
  v_dest_tbs := 'INDICES_LECTURAS_2022';
  -- VARIABLE FLAG PARA ACTIVAR O NO EL MODO DEBUG
  v_debug := 1; -- MODO DEBUG: 1 = print only; 0 = print and execute
  
  -- get the unique list of users / schemas / owners
  FOR list_owner IN (SELECT DISTINCT owner
                     FROM dba_segments
                     WHERE 1=1
                     -- AND owner IN ('OWNER1','OWNER2')
                     AND tablespace_name = v_curr_tbs)
  LOOP
  -- migrate
        dbms_output.put_line(chr(10));
        v_titulo := '-- TABLAS ESQUEMA ' || list_owner.owner;
        dbms_output.put_line(v_titulo);
        dbms_output.put_line('-- ==============================================================================');
        
              FOR list_tables IN (SELECT table_name
                                        ,iot_name
                                  FROM dba_tables
                                  WHERE owner = list_owner.owner
                                  AND tablespace_name = v_curr_tbs)
              LOOP
                IF list_tables.iot_name IS NOT NULL THEN
                  v_sql := 'ALTER TABLE "' || list_owner.owner || '"."' || list_tables.iot_name || '" MOVE ONLINE TABLESPACE ' || v_dest_tbs || ' PARALLEL 16;';
                  dbms_output.put_line(v_sql);
                  
                    IF v_debug = 0 THEN 
                        EXECUTE IMMEDIATE v_sql;
                    END IF;
                    
                ELSE
                  v_sql := 'ALTER TABLE "' || list_owner.owner || '"."' || list_tables.table_name || '" MOVE ONLINE TABLESPACE ' || v_dest_tbs || ' PARALLEL 16;';
                  dbms_output.put_line(v_sql);
                  
                    IF v_debug = 0 THEN EXECUTE IMMEDIATE v_sql; END IF;
                    
                END IF;
              END LOOP;
            
        dbms_output.put_line(chr(10));
        v_titulo := '-- LOBS ESQUEMA ' || list_owner.owner;
        dbms_output.put_line(v_titulo);
        dbms_output.put_line('-- ==============================================================================');
  
              FOR list_lobs IN (SELECT table_name
                                      ,column_name
                                FROM dba_lobs
                                WHERE owner = list_owner.owner
                                AND tablespace_name = v_curr_tbs)
              LOOP
                v_sql := 'ALTER TABLE ' || list_owner.owner || '.' || list_lobs.table_name || ' MOVE LOB(' || list_lobs.column_name || ') STORE AS (TABLESPACE ' || v_dest_tbs|| ' parallel 16;);';
                  dbms_output.put_line(v_sql);
                  
                    IF v_debug = 0 THEN EXECUTE IMMEDIATE v_sql; END IF;
                    
              END LOOP;
  
        dbms_output.put_line(chr(10));
        v_titulo := '-- INDICES ESQUEMA ' || list_owner.owner;
        dbms_output.put_line(v_titulo);
        dbms_output.put_line('-- ==============================================================================');
  
              FOR list_indexes IN (SELECT segment_name
                                         ,segment_type
                                   FROM dba_segments
                                   WHERE owner = list_owner.owner
                                   AND tablespace_name = v_curr_tbs
                                   AND segment_type = 'INDEX')
              LOOP
                 v_sql := 'ALTER INDEX ' || list_owner.owner || '."' || list_indexes.segment_name || '" REBUILD ONLINE TABLESPACE ' || v_dest_tbs || ' PARALLEL 16;';
                 v_sql2 := 'ALTER INDEX ' || list_owner.owner || '."' || list_indexes.segment_name || '" PARALLEL 1;';
                 dbms_output.put_line(v_sql);
                 dbms_output.put_line(v_sql2);
                  
                    IF v_debug = 0 THEN EXECUTE IMMEDIATE v_sql; END IF;
                    
              END LOOP;
        
                dbms_output.put_line(chr(10));
        v_titulo := '-- INDICES ESQUEMA (PARTICIONADOS) ' || list_owner.owner;
        dbms_output.put_line(v_titulo);
        dbms_output.put_line('-- ==============================================================================');
  
              FOR list_indexes IN (SELECT INDEX_NAME
                                      ,PARTITION_NAME
                                FROM DBA_IND_PARTITIONS
                                WHERE INDEX_OWNER = list_owner.owner
                                AND tablespace_name = v_curr_tbs)
              LOOP
                 v_sql := 'ALTER INDEX ' || list_owner.owner || '."' || list_indexes.index_name || '" REBUILD PARTITION '|| list_indexes.PARTITION_NAME ||' TABLESPACE ' || v_dest_tbs || ';'; 
                 dbms_output.put_line(v_sql);
                  
                    IF v_debug = 0 THEN EXECUTE IMMEDIATE v_sql; END IF;
                    
              END LOOP;
                
  END LOOP;
END;
/
spoo off;
prompt
prompt ______________________________________________
prompt se ha creado el fichero:
prompt sentencias_ordenes_mover.sql
prompt ______________________________________________
prompt

