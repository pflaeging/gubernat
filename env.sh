#! /bin/sh

# your hostname inf full dotted fqdm
MYNAME=gubernat1.pflaeging.net
# If you use a wildcard ingress, give us the domain part
# We only need this for the httpbin demo app for now
WILDCARD_INGRESS=gubernat1.pflaeging.net

# ip if not uniq
MYIP=192.168.254.130

# all components:
#   cert-manager contour-ingress kubernetes-dashboard local-storage metrics-server multus
COMPONENTS="contour-ingress kubernetes-dashboard local-storage metrics-server multus"