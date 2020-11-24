#!/bin/bash
source configuration.sh
for i in INSTANCE_1 INSTANCE_2
do

export ORACLE_SID = $i
rman target / << EOF
sql 'alter system switch logfile';
crosscheck archivelog all;
delete noprompt archivelog until time 'SYSDATE-7';
EOF

echo $i
done