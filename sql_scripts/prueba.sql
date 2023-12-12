-- ===============================================================
-- NAME: prueba.sql
-- DESCRIPTION: Lists emails and sends a message.
-- USAGE: Execute as SYSTEM user or DBA equivalent
-- AUTHOR:
-- ---------------------------------------------------------------
declare
V_LISTA_MAILS NOTIFICACIONES.LISTA_MAILS_TYPE;
V_ASUNTO VARCHAR2(100) := 'prueba correo sislog pre';
V_MENSAJE VARCHAR2(2000);
v_cont NUMBER;
BEGIN

         v_lista_mails(1) :=  'aanayama@capgemini.com';
         V_MENSAJE := 'Prueba fecha ';
         notificaciones.enviar_mail(v_lista_mails, V_ASUNTO ,V_MENSAJE);

end;
/
