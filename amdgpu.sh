#!/bin/bash

echo "install requires"
wget -qO - https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo apt-key add -
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-1.1.121-bionic.list https://packages.lunarg.com/vulkan/1.1.121/lunarg-vulkan-1.1.121-bionic.list
sudo apt update
sudo apt install vulkan-sdk aria2c

echo "downloading kernel 5.3"
echo "https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3/"
mkdir -p kernel_5.3 && cd kernel_5.3
aria2c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3/linux-headers-5.3.0-050300_5.3.0-050300.201909152230_all.deb
aria2c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3/linux-headers-5.3.0-050300-generic_5.3.0-050300.201909152230_amd64.deb
aria2c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3/linux-image-unsigned-5.3.0-050300-generic_5.3.0-050300.201909152230_amd64.deb
aria2c https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3/linux-modules-5.3.0-050300-generic_5.3.0-050300.201909152230_amd64.deb

echo "please install manualy on kernel dir cd kernel_5.3 and"
echo "sudo dpkg -i *.deb"

echo "untar"
tar -xvJf tar xvJf amdgpu-pro-20.10-1048554-ubuntu-18.04.tar.xz

echo "after extracting done, now intalling by"
echo "./amdgpu-install -y"
echo "amdgpu-pro is not supported"
