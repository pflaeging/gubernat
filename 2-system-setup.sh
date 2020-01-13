#! /bin/sh

# install network time
yum install -y ntp ntpdate
systemctl enable ntpd --now

# turnoff swap
swapoff -a
sed -i 's_^\(/dev/mapper/.*swap\)_# \1_g' /etc/fstab

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

