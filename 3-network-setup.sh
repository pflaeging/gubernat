#! /bin/sh

source ./CONFIG

echo "My Name:" $MYNAME
echo "My IP:" $MYIP 

# free some ports from firewalld just in case
firewall-cmd --permanent --add-port=8001/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --permanent --add-port=8443/tcp
firewall-cmd --permanent --add-port=6443/tcp
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --permanent --add-service=ceph-mon
firewall-cmd --permanent --add-service=ceph
firewall-cmd --permanent --add-port=32443/tcp
firewall-cmd --reload
# modprobe br_netfilter

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system


echo $MYIP $MYNAME >> /etc/hosts
hostname $MYNAME
echo $MYNAME > /etc/hostname 
