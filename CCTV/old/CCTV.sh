#!/bin/bash

# Get current date time
# format: 
now=$(date +"%Y_%m_%d_%H%M")

# set syncfolder
syncFolder="/home/user/MEGAsync"

# set destination folder
destFolder="$syncFolder/$now"

# set fps
fpsno=2

# set recording time in secs. 
# 59 secs. cron every minute. 1 sec buffer deadtime
rec=58

# Create the destination directory if it does not exist
#if [ ! -d $destFolder ]; then
#	mkdir $destFolder
#fi

# run the capture procedure
#/usr/bin/ffmpeg -f video4linux2 -s 640x480 -i /dev/video0 -vf fps=$fpsno -t $rec $destFolder/$(date +\%Y-\%m-\%d-\%H\%M)-f%03d.jpeg
#/usr/bin/ffmpeg -f video4linux2 -s 640x480 -i /dev/video0 -vframes 1 $destFolder/$(date +\%Y-\%m-\%d-\%H\%M)-f%03d.png
/usr/bin/ffmpeg -f video4linux2 -s 640x480 -i /dev/video0 -vframes 1 /home/user/MEGAsync/"$now_"f%03d.png


exit 0

