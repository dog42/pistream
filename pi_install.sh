#!/bin/bash

#echo "wireless-power off"  >> /etc/network/interfaces
echo "wireless-power off" | sudo tee -a /etc/network/interfaces
sudo apt-get update && sudo apt-get install gstreamer1.0 gstreamer1.0-tools gstreamer1.0-plugins-bad gstreamer1.0-plugins-good
sudo apt-get install git autoconf automake libtool pkg-config libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libraspberrypi-dev
git clone https://github.com/thaytan/gst-rpicamsrc.git
cd gst-rpicamsrc
./autogen.sh --prefix=/usr --libdir=/usr/lib/arm-linux-gnueabihf/
make
sudo make install

if ! grep "start_x=1" /boot/config.txt
then
	echo Cam wird aktiviert
        sed -i "s/start_x=0/start_x=1/g" /boot/config.txt
fi
