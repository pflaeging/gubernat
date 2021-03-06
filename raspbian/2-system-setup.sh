#! /bin/sh

# install network time
apt install -y chrony
systemctl enable chrony --now

# turnoff swap
dphys-swapfile swapoff
dphys-swapfile uninstall
update-rc.d dphys-swapfile remove
echo "CONF_SWAPSIZE=0" > /etc/dphys-swapfile
