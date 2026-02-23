#! /bin/sh

cp ./get-headlamp-admin-token.sh /usr/local/sbin/get-headlamp-admin-token.sh
chown root:root /usr/local/sbin/get-headlamp-admin-token.sh
chmod 755 /usr/local/sbin/get-headlamp-admin-token.sh
kubectl apply -f admin-user.yaml

{% if not "cert_manager" in components %}
# generate cert if required
if [ ! $(kubectl get secret headlamp-tls -n headlamp ) ] ; then
  sh ./generate-two-years-test-cert.sh
  kubectl create secret tls headlamp-tls \
    --cert=./headlamp-test-cert.crt \
    --key=./headlamp-test-cert.key \
    -n headlamp \
    --dry-run=client -o yaml > tls-secret.yaml
fi
{% endif %}

kubectl apply -k .
