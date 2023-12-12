-- ===============================================================
-- NAME: crear_acl_debuf.sql
-- DESCRIPTION: Creates ACL for debug
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------

-- Este script da todos los permisos necesarios para poder hacer debug
-- En este caso los da al usuario SISDESRW, con un buscar-reemplazar para
-- cambiar el nombre del esquema, se reajusta todo el script (ACL tambien)

grant debug connect session to SISDESRW;
grant debug any procedure to SISDESRW;
grant execute on DBMS_DEBUG_JDWP to SISDESRW;

BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => '/sys/acls/ACL-debug-SISDESRW.xml',
    description  => 'acl-debug_SISDESRW',
    principal    => 'SISDESRW',
    is_grant     => TRUE, 
    privilege    => 'jdwp',							
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);
	COMMIT;

  DBMS_NETWORK_ACL_ADMIN.ASSIGN_ACL(
  acl  => '/sys/acls/ACL-debug-SISDESRW.xml',
  host => '*');
  COMMIT;
END;
/
