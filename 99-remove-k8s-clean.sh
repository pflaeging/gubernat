#!/bin/sh

systemctl disable kubelet --now
kubeadm reset
crictl ps -aq | xargs crictl stop 
crictl images -q | xargs crictl rmi
systemctl stop crio
dnf remove -y cri-o
rm -rf /var/lb/containers/* /var/run/crio/* /etc/kubernetes/* /var/lib/etcd/* /etc/cni/net.d/*
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X