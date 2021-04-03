#!/bin/bash

echo "Ubuntu release:"
lsb_release -a 

echo "kernel counts"
sudo dpkg --list | egrep -i --color 'linux-image|linux-headers' | wc -l

v="$(uname -r | awk -F '-virtual' '{ print $1}')"
i="linux-headers-virtual|linux-image-virtual|linux-headers-generic-hwe-|linux-image-generic-hwe-|linux-headers-${v}|linux-image-$(uname -r)|linux-image-generic|linux-headers-generic"

echo "used kernel distro version : $v"

echo "leftover: "
sudo dpkg --list | egrep -i 'linux-image|linux-headers' | awk '/ii/{ print $2}' | egrep -v "$i"

#echo "apt-get --purge remove $(dpkg --list | egrep -i 'linux-image|linux-headers' | awk '/ii/{ print $2}' | egrep -v "$i")"
