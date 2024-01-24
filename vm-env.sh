#! /bin/sh


servers="g8s-m1:8001 g8s-m2:8002 g8s-m3:8003 g8s-m4:8004"
mynet="192.168"
domain=".pfpk.lan" 
qm="ssh root@pve.pfpk.lan qm"
templateid="100"

export servers mynet domain qm templateid

