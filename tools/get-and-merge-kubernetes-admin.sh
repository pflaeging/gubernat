#! /bin/sh

if [ $# -ne 1 ]; then
  echo "Get kubeconfig and merge it in your ~/.kube/config"
  echo "usage:"
  echo "\t $0" 'user@ip-address-or-hostname-of-one-master'
  exit
fi

userip=$1
now=$(date +%Y%m%d-%H-%M-%S%z)
newconf=$(mktemp)
tempstore=$(mktemp)
if [ -z ${KUBECONFIG+x} ]; then
  kubeconfig=$HOME/.kube/config
else
  kubeconfig=$KUBECONFIG
fi


# get cluster name
clustername=$(ssh $userip k config view -o jsonpath='{.clusters[0].name}')
# get config from remote and rewrite user
ssh $userip kubectl config view --raw | sed "s/kubernetes-admin/$clustername-admin/g" > $newconf

# save orig config
cp $kubeconfig $kubeconfig-$now
# merge configs in new file
KUBECONFIG=$newconf:$kubeconfig kubectl config view --flatten > $tempstore
# set new config in place
cp $tempstore $kubeconfig
# cleanup temp files
rm -f $newconf $tempstore 

echo "Switch to your new context with:" 
echo "kubectl config use-context $clustername-admin@$clustername"
