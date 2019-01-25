#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp $CURRENT_DIR/emucd_64 /usr/bin/emucd_64
depmod
retry_number=0
echo $retry_number>/tmp/retry_number.log
can_result=`ifconfig | grep can`
while [[ ! $can_result ]] && ((retry_number < 10))
do 
    modprobe emuc2socketcan
    sleep 1
    emucd_64 -s7 /dev/cuau3 can0 can1
    sleep 0.1
    ip link set can0 up qlen 1000
    ip link set can1 up qlen 1000
    can_result=`ifconfig | grep can`
    retry_number=$((retry_number+1))
    echo $retry_number>/tmp/retry_number.log
done

