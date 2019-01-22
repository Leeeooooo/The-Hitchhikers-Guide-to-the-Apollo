#!/bin/bash


echo -n 'Copying files...'
cp -ru /media/${USER}/exfat-utils/docker_images/ ${HOME}/ #拷贝docker镜像
echo 'done.'
docker load -i ${HOME}/docker_images/images.tar  #安装docker镜像

sudo apt-get autoremove  #移除不再需要的软件
sudo rm -rf /var/crash/*  #删除错误日志
sudo rm -rf ${HOME}/docker_images
sed -i '/guide/d' ${HOME}/.bashrc

echo "export APOLLO_HOME=${HOME}/apollo" >> ${HOME}/.bashrc
echo "export PATH=${HOME}/apollo/docker/scripts:$PATH:/usr/local/cuda/bin" >> ${HOME}/.bashrc  #配置环境变量

function ok() {
    (>&1 echo -e "[\e[32m\e[1m OK \e[0m] $*")
}
ok "Finished setting up Apollo docker environment. Now you can enter with: \ndev_start.sh -C"
ok "or install can driver on another opened gnome-terminal."
ok "Enjoy!"
gnome-terminal -x bash install_can_driver.sh
exit 0
