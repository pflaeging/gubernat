#! /bin/sh

# Network definitions inside k8s:
# Pod Network 
POD_NETWORK_CIDR=10.42.0.0/16
# Networks for service definitions
SERVICE_CIDR=10.96.0.0/12

HOSTNAME=`hostname`
MYIP=`ip route | grep kernel | grep usb0 | cut -d " " -f 9`

# enable crio
# systemctl enable --now crio

# patch kubelet for dnsmasq
echo "KUBELET_EXTRA_ARGS=--resolv-conf=/var/run/dnsmasq/resolv.conf" > /etc/default/kubelet

# patch docker with right cgroup and config
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# enable docker
systemctl enable docker --now
# just in case 
systemctl restart docker


# enable kubelet
systemctl enable --now kubelet


# fire kubeadm
kubeadm init \
    --pod-network-cidr=$POD_NETWORK_CIDR\
    --service-cidr=$SERVICE_CIDR\
    --apiserver-advertise-address=$MYIP\
    --ignore-preflight-errors=NumCPU

