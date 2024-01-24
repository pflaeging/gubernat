#! /bin/sh
# Program to taint or untaint master node

# we have to be privileged to to this
[ "root" != "$USER" ] && exec sudo $0 "$@"

# secure shell script
set -euf -o pipefail

# usage
if [ $# -ne 2 ]
then
  echo "usage: $0 master-node yes|no"
  echo "       this command sets or deletes a taint on a master node."
  echo "       'yes' taints a node and 'no' removes the taint."
  echo "       Don't taint to much nodes, tainted nodes don't schedule user workload."
  echo "       You can find your master nodes with:"
  echo "       kubectl get node -l node-role.kubernetes.io/control-plane"
  exit 255
fi

# node is first commandline option
node=$1
# action (yes|no) is second commandline option
action=$2
# get masters from cluster
masters=($(kubectl get node -l node-role.kubernetes.io/control-plane -o name | cut -d/ -f2))


# we only support taints on master, let's find out
foundmaster=false
for masternode in "${masters[@]}"
do
  if [[ "$masternode" == "$node" ]]
  then
    foundmaster=true;
  fi
done

# no master, though wie abort
if [[ "$foundmaster" == 'false'  ]]
then
  echo "$node is not a master, Abort!"
  exit 1
fi

# enable taint: set this control-plane node to NoSchedule
if [[ "$action" == 'yes' ]]
then
  kubectl taint node "$node" node-role.kubernetes.io/control-plane:NoSchedule
  exit 0
fi

# disable taint: remove the taint from the node
if [[ "$action" == 'no' ]]
then
  kubectl taint node "$node" node-role.kubernetes.io/control-plane:NoSchedule-
  exit 0
fi

echo "Please use yes or no as second argument. Abort!"
exit 2