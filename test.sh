#!/bin/bash -       
#===============================================================================
VERSION="FindUselessFolders.sh ver 1.1"
SUBJECT=findUselessFolders01
USAGE="Usage: FindUselessFolders.sh -d| -i[path]| -h"
FLAG=""
SizeChk=10000
samplesizchk=200000

MoviesDir1="/home/user/Shared/Movies"
MoviesDir2="/home/user/Shared/Series/International_Series"
DownloadsDir="/home/user/Downloads"

unwantedFiles=( "*sample*" "*txt*")

# requires an argument to be passed i.e. a directory path
checkDir="$MoviesDir1"
sw="i"
unwantedFiles=("*sample*")

# echo "clearFiles $# arguments: $@"

for filetype in "${unwantedFiles[@]}"; do
        echo "Looking into $checkDir for unwanted files like \"*sample*\""
        echo "#######################################################################"

        find "$checkDir" -type f -iname "$filetype" -print0 | xargs -0 du -bs 2>/dev/null | while read size filename; do
 	echo "$filename"
          if [ "$filename" != "." ]; then
               if [ $size -lt $samplesizchk ]; then
                let res=$samplesizchk/1024/1024
                let sizeres=$size/1024/1024
                if [ $sw != "d"  ] ; then
                echo "[$filetype] - $filename is under $res MBs ( $sizeres MBs ) ."
                else
                echo "[$filetype] - $filename is under $res MBs ( $sizeres MBs ) ."
                echo "Deleting"
                fi
               fi
          fi
        done
done


#find . -name test -type d -exec rm -r {} \;
#	#echo "unwantedfiles"
#	find $DownloadsDir -name "$type" # | xargs du -s | while read size filename; do
#		echo "find-du"
#		if [ $size -lt $samplesizchk ]; then
#			echo "small size"
#			echo "$filename is under $samplesizchk Bytes ( $size bytes ) ."
#		fi
#	done 
#done
 	
exit 0
