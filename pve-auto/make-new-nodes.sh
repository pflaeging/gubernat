#! /bin/sh

./gubernat/pve-auto/make-clones.sh vm-env.sh
./gubernat/pve-auto/start-all.sh vm-env.sh
echo sleeping for 60 seconds
sleep 60
./gubernat/pve-auto/get-ips.sh vm-env.sh
