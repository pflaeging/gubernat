# Kubernetes Setup for Raspberry PI 4

I'm trying to use a Raspberry PI 4 as small server "extension" for my iPad work on the road.

Here's the hardware I'm using:

- iPad Pro 12.9 2018 LTE
- Raspberry PI 4 4GByte with passive coolers and the standard PI 4 enclosure
- 32 GByte SanDISK MicroSD card
- the original Apple USB-C to USB Adapter
- a short USB-C to USB cable from Hama

Idea is the following:

I want to have a small running Linux machine and ideally a working k8s cluster without carrying a notebook with me.
I've got my inspiration from this youtube video: <https://www.youtube.com/watch?v=IR6sDcKo3V8>

## Installation

1. Follow the setup procedure from [Setup-pi4.md](Setup-pi4.md)
1. Be sure everything is working.
    - I'm using this 2 applications for my connections:
      - ssh with [Blink Shell](https://www.blink.sh)
      - [Microsoft Remote Desktop App](https://apps.apple.com/at/app/microsoft-remotedesktop/id714464092)
1. After this you can install the complete system like mentioned in the top directory here, but please use the scripts for the first steps mentioned in this directory.
1. [1-repo.sh](1-repo.sh) -> add kubernetes repo and install packages
1. [2-system-setup.sh](2-system-setup.sh) -> disable swap, disable selinux
1. [3-network-setup.sh](3-network-setup.sh) -> customize firewalld, setting hostname
1. [4-kubeadm-run.sh](4-kubeadm-run.sh) -> install base cluster with kubeadm
1. [5-post-install.sh](5-post-install.sh) -> install network plugin, ingress and dashboard

Attention: helm is not working or tested for now.

Generally we've got one problem: the raspi has an arm processor, but most of the images are amd64 or intel images. Though be aware that your images are available in the correct architecture!

## Accessing the Dashboard

Execute the script [../dashboard-login-infos.sh](../dashboard-login-infos.sh) and get the parameter for dashboard login.

The dashboard is always listening on port 32443 with SSL and a private certificate. That means:

<https://myfamous-minicluster-hostname.cloud:32443>

## Getting login info for your cluster

You can copy the admin.conf in your local kube environment. As normal user:

```shell
mkdir -p ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/
sudo chown $USER ~/.kube/admin.conf
```

Now you should put something like `export KUBECONFIG=~/.kube/admin.config` in your shell startup.

You can now validate your login with `kubectl config get-contexts`

## Tests

There is a small test deployment in the [tests](tests/) folder.

---
(c) peter pfläging <peter@pflaeging.net>
