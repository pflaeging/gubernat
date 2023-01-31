#! /bin/sh

KUBECONFIG=/etc/kubernetes/admin.conf


# install CNI network plug-in flannel with network 10.85.0.0/16
# if you want to change this you have to look in: 
# - 02-install-kubernetes.sh
# - network-flannel/kube-flannel-cfg-patch.yaml
kubectl apply -k network-flannel/

# make the master nodes (like this one) schedulable 
# (may create an error on the second command. Just ignore it)

kubectl taint nodes --all node-role.kubernetes.io/control-plane:NoSchedule-
kubectl taint nodes --all node-role.kubernetes.io/master:NoSchedule-
