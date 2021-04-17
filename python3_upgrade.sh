#!/bin/bash
echo "change default python 3.6 to 3.8"
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

sudo update-alternatives --config python3


echo "restart python3-apt by reinstalling"
sudo apt remove python3-apt
sudo apt install python3-apt -y
sudo apt update
