#! /bin/sh

if [ $# -ne 1 ]; then
  echo "usage:"
  echo "\t $0" '<vm-env.sh>'
  exit
fi
. $1

for i in $(echo $servers)
do 
  vmid=$(echo $i | cut -d: -f2)
  name=$(echo $i | cut -d: -f1)
  ip=$($qm guest cmd $vmid network-get-interfaces | grep '"ip-address" :' | grep $mynet | cut -d '"' -f4)
  echo $name$domain ansible_host=$ip
done