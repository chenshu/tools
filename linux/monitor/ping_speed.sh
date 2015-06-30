#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

ping()
{
    ip=$1
    country=$2
    /bin/ping -c 10 $ip | awk -v ip="$ip" -v country="$country" -F' |=' 'BEGIN {lost=0;max=0} $3 ~ /transmitted/{lost=$6} $3 ~ /from/{if ($9 == "time" && $10 > max) max=$10} END {print max, lost, ip, country}'
}

echo ===`date +"%Y-%m-%d %H:%M:%S"`===
while read line
do
{
    ip=$(echo $line | cut -d ' ' -f1)
    country=$(echo $line | cut -d ' ' -f2)
    ping $ip $country
} &
done < ip.txt | sort -n
