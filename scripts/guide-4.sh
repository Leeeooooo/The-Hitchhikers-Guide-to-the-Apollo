#!/bin/bash

function install_docker_images() {
cd ${HOME}/docker_images
docker load -i images1.tar
docker load -i images2.tar
docker load -i images3.tar
docker load -i images4.tar
docker load -i images5.tar
docker load -i images6.tar
docker tag 08f1f891e62c apolloauto/apollo:dev-x86_64-20181210_1500
docker tag 5486a0d71a97 apolloauto/apollo:localization_volume-x86_64-latest
docker tag ae6c3090ea38 apolloauto/apollo:map_volume-sunnyvale_big_loop-latest
docker tag e9c400025056 apolloauto/apollo:dev-x86_64-20180906_2002
docker tag 6a9cbf71163e apolloauto/apollo:yolo3d_volume-x86_64-latest
docker tag 36dc0d1c2551 apolloauto/apollo:map_volume-sunnyvale_loop-latest
cd
}

BASE_DIR="$(cd `dirname $0`; pwd)"
source ${BASE_DIR}/guide_base.sh

check_docker  #检查docker
apt_upgrade
sudo apt-get -y install exfat-utils
check_U_disk  #检查U盘
echo 'Start copying files.'
cp -r /media/${USER}/exfat-utils/docker_images/ ${HOME}/ #拷贝docker镜像
install_docker_images  #安装docker镜像
sudo rm -rf /var/crash/*
sudo rm -rf ${HOME}/docker_images
ok "Finished setting up Apollo docker environment. Now you can enter with: \ndev_start.sh -C"
ok "Enjoy!"
exit 0
