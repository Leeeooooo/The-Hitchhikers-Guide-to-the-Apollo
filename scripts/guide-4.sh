#!/bin/bash


function check_U_disk() {
until [ -d /media/${USER}/exfat-utils/docker_images ]; do
    echo 'Please insert the USB flash disk.'
    echo -n "If inserted,type 'y' or 'Y' to continue, or type any other key to exit."
    read -n 1 user_agreed
    if ! [ "$user_agreed" == "y" ] || [ "$user_agreed" == "Y" ]; then
        exit 1
    fi
done
}
check_U_disk  #检查U盘

echo -n'Copying files...'
cp -ru /media/${USER}/exfat-utils/docker_images/ ${HOME}/ #拷贝docker镜像
echo 'done.'
docker load -i ${HOME}/docker_images/images.tar  #安装docker镜像

sudo rm -rf /var/crash/*  #删除错误日志
sudo rm -rf ${HOME}/docker_images
sed -i '/guide-4/d' ${HOME}/.bashrc

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
