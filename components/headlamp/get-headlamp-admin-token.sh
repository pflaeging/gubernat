#! /bin/sh

kubectl get secret admin-user -n users -o jsonpath='{.data.token}' | base64 -d
echo
