#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

usage()
{
    echo "Usage: sh $0 [-p local_port] [-h]"
    echo "Options:"
    echo "     -p:  local port"
    echo "     -h:  help"
}

usecase()
{
    PORT=$1
    sudo netstat -ant | awk '/:'$PORT'/ {split($5, ip, ":"); ++arr[ip[1]]} END {for (i in arr) print strftime("%F %T", systime())"\t"i"\t"arr[i]}'
}

PORT=80

while getopts "p:h" opt;
do
    case $opt in
        p    ) PORT=$OPTARG ;;
        h    ) usage; exit 0 ;;
    esac
done

while true
do
    usecase $PORT
    sleep 10
done
