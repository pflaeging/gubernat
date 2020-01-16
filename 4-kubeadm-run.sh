#! /bin/sh

# Network definitions inside k8s:
# Pod Network 
POD_NETWORK_CIDR=10.42.0.0/16
# Networks for service definitions
SERVICE_CIDR=10.96.0.0/12

source ./CONFIG

# enable crio
# systemctl enable --now crio
# enable docker
systemctl enable docker --now

# patch kubelet for crio
echo "KUBELET_EXTRA_ARGS=--cgroup-driver=systemd" > /etc/sysconfig/kubelet
# enable kubelet
systemctl enable --now kubelet


# fire kubeadm
kubeadm init \
    --pod-network-cidr=$POD_NETWORK_CIDR\
    --service-cidr=$SERVICE_CIDR\
    --apiserver-advertise-address=$MYIP\
    --ignore-preflight-errors=NumCPU

