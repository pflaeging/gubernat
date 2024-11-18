#! /bin/sh

if [ $# -ne 2 ]; then
  echo "usage:"
  echo "\t $0" '<vm-env.sh> <snapshot_id>'
  exit
fi
. $1

snapname=$2


for i in $(echo $servers)
do 
  vmid=$(echo $i | cut -d: -f2)
  name=$(echo $i | cut -d: -f1)
  echo $name "->" $snapname
  $qm rollback $vmid $snapname
done