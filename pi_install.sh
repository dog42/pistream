#!/bin/bash

echo "wireless-power off"  >> /etc/network/interfaces
sudo apt-get update && sudo apt-get install gstreamer1.0
sudo apt-get install git autoconf automake libtool pkg-config libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libraspberrypi-dev
git clone https://github.com/thaytan/gst-rpicamsrc.git
cd gst-rpicamsrc
./autogen.sh --prefix=/usr --libdir=/usr/lib/arm-linux-gnueabihf/
make
sudo make install
