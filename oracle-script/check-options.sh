SPOOL ../Report/$ORACLE_SID/check-options.txt
SET PAGESIZE 60
SET LINESIZE 300

COLUMN parameter FORMAT A35
COLUMN value FORMAT A10

SELECT parameter, value FROM v$option ;
SPOOL OFF