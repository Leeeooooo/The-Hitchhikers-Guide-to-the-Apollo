#!/bin/bash

BASE_DIR="$(cd `dirname $0`; pwd)"
source ${BASE_DIR}/guide_base.sh

check_U_disk  #检查U盘
echo 'Start copying files.'
cp -r /media/${USER}/GUIDE/install_drivers/ ${HOME}/  #拷贝文件
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak  #备份源
sudo cp ${HOME}/install_drivers/sources.list /etc/apt/sources.list  #替换源
apt_upgrade  #更新
sudo apt-get -y install linux-generic-lts-xenial  #安装Ubuntu内核
tar zxvf ${HOME}/install_drivers/linux-4.4.32-apollo-1.5.5.tar.gz -C ${HOME}/install_drivers  #解压包
cd ${HOME}/install_drivers/install
sudo bash install_kernel.sh  #安装Apollo内核
s_reboot  #延时重启
