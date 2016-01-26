#!/bin/sh

# Creates and sends an e-mail using the following gmail account:
# 	myhtpcgr@gmail.com
# 
# 
# Example:
#
# ./sendemail.sh -s=testSubject -m=testMessage -r=recipient@gmail.com
#

# Get the arguments
for i in "$@"
do
case $i in
    -s=*|--subject=*)
    Subject="${i#*=}"
    ;;
    -m=*|--message=*)
    Body="${i#*=}"
    ;;
    -r=*|--recipient=*)
    recipient="${i#*=}"
    ;;
    -cf=*|--credentialsfile=*)
    cfile="${i#*=}"
    ;;

    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
	echo Example:
	echo "./sendemail.sh -s=testSubject -m=testMessage -r=recipient@gmail.com -cf=/home/gmail.conf"
	exit 0
    ;;
esac
done

echo Subject = ${Subject}
echo Body = ${Body}
echo recipient = ${recipient}
echo Credentials File = ${cfile}
echo DEFAULT = ${DEFAULT}

# source the credentials file
. ${cfile}

sendEmail -f $email -t $recipient \
-u "$Subject" -m "$Body" \
-s smtp.gmail.com \
-o tls=yes \
-xu $username -xp $pass

#sendEmail -f myhtpcgr@gmail.com -t $recipient \
#-u "$Subject" -m "$Body" \
#-s smtp.gmail.com \
#-o tls=yes \
#-xu myhtpcgr -xp "myhtpcgr123789!"


exit 0

