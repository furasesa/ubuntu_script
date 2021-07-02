#! /bin/bash

echo "remove deprecated dependencies"

sudo apt remove libboost-all-dev

echo "installing dependencies begin"

sudo apt install -y \
	libboost1.72-all-dev \
	cmake \
	libsdl2-2.0-0 \
	libsdl2-2.0-0 \
	libsdl2-image-dev \
	libsdl2-mixer-2.0-0 \
	libsdl2-mixer-dev \
	fontconfig \
	fontconfig-config \
	libcairo-5c0 \
	libcairo2-dev \
	libsdl-pango-dev \
	libpangocairo-1.0-0 \
	libpango1.0-0 \
	libpango1.0-dev \
	libvorbis-dev \
	libvorbis-dbg \
	libbz2-dev \
	libz-dev \
	libssl-dev

echo ""
echo "how to install"
echo "on root wesnoth folder. create build dir"
echo "mkdir build && cd build"
echo "cmake .. -DCMAKE_BUILD_TYPE=Release"
echo "make -jN. N=6 if 6 core"
