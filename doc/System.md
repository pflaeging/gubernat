# System install

Install AlmaLinux / RHEL / RockyLinux 9 (we're using AlmaLinux in this example)
on all machines for the cluster:

- download ISO image: <https://almalinux.org/get-almalinux/>
- install Linux as minimal image (no additional packages except ssh server)
- be sure you have access to the machines root accounts via ssh

## Config

Make a note of all IP addresses and create an `inventory.yaml` file:

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
# all machines more than 3 are workers
worker:
  hosts:
    w1.my.net:
      ansible_host: 10.27.28.30
# there are use cases for dedicated loadbalancers.
# If there are no loadbalancers, all other machines are loadbalancers
loadbalancer:
  hosts:
    # lb.my.net:
    #   ansible_host: 10.99.99.10
# here are coming some global variables
all:
  vars:
    # give your cluster a name
    clustername: my-k8s-cluster
    # which components do we roll out.
    # You find the avialable components in the ./components directory
    #     in the gubernat repo
    components:
      - cert-manager
      - contour
      - httpbin
      - kubernetes-dashboard
      - local-storage
      - metrics-server
      - opentelemetry
      - prometheus
    # only development clusters can be reseted
    development_cluster: true
    # the internal ip address range for pods
    k8s_cidr: 10.85.0.0/16
    # the internal ip address range for services
    k8s_svc_cidr: 10.86.0.0/16
    # which kubernetes and cri-o version do we roll out?
    k8s_version: 1.33.1
    crio_version: 1.32.1
    # which nameserver do we use
    dns_forwarders:
    - 8.8.8.8
    - 8.8.4.4
    # we need at least two ntp servers
    ntp_servers:
    - ts1.aco.net
    - europe.pool.ntp.org
    # ansible user
    ansible_user: root
    ansible_ssh_private_key_file: "./config:{{ clustername }}/root-ssh-key"
```

## Rollout

- Generate a root ssh key for rollout:  
  `ansible-playbook -i inventory.yaml ./gubernat/initial-setup.yml`
- The command generates a script which installs the ssh keys. You have to enter the root password of the machines if there are no trusts in place:  
  `./config:CLUSTERNAME/ssh-copy-id-to-all-host.sh`
- Add the keys to your ssh (only required for actions beside ansible: login, ...):  

  ```shell
  # start ssh-agent
  eval `ssh-agent`
  # add root ssh-key
  ssh-add config:*/root-ssh-key
  ```
  
- Now it's time to roll out the cluster with all configured components:  
  `ansible-playbook -i inventory.yaml ./gubernat/site.yml`
