#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

usecase()
{
     sudo netstat -n | awk '/^tcp/ {++state[$NF]}; END {for (key in state) print strftime("%F %T", systime())"\t"key"\t"state[key]}'
}

while true
do
    usecase
    sleep 10
done
