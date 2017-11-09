#!/bin/bash
 
export DISABLE_HUGETLBFS=1
exec $ORACLE_HOME/bin/oracle.bin $@
