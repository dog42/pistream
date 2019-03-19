#!/bin/bash
cd /home/pi/motion
now=$(date  +%s)
nexttime=$(date -d "+15 seconds" +%s)
fotobucket_fill=10
fotobucket=$fotobucket_fill
inotifywait -m /home/pi/motion -e create |
        while read path action file; do
        now=$(date  +%s)
        if [ "$now" -ge "$nexttime" ];
                then
                nexttime=$(date -d "+15 seconds" +%s)
                fotobucket=$fotobucket_fill
        fi
        if [ "$fotobucket" -gt "0" ]
                then
                ((fotobucket--))
                if [[ !($file =~ "snapshot") ]];
                    then
                        python /home/pi/sendpic.py $path$file
                fi
        fi
        # do something with the file

        done
