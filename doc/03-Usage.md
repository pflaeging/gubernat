# Usage

## Tools reachable over the web

- ### Kubernetes Dashboard
  Accessible via `https://any-master-node.my.net:8443`

  You can get the admin login token by executing the script `get-kubernetes-admin-token.sh` on a master node
- ### Prometheus  
  Not exposed over the web. You can access it from your local machine by port-forwarding the service:

  ```shell
  # Use tools/get-and-merge-kubernetes-admin.sh (see below) first
  kubectl port-forward -n monitoring svc/g8s-prometheus-server 8888:80
  ```
  Then open <http://localhost:8888> in your browser.

## Local tools

- `tools/get-and-merge-kubernetes-admin.sh` -> imports kubectl config to your local kubeconfig to give you admin access to the cluster

## Tools on the master machines

- Special scripts (residing in `/usr/local/bin` and `/usr/local/sbin`)
  - `get-dashboard-customer-token.sh` - fetches the customer dashboard token
  - `get-dashboard-admin-token.sh` - fetches the kubernetes-admin dashboard token
  - `kcd` - small script to change your namespace
- Normal Kubernetes tools:
  - `kubectl` - also available as alias `k`
  - `git`
  - `helm`
  - `cilium` - commandline tool

## Config directories

- `/opt/kubernetes/etc` -> configs from the cluster core installation
- `/opt/kubernetes/components` -> configs for all installed components
