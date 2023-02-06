#! /bin/sh

. ./env.sh

hostnamectl set-hostname $MYNAME

if [[ -z ${MYIP} ]];
then
  MYIP=$(hostname -I)
fi

echo "My name: " $MYNAME "IP: " $MYIP
echo $MYIP $(hostname) $(hostname | cut -d. -f1) >> /etc/hosts