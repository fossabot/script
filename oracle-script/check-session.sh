SPOOL ../Report/$ORACLE_SID/check-components.txt
SET PAGESIZE 60
SET LINESIZE 300

COLUMN name FORMAT A60
COLUMN detected_usages FORMAT 999999999999

SELECT sid, serial#, osuser, username as dbuser, machine, program, module FROM v$session WHERE username IS NOT NULL and osuser != 'oracle' ORDER BY sid ;
SPOOL OFF