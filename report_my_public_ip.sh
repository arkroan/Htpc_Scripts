#!/bin/sh

# Checks for my public ip from the ipify api
# and stores it in : /home/user/MEGAsync/xbmc-htpc_home_public_ip.txt
syncfolder='/home/user/MegaSyncFolder'
sfile='xbmc_htpc_public_ip.txt'

#curl 'https://api.ipify.org' > $syncfolder/$sfile
#echo " " >>  $syncfolder/$sfile

# Get Ip
IP=$(curl 'https://api.ipify.org')

# report ports
echo "Live Webcam Link: " >  $syncfolder/$sfile
#curl 'https://api.ipify.org' >> $syncfolder/$sfile

echo "http://$IP:8090" >>  $syncfolder/$sfile
echo " " >>  $syncfolder/$sfile

#echo "Recordings :              :8090" >>  $syncfolder/$sfile

exit 0

