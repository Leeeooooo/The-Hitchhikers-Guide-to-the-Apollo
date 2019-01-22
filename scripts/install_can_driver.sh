#!/bin/bash


function install_esd_can() {
    echo 'Installing ESD CAN driver.'
    sudo apt-get -y install dkms
    cd ${HOME}/install_drivers/esdcan-pcie402-linux-2.6.x-x86_64-3.10.3
    sudo su -c '
    dkms add ./src
    dkms build esdcan-pcie402-linux-2.6.x-x86_64/3.10.3
    dkms install esdcan-pcie402-linux-2.6.x-x86_64/3.10.3
    cd /dev
    sudo mknod --mode=a+rw can0 c 52 0
    '
    cd ${HOME}/apollo/third_party/can_card_library/esd_can/
    mkdir include/
    cp ${HOME}/install_drivers/esdcan-pcie402-linux-2.6.x-x86_64-3.10.3/include/ntcan.h include/
    mkdir lib/
    cp ${HOME}/install_drivers/esdcan-pcie402-linux-2.6.x-x86_64-3.10.3/lib64/libntcan.so.4.0.1 lib/
    cd ./lib/
    ln -s libntcan.so.4.0.1 libntcan.so.4
    ln -s libntcan.so.4.0.1 libntcan.so.4.0
    sudo reboot
}

function install_socket_can() {
    echo 'Installing SOCKET CAN driver.'
    cd ${HOME}/install_drivers/EMUC-B202_SocketCAN_Driver_v2.2_Utility_v2.2
    sudo make clean
    sudo make
    cp ${HOME}/install_drivers/EMUC-B202_SocketCAN_Driver_v2.2_Utility_v2.2/driver/emuc2socketcan.ko $HOME/install_drivers/can/
    cd ${HOME}/install_drivers/can
    sudo bash install_can.sh
    sudo reboot
}


function install_can_driver() {
echo 'Start to install can driver.'
select can_driver in ESD_CAN SOCKET_CAN DEFULT_NO_DRIVER; do
    echo
    if [[ -z $can_driver ]]; then
        echo 'Canceled.'
        exit 2
    fi

    case $can_driver in

        ESD_CAN )
        install_esd_can
        ;;

	SOCKET_CAN )
        install_socket_can
        ;;

        DEFULT_NO_DRIVER )
        echo 'Canceled.'
        ;;

    esac
    break
done
}
install_can_driver  #安装CAN卡驱动
