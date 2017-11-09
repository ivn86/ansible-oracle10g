#!/bin/bash
#
# chkconfig: 345 51 49
# description: startup and shutdown the Oracle 10g instance
#
# Run-level Startup script for the Oracle Instance, Listener, and Web Interface

echo "Oracle 10g database start/stop/restart"
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
export NLS_LANG=AMERICAN_AMERICA.UTF8

# if the executables do not exist -- display error

if [ ! -f $ORACLE_HOME/bin/dbstart -o ! -d $ORACLE_HOME ]
then
    echo "Oracle startup: cannot start"
    exit 1
fi

# depending on parameter -- startup, shutdown, restart
# of the instance and listener or usage display

case "$1" in
    start)
        # Oracle listener and instance startup
        echo -n "Starting Oracle: "
        su $ORA_OWNER -c "$ORACLE_HOME/bin/lsnrctl start"
        su $ORA_OWNER -c $ORACLE_HOME/bin/dbstart
        touch /var/lock/oracle
#        su $ORA_OWNER -c "$ORACLE_HOME/bin/emctl start dbconsole"
        echo "OK"
        ;;
    stop)
        # Oracle listener and instance shutdown
        echo -n "Shutdown Oracle: "
        su $ORA_OWNER -c "$ORACLE_HOME/bin/lsnrctl stop"
        su $ORA_OWNER -c $ORACLE_HOME/bin/dbshut
        rm -f /var/lock/oracle
#        su $ORA_OWNER -c "$ORACLE_HOME/bin/emctl stop dbconsole"
        echo "OK"
        ;;
    restart)
        $0 stop
        $0 start
        ;;
    *)
        echo "Usage: `basename $0` start|stop|restart"
        exit 1
esac
exit 0
