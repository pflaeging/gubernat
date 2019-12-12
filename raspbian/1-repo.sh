#! /bin/sh

apt install -y git

cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

apt update

apt install -y docker.io
apt install -y kubeadm
