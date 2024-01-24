#! /bin/sh

kubectl config view -o jsonpath='{.users[0].user.token}' --kubeconfig=/home/setup/.kube/config.installsave --raw
echo