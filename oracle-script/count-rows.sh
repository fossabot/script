SPOOL ../Report/$ORACLE_SID/count_rows.txt
SELECT owner, table_name, NVL(num_rows,-1) FROM all_tables WHERE owner NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'GGATE') AND nvl(num_rows,-1) NOT IN (0, 1, -1) ORDER BY NVL(num_rows,-1) ASC ;
SPOOL OFF