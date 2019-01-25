#!/bin/bash


SCRIPT_DIR=="$(cd `dirname $0`; pwd)"  #获取脚本路径

function check_net() {
    for (( i = 0; i < 3; i++ )); do
        ping -c 1 114.114.114.114 > /dev/null 2>&1
        if ! [ $? -eq 0 ];then
            echo 'Failed to connect to the internet.'
            echo 'Try it after 10s...'
            sleep 5
        else
            return
        fi
    done
    echo 'Please check the network, then run this scripts again.'
    exit 1
}
check_net  #检查网络

sudo ls
ln -s ${SCRIPT_DIR}/../conf ${HOME}/install_drivers  #创建软链接

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak  #备份源
sudo cp ${HOME}/install_drivers/sources.list /etc/apt/sources.list  #替换源

sudo apt-get update
sudo apt-get -y install wget linux-generic-lts-xenial  #安装Ubuntu内核
sudo apt-get -y upgrade  #更新软件

function install_apollo_kernel() {
    cd ${HOME}/install_drivers
    wget --tries=3 https://github.com/ApolloAuto/apollo-kernel/releases/download/1.5.5/linux-4.4.32-apollo-1.5.5.tar.gz
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

function auto_login() {
    if ! [ -e /etc/lightdm/lightdm.conf ]; then
        sudo su -c "
        echo "[SeatDefaults]" >> /etc/lightdm/lightdm.conf
        echo "autologin-user=${USER}" >> /etc/lightdm/lightdm.conf
        "
    fi
}
auto_login  #设置开机自动登录

sudo su -c '
echo "ALL ALL=NOPASSWD: ALL" >> /etc/sudoers  #修改sudo无需密码
'  #不进入root用户无法修改

echo "bash ${SCRIPT_DIR}/guide-2.sh" >> ${HOME}/.bashrc  #添加下一脚本的环境变量

sudo reboot  #重启
