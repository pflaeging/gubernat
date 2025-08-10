# gubernat 🧭 - an opinionated kubernetes distribution / appliance toolkit

*'gubernat' means 'steer' (latin)*

***New version (v1.3.0):*** This is a new version of gubernat, changing the structure of repository. At the moment this is only tested on AlmaLinux 10. If you want to use the old shell based version which is also available for Raspbian, please refer to the tag `Release-1-shell`. Suppport for Debian and Raspbian will be added in a later release.

## About

Gubernat is an approach to establish a production ready kubernetes cluster with minimal effort.

The main goal of gubernat is to create a one or multi-node kubernetes cluster which is:
  - highly customizable
  - easy to understand
  - as near as possible to the upstream k8s
  - using stable components, preferably from CNCF projects

It can run on a single server, a small 3 node cluster and also a larger 100 node cluster.

gubernat provides a simple installation procedure for kubernetes (1.28+) with cilium as the networking layer, helm, as well as a a configurable set of ready-to-go components, including the kubernetes dashboard, cert-manager, the contour ingress and more.

## Components

- Base OS: AlmaLinux / RockyLinux / RHEL / CentOS 9 or 10 (minimal installation)
- Kubernetes 1.33.1
- Container Runtime: cri-o 1.32.1
- k8s contour-ingress with cert-manager
- HAProxy for API and dashboard as well as ingress load balancing
- Helm 3
- Local storage provisioning via local-path provisioner (under `/data/k8s/`)
- Network layer: Cilium CNI
- Kubernetes API services (on port 7443 per default)
- Kubernetes dashboard (on port 8443 per default)

## Documentation

For detailed instructions on how to setup a cluster with gubernat, as well as how to configure and use the installed components, see the [documentation](./doc/README.md).

---
(c) peter pfläging <peter@pflaeging.net>
