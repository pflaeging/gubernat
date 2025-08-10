# Gubernat Installation

## Linux Installation

Install AlmaLinux / RHEL / RockyLinux 9 (we're using AlmaLinux in this example)
on all machines for the cluster:

- download ISO image: <https://almalinux.org/get-almalinux/>
- install Linux as minimal image (no additional packages except ssh server)
- be sure you have access to the machines root accounts via ssh (eg. via root password)

## Gubernat Configuration

All configurations for you cluster installation will be made inside `inventory.yaml` (from the cluster-template folder).

First, take note of the IP addresses of all nodes and include them at the top of the file. Here's an example of how that could look:

```yaml
# master nodes (define 1 or 3 with ip-address in ansible_host)
master:
  hosts:
    first.my.net:
      ansible_host: 10.27.28.29
    second.my.net:
      ansible_host: 10.28.29.30
    third.my.net:
      ansible_host: 10.29.28.27
# if you use more than 3 machines, define the rest as workers
worker:
  hosts:
    w1.my.net:
      ansible_host: 10.27.28.30
# there are use cases for dedicated loadbalancers.
# if you don't use dedicated loadbalancers, all machines will act as loadbalancers
loadbalancer:
  hosts:
    # we don't use a dedicated loadbalancer in this example
```

Then, look through the rest of the file and change settings like the cluster name or which components to roll out.

Lastly, you may want to configure certain components, like by setting the admin mail for LetsEncrypt certificates with cert-manager or exposing a NodePort through the load balancer. For further details on how to configure important components, read [the docs (component configuration)](./README.md#specific-component-configuration), or simply look through the config files in `my-gubernat-cluster/config/`.

## Gubernat Rollout

- To give ansible root access to all our nodes without prompting for passwords, we will create a root ssh key and install it on every node.

  1. To generate the key, run:  
  `ansible-playbook -i inventory.yaml ./gubernat/playbooks/01-initial-ssh-setup.yml`
  2. Ansible created a script to install the ssh key on the nodes. You have to enter the root password of the machines if there are no trusts in place. Run:  
  `./config:*/ssh-copy-id-to-all-host.sh`
- (Optional) If you want to use this ssh key yourself for something other than ansible, you can add the key to your ssh (temporarily, only for the current shell session):  

  ```shell
  # start ssh-agent
  eval `ssh-agent`
  # add root ssh-key
  ssh-add config:*/root-ssh-key
  ```
  
- Now it's time to roll out the cluster with all configured components:  
  `ansible-playbook -i inventory.yaml ./gubernat/playbooks/02-cluster-installation.yml`
