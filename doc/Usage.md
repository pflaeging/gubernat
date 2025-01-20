# Usage

(installed on the master nodes)

## Tools reachable over the web

- `https://clusternode.my.net:8443` => Kubernetes Dashboard
- Prometheus:  
    Is not exposed over the web. You can access it from your local machine:

    ```shell
    # You can get the admin login for the cluster with the script ./get-kubernetes-admin-token.sh
    kubectl port-forward -n monitoring svc/g8s-prometheus-server 8888:80
    ```  
    Then open <http://localhost:8888> in your browser.

## Tools on the master machines

- Normal Kubernetes tools:
  - `kubectl` - also available as alias `k`
  - `git`
  - `helm`
  - `cilium` - commandline tool
- Special scripts (residing in `/usr/local/bin` and `/usr/local/sbin`)
  - `get-customer-token.sh` - fetches the customer dashboard token
  - `get-dashboard-admin-token.sh` - get the kubernetes-admin dashboard token
  - `kcd` - small script to change your namespace

## Config directories

- `/opt/kubernetes/etc` -> configs from the cluster core installation
- `/opt/kubernetes/components` -> configs for all installed components

## Tools in the gubernat repo

- `get-kubernetes-admin-token.sh` -> import kubectl config to your local kubeconfig
