#!/bin/bash

echo installing ppa for libgcc_s1
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt install -y \
	libstdc++-4.8-dev \
	gcc \
	gcc-10 \
	build-essential 

if [ -d lsp-plugins ]
then
	echo lsp-plugins source is found. leaving...
else
	echo get lsp-plugins from git
	git clone https://github.com/sadko4u/lsp-plugins.git
fi

echo installling dependencies requires
sudo apt install -y \
	libjack-dev \
	lv2-dev \
	ladspa-sdk \
	libsndfile-dev \
	libcairo-dev \
	php \
	libgl-dev

cd lsp-plugins
make clean
make
echo if build ok now make install
