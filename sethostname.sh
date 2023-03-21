#! /bin/sh

ip=$(ip route show default | awk '{print $9}')
name=$1
unqualified=$(echo $name | cut -d. -f1)
domain=$(echo $name | cut -d. -f2-)

echo "Setting hostname to $name with IP $ip"
hostnamectl set-hostname $name
echo $ip $unqualified $name >> /etc/hosts