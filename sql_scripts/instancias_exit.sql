set lines 140
col instance_name for a50
col host_name for a64
select instance_name, host_name from v$instance;
exit;

