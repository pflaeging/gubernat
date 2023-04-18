#! /bin/sh

. ../env.sh

mkdir -p /opt/k8s-data/
semanage fcontext -a -t container_file_t  "/opt/k8s-data(/.*)?"
restorecon -R /opt/k8s-data
kubectl apply -k .