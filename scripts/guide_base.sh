#!/bin/bash

function ok() {
(>&1 echo -e "[\e[32m\e[1m OK \e[0m] $*")
}

function apt_upgrade() {
sudo apt-get update  #更新列表
sudo apt-get -y upgrade  #更新软件
}

function check_agreement() {
echo -n "type 'y' or 'Y' to continue, or type any other key to exit."
read -n 1 user_agreed
if ! [ "$user_agreed" == "y" ] || [ "$user_agreed" == "Y" ]; then
    exit 1
fi
}

function check_U_disk() {
until [ -d /media/${USER}/GUIDE/install_drivers ]; do
    echo 'Please insert the USB flash disk - GUIDE.'
    echo -n 'If inserted,'
    check_agreement
done
}

function check_driver() {
if ! [ -x "$(command -v nvidia-smi)" ]; then
    echo 'Install NVIDIA driver failed.'
    echo "Please rerun 'guide2.sh'."
    check_agreement
else if ! [ -x "$(command -v nvcc)" ]; then
    echo 'Install CUDA failed.'
    echo "Please rerun 'guide2.sh'."
    check_agreement
else if ! [ -e /usr/local/cuda/include/cudnn.h ]; then
    echo 'Install cuDNN failed.'
    echo "Please rerun 'guide2.sh'."
    check_agreement
fi
fi
fi
}

function check_filesystem() {
MACHINE_VERSION=$(uname -r)
if [ "$MACHINE_VERSION" == "4.4.32-apollo-2-RT" ]; then
    echo 'System have install realtime kernel.'
else
    echo 'System installed failed.'
    echo "Please rerun 'guide1.sh'."
    exit 1
fi
}

function check_docker() {
if ! [ -x "$(command -v nvidia-smi)" ]; then
    echo 'Install docker failed.'
    echo "Please rerun 'guide3.sh'."
    exit 1
fi
}

function s_reboot() {
echo 'System is about to restart'
sleep 3
sudo reboot
}
