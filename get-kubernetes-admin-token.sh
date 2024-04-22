#! /bin/sh

if [ $# -ne 1 ]; then
  echo "Get kubeconfig and merge it in your ~/.kube/config"
  echo "usage:"
  echo "\t $0" 'user@ip-address-or-hostname-of-one-master'
  exit
fi

ip=$1
now=$(date +%Y%m%d-%H-%M-%S%z)
kubeconfig=$HOME/.kube/config
newconf=$(mktemp)
tempstore=$(mktemp)

# get cluster name
clustername=$(ssh $ip k config view -o jsonpath='{.clusters[0].name}')
# get config from remote and rewrite user
ssh $ip kubectl config view --raw | sed "s/kubernetes-admin/$clustername-admin/g" > $newconf

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
