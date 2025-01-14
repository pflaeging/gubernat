# System install

Install AlmaLinux / RHEL / RockyLinux 9 (we're using AlmaLinux in this example)
on all machines for the cluster:

- download ISO image: <https://almalinux.org/get-almalinux/>
- install Linux as minimal image (no additional packages except ssh server)
- be sure you have access to the machines root accounts via ssh

Make a note of all IP addresses and prepare the ssh access to all nodes:

From th host you want to install (a machine with ansible installed):

- `ssh-copy-id root@almalinuxnode.my.net`
- and then test with `ssh root@almalinuxnode.my.net`

Now you're ready for cluster deployment ;-)

