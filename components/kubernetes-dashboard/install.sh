#! /bin/sh

cp ./get-dashboard-admin-token.sh /usr/local/sbin/get-dashboard-admin-token.sh
chown root:root /usr/local/sbin/get-dashboard-admin-token.sh
chmod 755 /usr/local/sbin/get-dashboard-admin-token.sh
kubectl apply -k .
