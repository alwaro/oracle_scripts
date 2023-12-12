set lines 300
set verify off
PROMPT
PROMPT "De que usuario tenemos que resetear la password" 
DEF lockedUser='&1';
select 'alter user '||name||' identified by values '''||password||''' account unlock;' as "Reset pass"
from sys.user$ 
where name='&&lockedUser';
UNDEF lockedUser;

