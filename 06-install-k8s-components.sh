#! /bin/sh

# select the components you wish to install

. ./env.sh

KUBECONFIG=/etc/kubernetes/admin.conf

for task in $COMPONENTS
do
  echo $task
  kubectl apply -k $task/
done


