# Migration Guide

## kubernetes-dashboard -> headlamp

[Kubernetes Dashboard](https://github.com/kubernetes-retired/dashboard) was recently deprecated. The modern replacement is [Headlamp](https://github.com/kubernetes-sigs/headlamp). To replace kubernetes dashboard with headlamp, do the following:

1. Update the gubernat submodule: `git submodule update --remote --merge gubernat`
2. Delete the old kubernetes dashboard: `kubectl delete ns kubernetes-dashboard`
3. Update your `inventory.yaml`:
   - Replace `kubernetes_dashboard` component with `headlamp`
   - Define `helm_version: 3.20.0` alongside the crio and k8s version
4. In your `loadbalancer.yaml` config, replace the kubernetes dashboard definition with:
   ```
   # Headlamp
   - name: headlamp
     ports:
     - name: ssl
       sourceport: "{{ headlamp_config.nodeport | default(32443) }}"
       gatewayport: 8443
   ```
5. Copy the new `headlamp.yaml` config from the template: `cp ./gubernat/cluster-template/config/components/headlamp.yaml ./config/components/`
   - Leave it as is to use https://cluster:8443 and LetsEncrypt certs, or configure it to use another IP, port or self-signed certs
6. Delete the old `kubernetes_dashboard.yaml` config: `rm ./config/components/kubernetes_dashboard.yaml`
7. Apply your new gubernat config:
   ```bash
   ansible-playbook -i inventory.yaml ./gubernat/playbooks/06-update-only-loadbalancer-ports.yml
   ansible-playbook -i inventory.yaml ./gubernat/playbooks/05-install-only-components.yml
   ```
8. Log into Headlamp with the same URL as the old k8s dashboard (default https://cluster:8443). You can get the admin token using `./gubernat/components/headlamp/get-headlamp-admin-token.sh`
9. If after waiting a while, your browser still says "Connection Unsecure" because headlamp uses a non-trusted certificate, you may need to restart the deployment for headlamp to use the newly acquired LetsEncrypt certificates: `kubectl rollout restart deployment/headlamp -n headlamp`

## 1.2 -> 2.0

The monolithic configuration in `inventory.yaml` was split up into multiple smaller, component-related configs.\
With that, there now is a greater variety of settings for total control.

**Recommended Migration path:**

We are assuming you have a "cluster" repository, with gubernat as a submodule.\
Navigate to this repository and do the following steps:

1. Update the submodule:\
   `git submodule update --remote --merge`
2. Rename old cluster config to allow for config transfer later:\
   `mv inventory.yaml inventory-old.yaml`
3. Copy the new cluster template to your cluster config repo:
   ```bash
   cp -r ./gubernat/config .
   cp ./gubernat/inventory.yaml .
   cp -f ./gubernat/ansible.cfg .     # backup this file first if you made any important changes to it
   ```
4. **Config Transfer**
  The new cluster config uses the same defaults as the old cluster config.\
  Thus, you will only need to copy over same changes you did to your previous inventory.yaml, which now sometimes are placed somewhere else. We will go over each section/variable one by one:
    - `master/worker/loadbalancer`: Copy as-is to new inventory.yaml
    - `registry_mirror`: Copy as-is to new inventory.yaml 
    - `ansible_user`: Copy as-is to new inventory.yaml (In some versions of the old cluster template, this variable was defined twice. It should now only be declared once.)
    - `clustername`: Copy as-is to new inventory.yaml
    - `api_loadbalancer/api_loadbalancer_port`:  Copy as-is to new inventory.yaml
    - `cert_manager_admin_mail`: Copy email addresrs to `config/components/cert_manager.yaml` to the `admin_mail` field
    - `components`: Copy as-is to new inventory.yaml
    - `development_cluster`: Was obsolete and unused - ignore
    - `k8s_cidr/k8s_svc_cidr`: Copy as-is to new inventory.yaml
    - `k8s_version/crio_version`: Copy as-is to new inventory.yaml
    - `dns_forwarders`: Copy as-is to new inventory.yaml
    - `ntp_servers`: Copy as-is to new inventory.yaml
    - `ansible_ssh_private_key_file`: Copy as-is to new inventory.yaml
5. **Using the new configuration**:
  New, component-specific configurations can be found in `config/`.\
  For further details on how to configure important components, read [the docs (component configuration)](./doc/README.md#specific-component-configuration), or simply look through the config files in `my-gubernat-cluster/config/`.
  Here is a quick overview of the most important additions:
    - Contour can now be installed in two modes: as a Deployment (like before), or as a DaemonSet
    - The built-in HAProxy loadbalancer can be disabled (meaning it won't be deployed) using a boolean flag.\
    Also, custom port forwards can be declared (or the built-ins modified) - for example for NodePorts.
    - Kubernetes OIDC can be configured
    - Cilium can be configured to a much greater extent. You can also choose to run it as a kube-proxy replacement. This is disabled by default.
    - Many (Node-)Ports can be configured in various yaml files.
6. Cleanup: You can delete the old `inventory-old.yaml`.

Note:

Some playbooks were renamed. Either refer to their (mostly self-explanatory) name, or the [docs](./doc//README.md#specific-component-configuration)