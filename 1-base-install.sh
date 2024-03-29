#! /bin/sh

. ./env.sh

# install utilities
dnf install -y git tar
# configure firewall
# systemctl disable firewalld --now
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --permanent --add-port=8443/tcp
firewall-cmd --permanent --add-port=6443/tcp
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --permanent --add-service=ceph-mon
firewall-cmd --permanent --add-service=ceph
firewall-cmd --permanent --add-port=32443/tcp
firewall-cmd --reload
# set selinux to permissive
# sudo setenforce 0
# sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
# disable swap
swapoff -a
cp -f /etc/fstab /etc/fstab.bak
sed -i '/swap/d' /etc/fstab
# disable IPv6
cp install/sysctl.d--50-IPv6.conf /etc/sysctl.d/50-IPv6.conf
sysctl --system
# install helm 3 
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
# make place for persistance
mkdir -p /opt/k8s-data/