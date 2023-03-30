#! /bin/sh 

# get ip address 
HOSTNAME=`hostname`
# get token for pre-defined admin-user 
TOKEN=$(kubectl get secret metrics-reader -n kube-system -o jsonpath='{.data.token}' | base64 -d)

echo To access metrics:
echo
echo TOKEN=$TOKEN
echo curl -vv -k https://$HOSTNAME:6443/metrics --header \"Authorization: Bearer \$TOKEN\"
