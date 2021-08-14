#!/bin/bash

echo "installing dependencies"
sudo apt install build-essential dkms git

echo "clone github repository"
git clone https://github.com/gnab/rtl8812au
echo "copying to /usr/src/"
sudo cp -a rtl8812au /usr/src/8812au-4.2.2

echo "dkms build and install"
sudo dkms add -m 8812au -v 4.2.2
sudo dkms build -m 8812au -v 4.2.2
sudo dkms install -m 8812au -v 4.2.2
