SPOOL ../Report/$ORACLE_SID/check-uptime.txt
SET PAGESIZE 60
SET LINESIZE 300

COLUMN parameter FORMAT A35
COLUMN value FORMAT A10

SELECT TO_CHAR(logon_time,'DD/MM/YYYY HH24:MI:SS') as Uptime FROM v$session WHERE sid=1 ;
SPOOL OFF