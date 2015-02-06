/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

function t()
{
    local host="$1"
    local url="$2"
    local STARTTIME=`date +%s%N`
    eval $(/usr/bin/curl -i -H"Host: $host" $url -s|grep "HTTP"|awk 'BEGIN{http_code="error"}{if ($2 == "200") {http_code=$2}} END {print "http_code="http_code}')
    local RET=$?
    local ENDTIME=`date +%s%N`
    local T=`expr \( $ENDTIME - $STARTTIME \) / 1000000`
    echo `date +"%Y-%m-%d %H:%M:%S"` "$host $url $RET $T $http_code"
}
