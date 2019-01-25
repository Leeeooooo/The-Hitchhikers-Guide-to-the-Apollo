#!/bin/bash

echo "----------------- start to install can -----------"
#install 
BUILD_PATH="$(cd $(dirname "${BASH_SOURCE[0]}");pwd)"
cd $BUILD_PATH
mkdir -p /lib/modules/`uname -r`/kernel/drivers/emuccan && cp emuc2socketcan.ko "$_"
chmod +x $BUILD_PATH/emucd_64
cp -f $BUILD_PATH/emucd_64 /usr/bin

#add rclocal 
ADD_SIG="# add by neolix for can installation"
chmod +x $BUILD_PATH/init-emuca-can.sh 

if [ $? -ne 0 ];then
	echo "failed to install CAN ,exit "
	exit 1
fi

grep "$ADD_SIG" /etc/rc.local 
if [ $? -ne 0 ];then
	#add it into rc.local
	cp /etc/rc.local /etc/rc.local.emuccam.`date +%s`
	## del 'exit 0' in the last line of original file
	sed -i 's/^exit 0$//g'   /etc/rc.local
	echo "$ADD_SIG" >>  /etc/rc.local
	echo "bash $BUILD_PATH/init-emuca-can.sh" >>  /etc/rc.local
fi
