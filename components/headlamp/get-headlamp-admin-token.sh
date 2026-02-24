#! /bin/sh

kubectl get secret admin-user -n kube-system -o jsonpath='{.data.token}' | base64 -d
echo
