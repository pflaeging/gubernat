#! /bin/sh

. ../env.sh

mkdir -p /opt/k8s-data/
kubectl apply -k .