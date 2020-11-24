#!/bin/bash
rman target /<< EOF
sql 'alter system switch logfile';
crosscheck archivelog all;
delete noprompt archivelog until time 'SYSDATE-7';
