# gubernat -> a docker-compose alternative, ...

Gubernat means steer (latin).

***New version:*** This is a complete new version. At the moment this is only tested on AlmaLinux 9. If you want to use the old shell based version which is also available for Raspbian, please refer to the Tag: "Release-1-shell" in this repo! We will also suppport Debian and Raspbian in a later release for the new version.

## About

Gubernat is an approach to establish a production ready kubernetes cluster.

The main goal in creating gubernat was: replace docker-compose in a portable open and
upgradable way that is compatible with standard kubernetes configs and maintains a small footprint.

It will run on a single server, a small 3 node cluster and also a later 100 node cluster.

So we created a simple installation procedure for kubernetes 1.27+, cilium as networking layer, the kubernetes-dashboard, helm and the contour ingress configuration.

**DANGER:** the config based on RHEL9 / AlmaLinux / RockyLinux is battle tested. The config for Debian 12 is more in a pre beta state. Debian is not very container-friendly, ...

## Components

- Base OS: 
  - AlmaLinux / RockyLinux / RHEL / CentOS 9 minimal installation
  - Debian 12
- cri-o as container runtime
- kubernetes 1.31.2
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

## Automation and proxmox

We are using proxmox VM Servers for our test environments. Though there's a minimal automation for this in this repo:

1. make a AlmaLinux / RockyLinux / RHEL 9 minimal installation on a VM in proxmox.
1. add your root ssh key, and give him the comment "root@g8s-img" (it shoult be replaced in the role "postinstall")
1. shutdown the installation
1. convert it to a template in proxmox
1. replace the variable `templateid` in `./vm-env.sh` with the newly created id of your template above
1. adopt the other variables in `./vm-env.sh` (help is in [./pve-auto/Readme.md](./pve-auto/Readme.md)

After this you have to assistent shell scripts:

- `./make-new-nodes.sh` this creates the new nodes, start them and gives you an output for your inventory file
- `./kill-all-nodes.sh` this deletes all nodes ;-) (use with care)

After `./make-new-nodes.sh` and editing the inventory file you can `ansible-playbook -i inventory site.yml` to rollout the cluster!

---
(c) peter pfläging <peter@pflaeging.net>
