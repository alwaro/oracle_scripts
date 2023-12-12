-- ===============================================================
-- NAME: licencias2.sql
-- DESCRIPTION: Display oracle geatures usage stats
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
SELECT parameter, value
from v$option
where parameter in
(
'Data Mining',
'Oracle Database Extensions for .NET',
'OLAP',
'Partitioning',
'Real Application Testing'
);
