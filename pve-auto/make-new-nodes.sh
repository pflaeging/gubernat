#! /bin/sh

./pve-auto/make-clones.sh vm-env.sh
./pve-auto/start-all.sh vm-env.sh
echo sleeping for 60 seconds
sleep 60
./pve-auto/get-ips.sh vm-env.sh
