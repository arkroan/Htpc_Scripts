#!/bin/bash
dateNow=`date +"%d/%m/%Y %H:%M:%S"`
dateSys=`date`

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "################### SortAndClear.sh ####################################### START : $dateNow"

echo ""
echo "~~~~ SortTV"
# Run Sort First
/home/user/Scripts/SortTv1.37/sorttv.pl

echo "~~~~ SortTV P"
# Run Sort First
/home/user/Scripts/SortPTv1.37/sorttv.pl


echo ""
echo ""
echo "~~~~ DeleteUnused"
# Clear Downloads Folder
/home/user/Scripts/FindUselessFolders.sh -d /home/user/Downloads 



dateNow=`date +"%d/%m/%Y %H:%M:%S"`
dateSys=`date`

echo "################### SortAndClear.sh ####################################### END :   $dateNow"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"


exit 0       
