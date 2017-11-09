#!/bin/bash
#
# chkconfig: 345 51 49
# description: startup and shutdown the Oracle 10g listener
#
echo "Oracle 10g listener start/stop/restart/status"
ORA_OWNER=oracle
ORACLE_BASE={{ oracle_base }}
ORACLE_HOME={{ oracle_home }}
ORACLE_SID={{ oracle_sid }}
export ORACLE_BASE ORACLE_HOME ORACLE_SID
PATH=$ORACLE_HOME/bin:$PATH:.
export PATH
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib:$ORACLE_HOME/lib32:/lib:/usr/lib
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export LD_LIBRARY_PATH CLASSPATH
alias sqlplus='rlwrap sqlplus'
export NLS_LANG=AMERICAN_AMERICA.UTF8

case $1 in
start)
echo -n "Starting oracle listener: "
su - $ORA_OWNER -c "$ORACLE_HOME/bin/lsnrctl start"
echo
;;

stop)
echo -n "Shutting down oracle listener: "
su - $ORA_OWNER -c "$ORACLE_HOME/bin/lsnrctl stop"
echo
;;

status)
echo -n "Status of oracle listener: "
su - $ORA_OWNER -c "$ORACLE_HOME/bin/lsnrctl status"
echo
;;

restart)
echo -n "Restarting oracle listener:"
$0 stop
$0 start
echo
;;
*)

echo "Usage: listener [ start | stop | restart | status ]"
exit 1
esac
exit 0
