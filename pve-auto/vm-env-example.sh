#! /bin/sh


servers="bgw-m1:501 bgw-m2:502 bgw-m3:503 bgw-m4:504"
mynet="192.168"
domain=".pfpk.lan" 
qm="ssh root@pve.pfpk.lan qm"
templateid="100"

export servers mynet domain qm templateid

