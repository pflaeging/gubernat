# gubernat -> a docker-compose alternative, ...

Gubernat means steer (latin).

## About

Gubernat is an approach to establish a production ready small kubernetes cluster.

The main goal in creating gubernat was: replace docker-compose in a portable open and
upgradable way that is compatible with standard kubernetes configs and maintains a small footprint.

It will typically run on a single server. But it's good practice to have the opportunity to scale it up 
to a redundant configuration without too much effort.

So we created a simple installation procedure for kubernetes 1.16+, flannel as networking layer, the kubernetes-dashboard, helm and the standard nginx ingress configuration.

For persistent storage we are using local storage with explicit persitent volume allocation.

## NEWS

Our first attempt on Raspbian (Raspberry PI 4)!

After this you have a running kubernetes cluster on a Raspbi!

Follow the work in directory [raspbian](raspbian/)

## Components

- Base OS: centos 7
- kubernetes 1.16.2
- standard k8s nginx ingress
- helm 2
- local storage provisioning
- flannel network layer
- kubernetes dashboard on port 32433

## Installation

- Base installation of CentOS 7 minimal
- After the base installation I made a pair of very small shell scripts to aid the install:

1. [config.sh](config.sh) -> open it to configure your interface/IP address and hostname
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

## Getting login info for your cluster

You can copy the admin.conf in your local kube environment. As normal user:

```shell
mkdir -p ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/
sudo chown $USER ~/.kube/admin.conf
```

Now you should put something like `export KUBECONFIG=~/.kube/admin.conf` in your shell startup.

You can now validate your login with `kubectl config get-contexts`

## Tests

There is a small test deployment in the [tests](tests/) folder.

---
(c) peter pfläging <peter@pflaeging.net>
