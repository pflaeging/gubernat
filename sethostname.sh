#! /bin/sh

if [ -z $1 ]; then
        echo "usage: $0 hostname"
        echo "       sets hostname and entry of first primary interface in /etc/hosts"
        exit 0
fi

ip=$(ip route show default | head -1 |awk '{print $9}')
name=$1
unqualified=$(echo $name | cut -d. -f1)
domain=$(echo $name | cut -d. -f2-)

echo "Setting hostname to $name with IP $ip"
hostnamectl set-hostname $name
echo $ip $unqualified $name >> /etc/hosts