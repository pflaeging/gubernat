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
- kubernetes 1.27.2
- k8s contour-ingress with cert-manager
- haproxy for API and dashboard
- helm 3
- local storage provisioning via local-path provisioner (under `/data/k8s/`)
- network layer with cilium CNI
- kubernetes dashboard on port 8443
- kubernetes API seervices at port 7443

## Installation

- Base installation of Alma/Rocke/RHEL 9 minimal
- Set the root ssh trusts between the cluster members
- Copy inventory.example to inventory and edit it
- run `ansible-playbook -i inventory site.yml`
- Ready!

## Accessing the Dashboard

Execute the script `get-dashboard-admin-token.sh` and get your dashboard token.

The dashboard is always listening on port 8443 with SSL and a private certificate. That means:

<https://myfamous-minicluster-hostname.cloud:8443>

---
(c) peter pfläging <peter@pflaeging.net>
