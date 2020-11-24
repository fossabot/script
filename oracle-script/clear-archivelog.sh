#!/bin/bash
for i in PRO DEV
do

export ORACLE_SID = $i
rman target / << EOF
sql 'alter system switch logfile';
crosscheck archivelog all;
delete noprompt archivelog until time 'SYSDATE-7';
EOF

echo $i
done