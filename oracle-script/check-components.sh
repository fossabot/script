SPOOL ../Report/$ORACLE_SID/check-components.txt
SET PAGESIZE 60
SET LINESIZE 300

COLUMN comp_name FORMAT A35
COLUMN version FORMAT A15
COLUMN status FORMAT A10

SELECT comp_name, version, status FROM dba_registry ;
SPOOL OFF