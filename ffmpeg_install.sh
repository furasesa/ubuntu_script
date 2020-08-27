#!/bin/bash
echo "checking repository"
if [ -d ffmpeg ]
then
	echo "ffmpeg directory is exist"
	
else
	echo "no repository found. get from source"
	echo "download git"
	sudo apt-get update -qq && sudo apt-get -y install git rsync
	echo "clone ffmpeg from git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg"
	git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
fi
echo "pull update from master"
cd ffmpeg && git pull origin master
echo "checking for dependencies"
sudo apt-get update -qq && sudo apt-get -y install \
	autoconf \
	automake \
	build-essential \
	cmake \
	git-core \
	libass-dev \
	libfreetype6-dev \
	libgnutls28-dev \
	libsdl2-dev \
	libtool \
	libva-dev \
	libvdpau-dev \
	libvorbis-dev \
	libxcb1-dev \
	libxcb-shm0-dev \
	libxcb-xfixes0-dev \
	pkg-config \
	texinfo \
	wget \
	yasm \
	zlib1g-dev \
	nasm \
	libx264-dev \

echo "checking libaom"
if [ -d aom ]
then
	echo "libaom source is exits. updating"
	git -C aom pull> /dev/null
else
	git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom
fi

if [ -d aom_build ]
then
	is_aom_builded=true
else
	is_aom_builded=false
fi

if [ $is_aom_builded == true ]
then
	echo "do you want to re-build libaom?"
	select yn in "rebuild" "skip"
	do
		case $yn in
			rebuild ) rebuild_aom=true; break;;
			skip ) rebuild_aom=false; break;;
		esac
	done
fi

if [ $rebuild_aom == true ] 
then
	echo "rebuild libaom"
	cd aom_build && \
	PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED=off -DENABLE_NASM=on ../aom && \
	PATH="$HOME/bin:$PATH" make -j4 && \
	make install
fi

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
	--enable-libaom \
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


