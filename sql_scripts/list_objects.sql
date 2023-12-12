-- ===============================================================
-- NAME: lista_objetos.sql
-- DESCRIPTION: Lists all objects from an owner (arg 1) and one type of objects (arg2)
-- USAGE: @lista_objetos [owner] [tipo_objeto]
-- AUTHOR: Alvaro Anaya
-- ---------------------------------------------------------------

set feedback off;
set verify off;

SET SERVEROUTPUT ON SIZE UNLIMITED;

DECLARE
    v_owner VARCHAR2(50) := '&1';
    v_object_type VARCHAR2(50) := UPPER('&2');
BEGIN
    IF v_owner IS NULL OR v_owner = '' THEN
        v_owner := USER;
    END IF;

    IF v_object_type IS NULL OR v_object_type = '' THEN
        v_object_type := '%';
    END IF;

    -- Imprimir encabezados
    DBMS_OUTPUT.PUT_LINE('.');
    DBMS_OUTPUT.PUT_LINE('Owner           Object Name             Object Type       Status   ');
    DBMS_OUTPUT.PUT_LINE('--------------- ---------------------- ----------------- ---------');

    FOR rec IN (SELECT owner, object_name, object_type, status
                FROM all_objects
                WHERE owner = v_owner
                AND object_type LIKE v_object_type
                ORDER BY object_name)
    LOOP
        -- Imprimir cada fila
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.owner, 13) ||
                             '   ' || RPAD(rec.object_name, 20) ||
                             '   ' || RPAD(rec.object_type, 14) ||
                             '     ' || rec.status);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('                      .');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


undef v_owner;
undef v_object_type;
undef 1;
undef 2;
set feedback on;
set verify on;
