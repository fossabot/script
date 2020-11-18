SPOOL ../Report/$ORACLE_SID/check-user-expire.txt
SET PAGESIZE 60
SET LINESIZE 300
COLUMN username FORMAT A30
COLUMN account_status FORMAT A10
COLUMN account_status FORMAT A10

SELECT username, account_status, expiry_date FROM dba_users ;

SPOOL OFF