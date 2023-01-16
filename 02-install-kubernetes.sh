#! /bin/sh

cp install/yum-repos.d--kubernetes.repo /etc/yum-repos.d/
cp install/modules-load.d--k8s.conf /etc/modules-load.d/
cp install/sysctl.d--90-k8s.conf /etc/sysctl.d/

dnf update -y 
sysctl --system
dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable kubelet --now
kubeadm init --pod-network-cidr=10.85.0.0/16