SPOOL ../Report/$ORACLE_SID/check-scn.txt
SET NUM 15
SELECT current_scn FROM v$database ;
SPOOL OFF