#! /bin/sh

# select the components you wish to install

COMPONENTS="cert-manager contour-ingress kubernetes-dashboard local-storage"

KUBECONFIG=/etc/kubernetes/admin.conf

for task in $COMPONENTS
do
  echo $task
  kubectl apply -k $task/
done


