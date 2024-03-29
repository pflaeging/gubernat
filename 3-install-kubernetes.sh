#! /bin/sh

. ./env.sh

cp install/yum.repos.d--kubernetes.repo /etc/yum.repos.d/kubernetes.repo
cp install/modules-load.d--k8s.conf /etc/modules-load.d/k8s.conf
cp install/sysctl.d--90-k8s.conf /etc/sysctl.d/90-k8s.conf

dnf update -y 
sysctl --system
dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
ln -s /usr/bin/kubectl /usr/local/bin/k
systemctl enable kubelet --now
kubeadm init --v=5 --pod-network-cidr=10.85.0.0/16