# .bash_profile

if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

# Oracle Settings
TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR

ORACLE_HOSTNAME=lab-ora.lab.local; export ORACLE_HOSTNAME
ORACLE_UNQNAME=ORCL; export ORACLE_UNQNAME
ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE
ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1; export ORACLE_HOME
ORACLE_GG=$ORACLE_BASE/product/gg; export ORACLE_GG
ORACLE_SID=ORCL; export ORACLE_SID
ORACLE_SSID=orcl; export ORACLE_SSID
NLS_LANG=AMERICAN_AMERICA.TH8TISASCII; export NLS_LANG

PATH=/usr/sbin:$PATH; export PATH
PATH=$ORACLE_HOME/bin:$PATH; export PATH
PATH=$ORACLE_HOME/OPatch:$PATH; export PATH
PATH=$ORACLE_BASE/product/gg:$PATH; export PATH

alias gg='cd $ORACLE_GG'
alias network='cd $ORACLE_HOME/network/admin'
alias lang='export NLS_LANG=AMERICAN_AMERICA.TH8TISASCII'
alias trace='cd $ORACLE_BASE/diag/rdbms/$ORACLE_SSID/$ORACLE_SID/'
alias RMAN_LOG='cd /usr/openv/netbackup/ext/db_ext/oracle/samples/rman'
alias rlsqlplus='rlwrap sqlplus'
alias rlrman='rlwrap rman'
alias rlggsci='rlwrap ./ggsci'

PS1='($ORACLE_SID) $PWD $ '; export PS1

LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH