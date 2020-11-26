SPOOL ../Report/$ORACLE_SID/count-objects.txt
SELECT COUNT(object_id) as sum, owner, object_type FROM dba_objects WHERE object_type = 'TABLE' GROUP BY owner, object_type ORDER BY owner ;
SPOOL OFF