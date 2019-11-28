# gubernat -> a docker-compose alternative, ...

Gubernat means steer (latin).

## About

Gubernat is an approach to establish a production ready small kubernetes cluster.

We will use gubernat as a replacement for standard docker-compose installations. 

## Installation

- Base installation of CentOS 7 minimal
- After the base installation I made a pair of very small shell scripts to aid the install:

1. [1-repo.sh](1-repo.sh) -> add kubernetes repo and install packages
1. [2-system-setup.sh](2-system-setup.sh) -> disable swap, disable selinux
1. [3-network-setup.sh](3-network-setup.sh) -> customize firewalld, setting hostname
1. [4-kubeadm-run.sh](4-kubeadm-run.sh) -> install base cluster with kubeadm
1. [5-post-install.sh](5-post-install.sh) -> install network plugin, ingress and dashboard
1. [6-install-helm.sh](6-install-helm.sh) -> install helm for deployment of packaged apps

 ## Accessing the Dashboard

Execute the script [dashboard-login-infos.sh](dashboard-login-infos.sh) and get the parameter for dashboard login.

The dashboard is always listening on port 32443 with SSL and a private certificate. That means:

<https://myfamous-minicluster-hostname.cloud:32443>

---
(c) peter pfläging <peter@pflaeging.net>
