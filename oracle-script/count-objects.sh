SPOOL ../Report/$ORACLE_SID/count_objects.txt
SELECT COUNT(object_name), owner, object_type FROM dba_objects WHERE owner IN ('ORCL') GROUP BY owner, object_type ORDER BY owner ;
SPOOL OFF