# gubernat -> a docker-compose alternative, ...

Gubernat means steer (latin).

## About

Gubernat is an approach to establish a production ready small kubernetes cluster.

The main goal in creating gubernat was: replace docker-compose in a portable open and
upgradable way that is compatible with standard kubernetes configs and maintains a small footprint.

It will typically run on a single server. But it's good practice to have the opportunity to scale it up
to a redundant configuration without too much effort.

So we created a simple installation procedure for kubernetes 1.16+, flannel as networking layer, the kubernetes-dashboard, helm and the standard nginx ingress configuration.


## Components

- Base OS: AlmaLinux / RockyLinux / RHEL / CentOS 9 minimal installation
- cri-o as container runtime
- kubernetes 1.26.1
- k8s contour-ingress with cert-manager
- helm 3
- local storage provisioning via local-path provisioner (under `/opt/k8s-data/`)
- network layer with cilium CNI
- kubernetes dashboard on port 32433

## Installation

- Base installation of CentOS 7 minimal
- After the base installation I made a pair of very small shell scripts to aid the install:

1. [env.sh](env.sh) -> open it to configure your interface/IP address and hostname
1. [0-prereq-like-hostname.sh](0-prereq-like-hostname.sh) -> setting hostname and IP config (optional)
1. [1-base-install.sh](1-base-install.sh) -> configure firewall, disable swap, config ipV6, install helm
1. [2-install-crio.sh](2-install-crio.sh) -> install cri-o
1. [3-install-kubernetes.sh](3-install-kubernetes.sh) -> install kubernetes part I
1. [4-config-kubeconfig-for-user.sh](4-config-kubeconfig-for-user.sh) -> setting kubeconfig for root user
1. [5-finish-k8s-setup.sh](5-finish-k8s-setup.sh) -> install network plugin, make node schedulable
1. [6-install-k8s-components.sh](6-install-k8s-components.sh) -> install additional components like persistance, ingress, dashboard and cert-manager
1. [7-install-demo.sh](7-install-demo.sh) -> install demo app (httpbin) with ingress

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

There is a small test deployment in the [httpbin](httpbin/) folder.

## Raspian (Raspberry PI)

Our first attempt on Raspbian (Raspberry PI 4)!

After this you have a running kubernetes cluster on a Raspbi!

Follow the work in directory [raspbian](raspbian/)

---
(c) peter pfläging <peter@pflaeging.net>
