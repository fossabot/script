SPOOL ../Report/$ORACLE_SID/check-components.txt
SET PAGESIZE 60
SET LINESIZE 300

COLUMN name FORMAT A60
COLUMN detected_usages FORMAT 999999999999

SELECT name, detected_usages, currently_used, version FROM dba_feature_usage_statistics WHERE detected_usages > 0 ORDER BY name ;
SPOOL OFF