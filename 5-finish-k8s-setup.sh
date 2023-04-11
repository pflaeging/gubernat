#! /bin/sh

. ./env.sh

KUBECONFIG=/etc/kubernetes/admin.conf


# install CNI network plug-in with network 10.85.0.0/16
# if you want to change this you have to look in: 
# - 02-install-kubernetes.sh

# install cilium CLI
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/master/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
# install network
cilium install --config cluster-pool-ipv4-cidr=10.85.0.0/16

# make the master nodes (like this one) schedulable 
# (may create an error on the second command. Just ignore it)

kubectl taint nodes --all node-role.kubernetes.io/control-plane:NoSchedule-
# kubectl taint nodes --all node-role.kubernetes.io/master:NoSchedule-
