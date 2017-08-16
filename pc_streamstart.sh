#!/bin/bash
myip=$(ifconfig eth0 | grep "inet " |cut -f2 -d: |tr " " ":"|cut -f1 -d:)
port=5000
piip=192.168.1.195


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
    ! videoconvert \
    ! autovideosink sync=false


ssh pi@$piip "killall gst-launch-1.0"
