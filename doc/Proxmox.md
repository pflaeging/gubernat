# Automation and proxmox

We are using proxmox VM Servers for our test environments. Though there's a minimal automation for this in this repo:

1. make a AlmaLinux / RockyLinux / RHEL 9 minimal installation on a VM in proxmox.
1. add your root ssh key, and give him the comment "root@g8s-img" (it shoult be replaced in the role "postinstall")
1. shutdown the installation
1. convert it to a template in proxmox
1. replace the variable `templateid` in `./vm-env.sh` with the newly created id of your template above
1. adopt the other variables in `./vm-env.sh` (help is in [./pve-auto/Readme.md](./pve-auto/Readme.md)

After this you have to assistent shell scripts:

- `./pve-auto/make-new-nodes.sh` this creates the new nodes, start them and gives you an output for your inventory file
- `./pve-auto/kill-all-nodes.sh` this deletes all nodes ;-) (use with care)

After `./pve-auto/make-new-nodes.sh` and editing the inventory file you can follow the normal install process to rollout the cluster!
