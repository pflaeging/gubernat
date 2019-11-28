#! /bin/sh

# install network time
yum install ntp ntpdate
systemctl enable ntpd --now

# turnoff swap
swapoff -a
sed -i 's$/dev/mapper/cl-swap$# /dev/mapper/cl-swap$g' /etc/fstab

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

