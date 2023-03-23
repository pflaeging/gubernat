#! /bin/sh

# select the components you wish to install

. ./env.sh

KUBECONFIG=/etc/kubernetes/admin.conf

for task in $COMPONENTS
do
  echo $task
  cd $task
  sh ./install.sh
  cd ..
done


