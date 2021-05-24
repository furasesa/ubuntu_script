#!/bin/bash

echo "install dependencies"
sudo apt install libdrm-dev libpciaccess-dev libncurses5-dev
#libxcb requirest but exist
git clone https://github.com/clbr/radeontop.git
