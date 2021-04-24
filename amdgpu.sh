sudo apt-add-repository -r ppa:graphics-drivers/ppa && \
sudo add-apt-repository ppa:oibaf/graphics-drivers && \
sudo apt update && \
sudo apt upgrade && \
sudo apt autoremove && \
sudo apt autoclean

sudo apt install --reinstall xserver-xorg-video-amdgpu
sudo dpkg --configure -a
sudo dpkg-reconfigure gdm3 ubuntu-session xserver-xorg-video-amdgpu

sudo apt-get install mesa-vdpau-drivers
