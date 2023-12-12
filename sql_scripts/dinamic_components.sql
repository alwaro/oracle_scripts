-- ===============================================================
-- NAME: dinamic_components.sql
-- DESCRIPTION: Displays components memory usage
-- USAGE: Execute
-- AUTHOR:
-- ---------------------------------------------------------------
COLUMN component FORMAT A30

SELECT  component,
        ROUND(current_size/1024/1024) AS current_size_mb,
        ROUND(min_size/1024/1024) AS min_size_mb,
        ROUND(max_size/1024/1024) AS max_size_mb
FROM    v$memory_dynamic_components
WHERE   current_size != 0
ORDER BY component;


