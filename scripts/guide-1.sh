#!/bin/bash


function check_U_disk() {
until [ -d /media/${USER}/GUIDE/install_drivers ]; do
    echo 'Please insert the USB flash disk.'
    echo -n "If inserted,type 'y' or 'Y' to continue, or type any other key to exit."
    read -n 1 user_agreed
    if ! [ "$user_agreed" == "y" ] || [ "$user_agreed" == "Y" ]; then
        exit 1
    fi
done
}
check_U_disk  #检查U盘

echo -n 'Copying files...'
cp -ru /media/${USER}/GUIDE/install_drivers/ ${HOME}/  #拷贝文件
echo 'done.'

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak  #备份源
sudo cp ${HOME}/install_drivers/sources.list /etc/apt/sources.list  #替换源

sudo apt-get update
sudo apt-get -y install linux-generic-lts-xenial  #安装Ubuntu内核
sudo -y apt-get upgrade  #更新软件

function install_apollo_kernel() {
    tar zxvf ${HOME}/install_drivers/linux-4.4.32-apollo-1.5.5.tar.gz -C ${HOME}/install_drivers  
    cd ${HOME}/install_drivers/install
    sudo bash install_kernel.sh
}
install_apollo_kernel  #安装Apollo内核

function autostart_terminal() {
    mkdir -p ${HOME}/.config/autostart/
    cp ${HOME}/install_drivers/gnome-terminal.desktop ${HOME}/.config/autostart/gnome-terminal.desktop
}
autostart_terminal  #设置开机自动启动终端
sudo sed -i "s/user\=/user\=${USER}/g" /etc/lightdm/lightdm.conf  #设置开机自动登录

sudo su -c '
echo "ALL ALL=NOPASSWD: ALL" >> /etc/sudoers  #修改sudo无需密码
'  #不进入root用户无法修改

echo "bash guide-2.sh" >> ${HOME}/.bashrc  #添加下一脚本的环境变量

sudo reboot  #重启
