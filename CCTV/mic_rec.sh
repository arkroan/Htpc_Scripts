#!/bin/sh
# requires args:
#		$1	: folder path
#		$2 	: filename
#		$3	: event no
#
#	Example with %Y_%m_%d/%H00/Evt%v_Mic-%Y_%m_%d_%H%M_%S :
#
#	mic_rec.sh %Y_%m_%d/%H00 Evt%v_Mic-%Y_%m_%d_%H%M_%S %v
#

# Recording folder
recfolder='/home/user/MotionFolder/sound'

# Jobs folder
jobs='/home/user/MotionFolder/jobs'
mkdir -vp $jobs

# File destination
recfile="$recfolder/$1"
mkdir -vp $recfile

# add Filename and extension
filename="$recfile/$2".mp3

# pass the event, and mic filename -happens Before avi movie
echo "evt=\"$3\""  > $jobs/ffmpeg.cmd
echo "filename=\"$2\""  >> $jobs/ffmpeg.cmd
echo "mic_filename=\"$filename\"" >> $jobs/ffmpeg.cmd


arecord -f cd -D plughw:2,0 | ffmpeg -i - -acodec libmp3lame -ab 32k -ac 1 $filename

exit 0

