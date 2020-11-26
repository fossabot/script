SPOOL ../Report/$ORACLE_SID/count-objects.txt
SELECT DISTINCT owner FROM dba_segments ;
SPOOL OFF