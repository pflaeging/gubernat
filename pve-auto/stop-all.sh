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
  echo $name
  $qm stop $vmid
done