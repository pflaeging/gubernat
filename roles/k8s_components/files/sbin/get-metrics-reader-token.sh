#! /bin/sh

kubectl get secret metrics-reader -n kube-system -o jsonpath='{.data.token}' | base64 -d
echo
