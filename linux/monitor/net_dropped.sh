#!/bin/bash

INTERVAL="10"  # update interval in seconds

if [ -z "$1" ]; then
        echo
        echo usage: $0 [network-interface]
        echo
        echo e.g. $0 eth0
        echo
        exit
fi

IF=$1

while true
do
        R1=`cat /sys/class/net/$1/statistics/rx_dropped`
        T1=`cat /sys/class/net/$1/statistics/tx_dropped`
        sleep $INTERVAL
        R2=`cat /sys/class/net/$1/statistics/rx_dropped`
        T2=`cat /sys/class/net/$1/statistics/tx_dropped`
        TXDPS=`expr $T2 - $T1`
        RXDPS=`expr $R2 - $R1`
        TIME=`date +"%Y-%m-%d %H:%M:%S"`
        echo "$TIME TX $1: $TXDPS dp/s RX $1: $RXDPS dp/s"
done
