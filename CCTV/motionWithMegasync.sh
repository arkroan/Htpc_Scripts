#!/bin/bash
dirD="/var/run/motion"

motionStart () {

# Get current date time
# format: 
	now=$(date +"%Y_%m_%d_%H%M")

# motion config file path
	motionconf="/home/user/Scripts/CCTV/motionDeamon.conf"

# Start Motion
#motion -c $motionconf
motion -c $motionconf -d vvvvvv

# Echo
#echo "Motion Started."

}

# check if motion is running
ps_out=`ps -ef | grep motion | grep -v 'grep' | grep -v $0`
result=$(echo $ps_out | grep "motion")
if [[ "$result" != "" ]];then
        echo "Motion is already running. Nothing happened."
else
        echo "Starting motion."
	if [[ ! -e $dirD ]]; then
    		mkdir $dirD
	elif [[ ! -d $dirD ]]; then
    		echo "$dirD already exists but is not a directory" 1>&2
	fi

        motionStart
fi

# In case of a daemon procedure make sure of the following:
# sudo mkdir -p /var/run/motion/
# sudo chown user:user /var/run/motion/
#


exit 0


