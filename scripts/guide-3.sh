#!/bin/bash


function install_docker_x86() {
    sudo modprobe overlay
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo groupadd docker
    sudo gpasswd -a $USER docker
}
install_docker_x86  #安装docker


curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash  #添加git-lfs源
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install openssh-server git git-lfs exfat-utils #安装必要软件

cd
git-lfs clone https://github.com/ApolloAuto/apollo.git  #克隆Apollo源码

sed -i 's/guide-3/guide-4/g' ${HOME}/.bashrc

sudo reboot
