#! /bin/sh

if [ $# -ne 1 ]; then
  echo "usage:"
  echo "\t $0" '<vm-env.sh>'
  exit
fi
. $1

count=0
for i in $(echo $servers)
do
  count=$((count+1))
  if [[ $count -eq 1 ]]; then
    echo "master:\n  hosts:"
  elif [[ $count -eq 4 ]]; then
    echo "worker:\n  hosts:"
  fi
  vmid=$(echo $i | cut -d: -f2)
  name=$(echo $i | cut -d: -f1)
  ip=$($qm guest cmd $vmid network-get-interfaces | grep '"ip-address" :' | grep $mynet | cut -d '"' -f4)
  # echo "    # Host number: $count"
  echo "    $name$domain:\n      ansible_host: $ip"
done