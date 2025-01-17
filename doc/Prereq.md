# Prerequesites

What do you need for your kubernetes installation?

- A management machine with a recent ansible installation:

  - this can be your workstation:
    - I'm using a MacBook with ansible installed: <https://brew.sh> and `brew install ansible`
    - Windows: I have no clue, try google
  - you can use your first node in the cluster as management node:

    ```shell
    # enter management node
    ssh root@managementnode.my.net
    # install the epel repo and disable it
    dnf install -y epel-release
    dnf config-manager --set-disabled epel
    # install ansible and git (for cloning the repos)
    dnf install -y ansible --enablerepo=epel
    dnf install -y git
    ```

- 1 or 3+ cluster machines. The first machine can also double as management node.  
  Set them up like described in [System](./System.md).