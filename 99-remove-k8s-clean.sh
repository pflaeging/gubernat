#!/bin/sh

systemctl disable kubelet --now
crictl ps -aq | xargs crictl stop 
crictl images -q | xargs crictl rmi
systemctl stop crio
dnf remove -y cri-o
rm -rf /var/lb/containers/* /var/run/crio/* /etc/kubernetes/* /var/lib/etcd/*