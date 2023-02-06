#! /bin/sh 

# get nodePort port
PORT=`kubectl get svc kubernetes-dashboard-external -n kubernetes-dashboard -o jsonpath={.spec.ports[0].nodePort}`
# get ip address 
HOSTNAME=`hostname`
# IP=`hostname -i | cut -d " " -f2`
# get token for pre-defined admin-user 
TOKEN=`kubectl create token admin-user -n kubernetes-dashboard`

echo To access the kubernetes-dashboard open
echo
echo https://$HOSTNAME:$PORT/
echo
echo in your browser and use the following as your access token:
echo
echo $TOKEN
