#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

t()
{
    echo ===`date +"%Y-%m-%d %H:%M:%S"`===
    local from=`/sbin/ifconfig | grep 'inet addr' | fgrep -v '127.0.0.1' | awk '{print $2}' | awk -F':' '{print $2}'`
    local to="$1"
    local count="$2"
    /bin/ping -i 0.2 $to -c $count
}

usecase()
{
    t "127.0.0.1" 10
}

while true
do
    usecase
    sleep 60
done
