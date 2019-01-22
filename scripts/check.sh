#!/bin/bash


function check_filesystem() {
    MACHINE_VERSION=$(uname -r)
    if ! [ "$MACHINE_VERSION" == "4.4.32-apollo-2-RT" ]; then
        echo 'Kernel installed failed.'
    fi
}
check_filesystem  #检查内核

function check_driver() {
    if ! [ -x "$(command -v nvidia-smi)" ]; then
        echo 'NVIDIA driver installed failed.'
    else if ! [ -x "$(command -v nvcc)" ]; then
        echo 'CUDA installed failed.'
    else if ! [ -e /usr/local/cuda/include/cudnn.h ]; then
        echo 'cuDNN installed failed.'
    fi
    fi
    fi
}
check_driver  #检查显卡驱动及工具

function check_docker() {
    if ! [ -x "$(command -v docker)" ]; then
        echo 'Docker installed failed.'
    fi
}
check_docker  #检查Docker
