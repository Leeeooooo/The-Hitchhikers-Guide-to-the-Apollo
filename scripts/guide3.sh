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

BASE_DIR="$(cd `dirname $0`; pwd)"
source ${BASE_DIR}/guide_base.sh

check_driver  #检查驱动
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash  #添加git-lfs源
apt_upgrade
sudo apt-get -y install openssh-server git git-lfs  #安装必要软件
cd
git-lfs clone https://github.com/ApolloAuto/apollo.git  #克隆Apollo源码
echo "export APOLLO_HOME=${HOME}/apollo" >> ${HOME}/.bashrc
echo "export PATH=${HOME}/apollo/docker/scripts:$PATH" >> ${HOME}/.bashrc  #配置环境变量
source ${HOME}/.bashrc
install_docker_x86  #安装docker
s_reboot
