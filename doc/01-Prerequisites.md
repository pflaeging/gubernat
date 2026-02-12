# Prerequesites

- A management machine with a recent ansible installation:

  - This can be your workstation:
    - Mac: <https://brew.sh> and `brew install ansible`
    - Linux:
      - Red Hat-based: `sudo dnf install ansible`
      - Other: See the [official docs](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html)
    - Windows: Not supported; use WSL
  - Or your first node in the cluster (doubling as management node):

    ```shell
    # enter management node
    ssh root@managementnode.my.net
    # install the epel repo and disable it
    dnf install -y epel-release
    dnf config-manager --set-disabled epel
    # install ansible and git (for cloning the repos)
    # RHEL 10, Alma 10, Rocky 10:
    dnf install -y ansible-core  ansible-collection-ansible-posix ansible-collection-community-general--enablerepo=epel
    # RHEL 9 , Alma 9 , Rocky 9:
    dnf install -y ansible --enablerepo=epel
    dnf install -y git
    ```

- 1 or 3+ cluster machines. The first machine can also double as management node.  
  Set them up like described in [Installation](./02-Installation.md).