#! /bin/sh

# Base command
KUBECTL="kubectl --kubeconfig=/etc/kubernetes/admin.conf"

# make master schedulable
$KUBECTL patch nodes $(hostname) -p '{"spec":{"taints":[]}}'

# install flannel network
$KUBECTL apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# install ingress
$KUBECTL apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
$KUBECTL apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/service-nodeport.yaml

# install dashboard
$KUBECTL apply -f admin-user.yaml
$KUBECTL apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml
$KUBECTL patch service kubernetes-dashboard --type='json' -p='[{"op":"replace","path":"/spec/type","value":"NodePort"}]' -n kubernetes-dashboard

#
