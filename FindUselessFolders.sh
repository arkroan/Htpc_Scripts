#!/bin/bash -       
# title           : FindUselessFolders.sh
# description     : This script will discover any folders that are empty or have
#			small footprint content and will delete them with the 
# 			-d (delete) switch.
#			-i (info only) switch.
#			-h version/usage switch.
#			-dv [path]
#				A single directory path can be supplied after
#				the -di switches in order to look into a specific directory.
#
# author          : George Efstathiou		
# date            : 2014 Oct 01
#
# version 	  : 1.2 
#			Added samplesizchk param
#			Added function clearFiles()
#				-- Searches for files like *sample* and deletes them.	 
#			Changed Display Sizes from bytes -> Mbytes
#			Corrected Usage from "Usage: FindUselessFolders.sh -d| -i[path]| -h"
#
#		  : 1.1
#		    	Added echo information for -i switch
#			Added echo information for -i [path]
#			Added support for parameter in -d switch
#			Introduced $SizeChk param
#		  : 1.0 
#			tested all functions
#			added -usage information
#			added support for parameter in -i switch
#			other minor fixes and additions
#		  : 0.1 first Version
#			Implemented action as per description.
# usage           : bash FindUselessFolders.sh [--delete]
# notes           : Vim is needed to use this script.
# bash_version    : 4.1.5(1)-release
#===============================================================================
VERSION="FindUselessFolders.sh ver 1.2"
SUBJECT=findUselessFolders01
USAGE="Usage: FindUselessFolders.sh -d[path]| -i[path]| -h"
FLAG=""

# Sizes :
# 52428800 Bytes = 50 MB 
# 209 715 200 Bytes = 200 MB
# 209715200
# 10 485 760 Byte = 10 MB
# 10485760
# 
SizeChk=10485760
samplesizchk=52428800

MoviesDir1="/home/user/Shared/Movies"
MoviesDir2="/home/user/Shared/Series/International_Series"

# --- Function for deleting predefined files -----------------------
function clearFiles {

# requires an argument to be passed i.e. a directory path
local checkDir="$1"
local sw="$2"
unwantedFiles=("*sample*")

# echo "clearFiles $# arguments: $@"

for filetype in "${unwantedFiles[@]}"; do
	echo "Looking into $checkDir for unwanted files like \"*sample*\""
        echo "#######################################################################"
	find "$checkDir" -type f -iname "$filetype" -print0 | xargs -0 du -bs 2>/dev/null | while read size filename; do
		if [ "$filename" != "." ]; then
			if [ $size -lt $samplesizchk ]; then
				let res=$samplesizchk/1024/1024
				let sizeres=$size/1024/1024
				if [ $sw != "d"  ] ; then
					echo "[$filetype] - $filename is under $res MBs ( $sizeres MBs ) ."
				else
					echo "[$filetype] - $filename is under $res MBs ( $sizeres MBs ) ."
					rm -vrf "$filename"
                                	echo " "
				fi
			fi
		fi
	done
done
}

# --- Options processing -------------------------------------------

if [ $# == 0 ] ; then
    echo $USAGE
    exit 1;
fi

while getopts ":dih" optname;
  do
    case "$optname" in
      "h")
        echo "Version $VERSION"
        echo " "
        echo "usage: FindUselessFolders.sh -d[path]| -i[path]| -h"
        echo "	This script will search for any folders that are empty or have"
        echo "	a small footprint content. Less than 5 MBs."
        echo -e "\t-d [path] : delete switch. Deletes the folders and their contents (verbose)."
        echo -e "\t\tpath: A single directory path can be supplied after"
	echo -e "\t\tthe switch in order to look into this specific directory."
        echo -e "\t\t-NOT IMPLEMENTED YET-"
        echo -e "\t-i [path] : info switch. Displays the results only. No action is taken."
        echo -e "\t\tpath: A single directory path can be supplied after"
        echo -e "\t\tthe switch in order to look into this specific directory."
        echo -e "\t-h : version and help switch. Displays the usage and version (this message)."
        echo " "
        exit 0;
        ;;
      "i")
        echo "-i "
	echo "-information only. No action taken."
	FLAG="i"
        ;;
      "d")
        echo "-d"
	echo "-delete. Forces Verbose Delete of files."
	FLAG="d"
        ;;
      "?")
        echo "Unknown option $OPTARG"
	echo "usage: FindUselessFolders.sh -d| -i[path]| -h"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done

shift $(($OPTIND - 1))

param1=$1
param2=$2

# --- Locks -------------------------------------------------------
LOCK_FILE=/tmp/$SUBJECT.lock
if [ -f "$LOCK_FILE" ]; then
   echo "Script is already running"
   exit
fi

trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE

# --- Body --------------------------------------------------------
#  SCRIPT LOGIC GOES HERE
#echo $param1
#echo $param2
# -----------------------------------------------------------------

# -d flag
if [ "$FLAG" == "d" ]; then

	if [ -z "$param1" ]; then
        	echo "Looking into $MoviesDir1"
        	echo "#######################################################################"
		du -bs $MoviesDir1/* | while read size filename; do
			if [ $size -lt $SizeChk ]; then
				let res=$SizeChk/1024/1024
				let sizeres=$size/1024/1024
				echo "$filename is under $res MBs ( $sizeres MBs ) ."
				rm -vrf "$filename"
				echo " "
			fi
		done
		clearFiles $MoviesDir1 d

        	echo "Looking into $MoviesDir2"
        	echo "#######################################################################"
        	du -bs $MoviesDir2/* | while read size filename; do
                	if [ $size -lt $SizeChk ]; then
				let res=$SizeChk/1024/1024
				let sizeres=$size/1024/1024
				echo "$filename is under $res MBs ( $sizeres MBs ) ."
				rm -vrf "$filename"
                        	echo " "
                	fi
        	done
		clearFiles $MoviesDir2 d
        else
                echo "Looking into $param1"
                echo "#######################################################################"
                du -bs $param1/* | while read size filename; do
                        if [ $size -lt $SizeChk ]; then
				let res=$SizeChk/1024/1024
				let sizeres=$size/1024/1024
                                echo "$filename is under $res MBs ( $sizeres MBs ) ."
                                rm -vrf "$filename"
                                echo " "
			fi
                done
		clearFiles $param1 d

	fi
	exit
fi

# -i flag
if [ "$FLAG" = "i" ]; then

	if [ -z "$param1" ]; then 

                echo "Looking into $MoviesDir1"
                echo "#######################################################################"
                du -bs $MoviesDir1/* | while read size filename; do
			if [ $size -lt $SizeChk ]; then
				let res=$SizeChk/1024/1024
				let sizeres=$size/1024/1024
                                echo "$filename is under $res MBs ( $sizeres MBs ) ."
                        fi
                done
		clearFiles $MoviesDir1 i

                echo "Looking into $MoviesDir2"
                echo "#######################################################################"
                du -bs $MoviesDir2/* | while read size filename; do
                        if [ $size -lt $SizeChk ]; then
				let res=$SizeChk/1024/1024
				let sizeres=$size/1024/1024
                                echo "$filename is under $res MBs ( $sizeres MBs ) ."
                        fi
                done
		clearFiles $MoviesDir2 i        

	else 
                echo "Looking into $param1"
                echo "#######################################################################"
                du -bs $param1/* | while read size filename; do
                        if [ $size -lt $SizeChk ]; then
				let res=$SizeChk/1024/1024
				let sizeres=$size/1024/1024
                                echo "$filename is under $res MBs ( $sizeres MBs ) ."
                        fi
                done
		clearFiles $param1 i
	fi
       exit
fi

exit 0

