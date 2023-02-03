#! /bin/sh

cp install/yum.repos.d--crio.repo /etc/yum.repos.d/crio.repo
cp install/yum.repos.d--libcontainers.repo /etc/yum.repos.d/libcontainers.repo
cp install/modules-load.d--crio.conf /etc/modules-load.d/crio.conf
cp install/sysctl.d--80-crio.conf /etc/sysctl.d/80-crio.conf

dnf update -y 
sysctl --system
dnf install -y cri-o
modprobe overlay
modprobe br_netfilter
systemctl enable crio --now
