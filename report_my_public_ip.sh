#!/bin/sh

# Checks for my public ip from the ipify api
# and stores it in : /home/user/MEGAsync/xbmc-htpc_home_public_ip.txt
syncfolder='/home/user/MegaSyncFolder'

curl 'https://api.ipify.org?format=json' > /home/user/MEGAsync/xbmc-htpc_home_public_ip.txt
echo " " >>  $syncfolder/xbmc-htpc_home_public_ip.txt

# report ports
echo "Live Webcam:		:8090" >>  $syncfolder/xbmc-htpc_ports.txt
echo "Recordings :              :8090" >>  $syncfolder/xbmc-htpc_ports.txt

exit 0

