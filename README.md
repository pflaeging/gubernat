# gubernat -> an opinionated kubernetes distribution or appliance toolkit

Gubernat means steer (latin).

***New version:*** This is a complete new version. At the moment this is only tested on AlmaLinux 9. If you want to use the old shell based version which is also available for Raspbian, please refer to the Tag: "Release-1-shell" in this repo! We will also suppport Debian and Raspbian in a later release for the new version.

## About

Gubernat is an approach to establish a production ready kubernetes cluster.

The main goal in creating gubernat is:

- create a one or multi-node kubernetes cluster which is:
  - highly customizable
  - easy to understand
  - as near as possible to the upstream k8s
  - incorporate stable components preferable from CNCF projects

It will run on a single server, a small 3 node cluster and also a larger 100 node cluster.

So we created a simple installation procedure for kubernetes 1.28+, cilium as networking layer, the kubernetes-dashboard, helm and the contour ingress configuration.

## Components

- Base OS: AlmaLinux / RockyLinux / RHEL / CentOS 9 or 10 minimal installation
- cri-o as container runtime
- kubernetes 1.33.1
- k8s contour-ingress with cert-manager
- haproxy for API and dashboard
- helm 3
- local storage provisioning via local-path provisioner (under `/data/k8s/` and `/data/k8s-shared` for shared storage)
- network layer with cilium CNI
- kubernetes dashboard on port 8443
- kubernetes API services at port 7443

## Installation

Look in the [documentation](./doc/Readme.md) (folder ./doc).

Also take a look in the directory `./cluster-template` to find a small hint for a git-ops based example.

## Accessing the Dashboard

Execute the script `get-dashboard-admin-token.sh` and get your dashboard token.

The dashboard is always listening on port 8443 with SSL and a private certificate. That means:

<https://myfamous-minicluster-hostname.cloud:8443>

## cert-manager

Cert-manager is configured with an own root-ca and a ClusterIssuer "gubernat-issuer". This is for non productive environments only and in isolated environments.

If you set "cert_manager_admin_mail" in your inventory, two ClusterIssuer "letsencrypt-staging" and "letsencrypt-prod" are installed. This should be used.

If you want to rollout additional services, you have to make a DNS (or in small envs an /etc/hosts) record pointing on all hosts in the cluster or better pointing to the masters.

---
(c) peter pfläging <peter@pflaeging.net>
