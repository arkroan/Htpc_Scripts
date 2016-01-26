#!/bin/sh

ps -ef | grep arecord | grep -v grep | awk '{print $2}' | xargs kill -9

# call ffmpeg combine and exit 
#./combine_video_mic.sh 

exit 0

