SPOOL ../Report/$ORACLE_SID/check-object-Invalid.txt
SET PAGESIZE 60
SET LINESIZE 300

COLUMN object_name FORMAT A30
COLUMN status FORMAT A10

SELECT object_name, status FROM user_objects WHERE object_type = 'VIEW' AND status = 'INVALID' ORDER BY object_name ASC ;
SPOOL OFF