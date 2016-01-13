#!/bin/sh
# 
# retrieves the movie filename and the sound filename from the file:
# .motion_event_names
# and merges the two with a delay on the sound file (of 1 sec)
#
# file contents example of '.motion_event_names':
#
# mic_filename  /home/user/MegaSyncFolder/sound/Evt01_Mic-2016_01_12_1458_21.mp3
# avi_filename  /home/user/MegaSyncFolder/video/2016_01_12/1400/Evt01_Motion-2016_01_12_1458_21.avi
#
# The mic_filename is reported by the mic_rec.sh script 
# and the avi_filename is reported by motionDeamon.conf 
##

# sound delay
sdelay=1

# cmd dir
cdir="/home/user/MotionFolder/jobs"

# target dir
tdir="/home/user/CCTV"
mkdir -p $tdir

echo "Reading config...." >&2
#. /home/user/Scripts/CCTV/text.cfg #note the space between the dot and the leading slash of /etc.cfg
#. .motion_event_names #note the space between the dot and the filename (which has a dot)
. $cdir/ffmpeg.cmd
#echo "Config for the filename: $filename" >&2
#echo "Config for the mic_filename: $mic_filename" >&2
#echo "Config for the avi_filename: $avi_filename" >&2

# change the filename
dest=$(echo $filename | sed 's/Mic/Movie/g')


# main ffmpeg merge:
# example:	
#	ffmpeg -i video/2016_01_12/1400/Evt01_Motion-2016_01_12_1418_13.avi -ss 1 -i sound/Evt01_Mic-2016_01_12_1418_13.mp3 -codec copy output2.avi
#
#/usr/bin/ffmpeg -i $avi_filename -ss $sdelay -i $mic_filename -codec copy "$dest".avi
/usr/bin/ffmpeg -i $avi_filename -ss $sdelay -itsoffset 00:00:02 -i $mic_filename $tdir/"$dest".mkv &

# remove the command
rm -v $cdir/ffmpeg.cmd

exit 0

