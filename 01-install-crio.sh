#! /bin/sh

cp install/yum-repos.d--crio.repo /etc/yum-repos.d/
cp install/yum-repos.d--libcontainers.repo /etc/yum.repos.d/
cp install/modules-load.d--crio.conf /etc/modules-load.d/
cp install/sysctl.d--80-crio.conf /etc/sysctl.d/

dnf update -y 
sysctl --system
dnf install -y cri-o
modprobe overlay
modprobe br_netfilter
systemctl enable crio --now
