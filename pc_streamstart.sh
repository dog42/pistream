#!/bin/bash
#myip=$(ifconfig eth0 | grep "inet " |cut -f2 -d: |tr " " ":"|cut -f1 -d:)
myip=$(ip addr show  eth0 | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}' |  cut -f1 -d"/" ) #is besser
port=5000
piip=192.168.1.195
video='! tee name=t t. ! queue ! avimux ! filesink location=./test2.avi t. ! queue ' #optional videorecord
video=''

if  [[ $# == 1 ]]
        then
        piip=$1
elif [[ $# == 2 ]]
        then
        piip=$1
        port=$2
fi

ssh pi@$piip "cd /home/pi/pistream; ./pi_startcam.sh $myip $port;killall gst-launch-1.0; exit;" &


gst-launch-1.0 udpsrc port=$port \
    ! gdpdepay \
    ! rtph264depay \
    ! avdec_h264 \
    ! videoconvert $video \
    ! autovideosink sync=false


ssh pi@$piip "killall gst-launch-1.0"
