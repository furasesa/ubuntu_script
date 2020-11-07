#!/bin/bash
echo "checking repository"
# init
buildaom=false

if [ -d ffmpeg ]
then
	echo "ffmpeg directory is exist"
else
	echo "no repository found. get from source"
	echo "download preququest : git"
	sudo apt-get update -qq && sudo apt-get -y install git
	echo "clone ffmpeg from git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg"
	git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
fi

echo "pull update from master"

cd ffmpeg && git pull origin master

echo "checking for dependencies"

sudo apt update -qq
echo "installing package depends on libudev1"
sudo apt install -y \
	libudev-dev \
	libsdl2-dev

echo "installing package requires"
sudo apt install -y \
	autoconf \
	automake \
	build-essential \
	cmake \
	git-core \
	libgnutls28-dev \
	libunistring-dev \
	libtool \
	libva-dev \
	libvdpau-dev \
	libxcb1-dev \
	libxcb-shm0-dev \
	libxcb-xfixes0-dev \
	pkg-config \
	texinfo \
	wget \
	yasm \
	zlib1g-dev \
	nasm

echo "checking media dependencies"
sudo apt install -y \
	libass-dev \
        libfreetype6-dev \
	libvorbis-dev \
	libx264-dev \
        libx265-dev \
        libnuma-dev \
        libvpx-dev \
        libfdk-aac-dev \
        libmp3lame-dev \
        libopus-dev

#echo "checking libaom"
#if [ -d aom ] 
#then
#	echo "libaom source is exits. updating"
#	git -C aom pull> /dev/null
#else
#	git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom
#fi
#
#if [ -d aom_build ]
#then
#	echo "aom_build is detected. yes to rebuild"
#	select choices in build skip;
#	do
#		case $choices in
#			build)
#				mkdir -p aom_build
#        			cd aom_build && \
#        			PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED=off -DENABLE_NASM=on ../aom && \
#        			PATH="$HOME/bin:$PATH" make -j4 && \
#        			make install
#				;;
#			skip)
#				echo "skip rebuild libaom. if something wrong, please command or remove --enable-libaom."
#				break
#				;;
#			*)
#				echo "invalid selection"
#				;;
#		esac
#	done
#fi

while true; do
	read -p "Do you wish to install this program? [y/n]" yn
	case $yn in
		[Yy]* ) echo "sync ffmpeg_source"; break;;
		[Nn]* ) exit;;
		* ) echo "Please answer y for yes or n for no.";;
	esac
done

echo "it take a long time, please wait...."
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
	--prefix="$HOME/ffmpeg_build" \
	--pkg-config-flags="--static" \
	--extra-cflags="-I$HOME/ffmpeg_build/include" \
	--extra-ldflags="-L$HOME/ffmpeg_build/lib" \
	--extra-libs="-lpthread -lm" \
	--bindir="$HOME/bin" \
	--enable-gpl \
	--enable-gnutls \
	--enable-libass \
	--enable-libfdk-aac \
	--enable-libfreetype \
	--enable-libmp3lame \
	--enable-libopus \
	--enable-libvorbis \
	--enable-libvpx \
	--enable-libx264 \
	--enable-libx265 \
	--enable-nonfree && \
PATH="$HOME/bin:$PATH" make -j4 && \
make install && \
hash -r
