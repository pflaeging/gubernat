# gubernat -> a docker-compose alternative, ...

Gubernat means steer (latin).

## About

Gubernat is an approach to establish a production ready kubernetes cluster.

The main goal in creating gubernat was: replace docker-compose in a portable open and
upgradable way that is compatible with standard kubernetes configs and maintains a small footprint.

It will run on a single server, a small 3 node cluster and also a later 100 node cluster.

So we created a simple installation procedure for kubernetes 1.27+, cilium as networking layer, the kubernetes-dashboard, helm and the contour ingress configuration.

## Components

- Base OS: AlmaLinux / RockyLinux / RHEL / CentOS 9 minimal installation
- cri-o as container runtime
- kubernetes 1.29.3
- k8s contour-ingress with cert-manager
- haproxy for API and dashboard
- helm 3
- local storage provisioning via local-path provisioner (under `/data/k8s/`)
- network layer with cilium CNI
- kubernetes dashboard on port 8443
- kubernetes API services at port 7443

## Installation

- Base installation of Alma/Rocke/RHEL 9 minimal
- Set the root ssh trusts between the cluster members
- Copy inventory.example to inventory and edit it
- run `ansible-playbook -i inventory site.yml`
- Ready!

If you only want to rollout a new version of your components, just try `ansible-playbook -i inventory components.yml`.

## Accessing the Dashboard

Execute the script `get-dashboard-admin-token.sh` and get your dashboard token.

The dashboard is always listening on port 8443 with SSL and a private certificate. That means:

<https://myfamous-minicluster-hostname.cloud:8443>

## cert-manager

Cert-manager is configured with an own root-ca and a ClusterIssuer "gubernat-issuer". This is for non productive environments only and in isolated environments.

If you set "ert_manager_admin_mail" in your inventory, two ClusterIssuer "letsencrypt-staging" and "letsencrypt-prod" are installed. This should be used.

If you want to rollout additional services, you have to make a DNS (or in small envs an /etc/hosts) record pointing on all hosts in the cluster or better pointing to the masters.

---
(c) peter pfläging <peter@pflaeging.net>
