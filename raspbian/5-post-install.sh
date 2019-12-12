#! /bin/sh

# Base command
KUBECTL="kubectl --kubeconfig=/etc/kubernetes/admin.conf"
# My hostname
HOSTNAME=`hostname`

# make master schedulable
$KUBECTL patch nodes $(hostname) -p '{"spec":{"taints":[]}}'

# install flannel network
$KUBECTL apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# install ingress
$KUBECTL apply -f ingress-mandatory-arm.yaml
$KUBECTL apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/service-nodeport.yaml
# patch ingress for availability
$KUBECTL patch deployment nginx-ingress-controller -n ingress-nginx --type='json' -p='[{"op":"add","path":"/spec/hostNetwork","value":true}]'

# install dashboard
$KUBECTL apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml
$KUBECTL apply -f ../admin-user.yaml
# setting dashboard to https://myhostname:32443/
$KUBECTL apply -f ../service-kubernetes-dashboard.yaml -n kubernetes-dashboard

# install local-storage class provider
$KUBECTL apply -f ../storageclass-local-storage.yaml

# Give our master node a label for node affinity and local storage
# the best idea is: give every data store a uniq name!
$KUBECTL label node $HOSTNAME pflaeging.net/datastore=data

