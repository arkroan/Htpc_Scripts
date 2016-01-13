#!/bin/bash

# Get current date time
# format: 
now=$(date +"%Y_%m_%d_%H%M")

# set destination folder
destFolder="/var/www/video/"

# Set no of segments
segno=10

# Set duration of segments
rec=60

# set fps
fpsno=2


# Create the destination directory if it does not exist
if [ ! -d $destFolder ]; then
	mkdir $destFolder
fi

# run the capture procedure
#/usr/bin/timeout --foreground -s 9 "$rec"s /usr/bin/ffmpeg -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 /var/www/video/webcam.mp4

for i in {1..10}
do
   echo "Welcome $i times"
	/usr/bin/timeout --foreground -s 9 "$rec"s /usr/bin/ffmpeg -f v4l2 -framerate 25 -video_size 640x480 -i /dev/video0 /var/www/video/webcam_seg_"$i".mp4

done

exit 0

