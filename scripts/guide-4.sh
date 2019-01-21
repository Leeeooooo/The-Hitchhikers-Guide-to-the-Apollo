#!/bin/bash

BASE_DIR="$(cd `dirname $0`; pwd)"
source ${BASE_DIR}/guide_base.sh

check_docker  #检查docker
check_U_disk  #检查U盘
echo 'Start copying files.'
cp -r /media/${USER}/exfat-utils/docker_images/ ${HOME}/ #拷贝docker镜像
docker load -i ${HOME}/docker_images/images.tar  #安装docker镜像
sudo rm -rf /var/crash/*  #删除错误日志
sudo rm -rf ${HOME}/docker_images
ok "Finished setting up Apollo docker environment. Now you can enter with: \ndev_start.sh -C"
ok "Enjoy!"
exit 0
