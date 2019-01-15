#!/bin/bash

function install_can_driver() {
select can_driver in ESD_CAN SOCKET_CAN DEFULT_NO_DRIVER; do
    echo
    if [[ -z $can_driver ]]; then
        echo 'Skip installing CAN driver.'
        exit 2
    fi

    case $can_driver in

        ESD_CAN )
        echo 'Start to install ESD CAN driver.'
		sudo apt-get -y install dkms
		cd ${HOME}/install_drivers/esdcan-pcie402-linux-2.6.x-x86_64-3.10.3
		sudo -i
		dkms add ./src
		dkms build esdcan-pcie402-linux-2.6.x-x86_64/3.10.3
		dkms install esdcan-pcie402-linux-2.6.x-x86_64/3.10.3
		cd /dev
		sudo mknod --mode=a+rw can0 c 52 0
		logout
        ;;

		SOCKET_CAN )
        echo 'Start to install SOCKET CAN driver.'
		cd ${HOME}/install_drivers/EMUC-B202_SocketCAN_Driver_v2.2_Utility_v2.2
		sudo make clean
		sudo make
		cp ${HOME}/install_drivers/EMUC-B202_SocketCAN_Driver_v2.2_Utility_v2.2/driver/emuc2socketcan.ko $HOME/install_drivers/can/
		cd ${HOME}/install_drivers/can
		sudo bash install_can.sh
        ;;

        DEFULT_NO_DRIVER )
        echo 'Skip installing CAN driver.'
        ;;

    esac
    break
done
}

function install_nvidia_drivers() {
cd ${HOME}/install_drivers
echo 'Start installing NVIDIA driver.'
chmod +x ./NVIDIA-Linux-x86_64-375.39.run
sudo ./NVIDIA-Linux-x86_64-375.39.run --no-x-check -a -s --no-kernel-module
sudo chmod a+x cuda_8.0.61_375.26_linux.run
echo 'Start to install CUDA.'
sudo bash cuda_8.0.61_375.26_linux.run --silent --toolkit --tmpdir=/dev
echo "export PATH=$PATH:/usr/local/cuda/bin" >> ${HOME}/.bashrc
echo 'Start to install cnDNN.'
tar -xzvf ${HOME}/install_drivers/cudnn-8.0-linux-x64-v7.tgz -C ${HOME}/install_drivers
sudo cp ${HOME}/install_drivers/cuda/include/cudnn.h /usr/local/cuda/include
sudo cp ${HOME}/install_drivers/cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h
sudo chmod a+r /usr/local/cuda/lib64/libcudnn*
}

BASE_DIR="$(cd `dirname $0`; pwd)"
source ${BASE_DIR}/guide_base.sh

check_filesyste  #检查Apollo内核
install_can_driver  #安装CAN卡驱动
install_nvidia_drivers  #安装NVIDIA驱动及工具
s_reboot
