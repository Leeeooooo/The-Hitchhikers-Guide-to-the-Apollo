#!/bin/bash


function install_nvidia_drivers() {
    cd ${HOME}/install_drivers
    echo 'Installing NVIDIA driver...'
    wget --tries=3 https://cn.download.nvidia.cn/XFree86/Linux-x86_64/375.39/NVIDIA-Linux-x86_64-375.39.run
    chmod +x ./NVIDIA-Linux-x86_64-375.39.run
    sudo ./NVIDIA-Linux-x86_64-375.39.run --no-x-check -a -s --no-kernel-module
}
install_nvidia_drivers  #安装NVIDIA驱动

function install_cuda() {
    cd ${HOME}/install_drivers
    echo 'Installing CUDA...'
    wget --tries=3 https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
    sudo chmod a+x cuda_8.0.61_375.26_linux.run
    sudo bash cuda_8.0.61_375.26_linux.run --silent --toolkit --tmpdir=/dev
}
install_cuda  #安装CUDA

function install_cudnn() {
    cd ${HOME}/install_drivers
    echo 'Installing cnDNN...'
    wget --tries=3 https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/8.0_20171129/cudnn-8.0-linux-x64-v7
    tar -xzvf ${HOME}/install_drivers/cudnn-8.0-linux-x64-v7.tgz -C ${HOME}/install_drivers
    sudo cp ${HOME}/install_drivers/cuda/include/cudnn.h /usr/local/cuda/include
    sudo cp ${HOME}/install_drivers/cuda/lib64/libcudnn* /usr/local/cuda/lib64
    sudo chmod a+r /usr/local/cuda/include/cudnn.h
    sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
}
install_cudnn  #安装cuDNN

sed -i 's/guide-2/guid-3/g' ${HOME}/.bashrc

sudo reboot
