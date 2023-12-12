-- ===============================================================
-- NAME: users.sql
-- DESCRIPTION: Displays info from all users and lets you search for an specific user.
-- USAGE: Execute
-- AUTHOR: Alvaro Anaya
-- ---------------------------------------------------------------

SET LINES 300
col username FOR a25
col ac_status FOR a10
col default_tablespace for a30
col profile FOR  a30
col profile FOR a30
SET verify off
PROMPT 
PROMPT Si quiere listar un usuario en particular introduzca su nombre. Si no, simplemente pulse INTRO
DEF usuario_a_buscar='&1';
col OBJECT_NAME format a45
spoo users.log
PROMPT ================================ LISTANDO TODOS LOS USUARIOS  ================================
--select username, account_status,lock_date, expiry_date,created, default_tablespace,profile, password_versions from dba_users;
SELECT username, account_status,lock_date, expiry_date,created, default_tablespace,profile,  password_versions FROM dba_users WHERE username LIKE '%&&usuario_a_buscar%';
undef 1;
undef usuario_a_buscar;
spoo off

