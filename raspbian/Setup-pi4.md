# Setup headless USB Ethernet and WIFI Raspi 4

## enable usb hacks

1. At first make a normal raspbian setup: <https://www.raspberrypi.org/documentation/installation/installing-images/README.md>
1. Add `dtoverlay=dwc2` to the `/boot/config.txt`
1. Add `modules-load=dwc2` to the end of `/boot/cmdline.txt`
1. Create an empty ssh file in `/boot`: `touch /boot/ssh`

## enable WIFI on boot

 If you have not already enabled ssh then create a empty file called ssh in `/boot`

Create a `wpa_supplicant.conf` with the adapted content:

```config
country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="NETWORK-NAME"
    psk="NETWORK-PASSWORD"
}
```

## Setup in Raspbian

1. Boot the Pi with this card
2. login with `ssh pi@raspberrypi.local` (Password is: `raspberry`)

- Add `libcomposite` to `/etc/modules`: `echo libcomposite >> /etc/modules`
- `echo denyinterfaces usb0 >> /etc/dhcpcd.conf`
- `apt-get install -y dnsmasq`

- Create `/etc/dnsmasq.d/usb` with following content

```config
interface=usb0
dhcp-range=10.64.0.2,10.64.0.6,255.255.255.248,1h
dhcp-option=3
leasefile-ro
```

- Create `/etc/network/interfaces.d/usb0` with the following content

```config
auto usb0
allow-hotplug usb0
iface usb0 inet static
  address 10.64.0.1
  netmask 255.255.255.248
```

- Create USB device

```shell
mkdir -p /opt/sbin
cp usbnetworkstart.sh /opt/sbin
chown root /opt/sbin/usbnetworkstart.sh
chmod 700 /opt/sbin/usbnetworkstart.sh
```

- Make usbnetwork service and enable it:

```shell
cp usbnetwork.service /etc/systemd/system
systemctl enable usbnetwork.service
```

- Make Bonjour Services

```shell
cp /usr/share/doc/avahi-daemon/examples/ssh.service /etc/avahi/services/
cp /usr/share/doc/avahi-daemon/examples/sftp-ssh.service /etc/avahi/services/
```

- Reboot your PI

## FINISH

You can now login to your Pi from the device which it is connect via USB:

```shell
ssh pi@10.64.0.1
```

## Optional

Install RDP

```shell
apt-get install -y xrdp
```
