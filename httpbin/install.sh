#! /bin/sh

. ../env.sh
echo '# Don't edit this, it's generated from kustomization-template.yaml by ./install.sh' > kustomization.yaml
sed "s/i-am.replaced.by.install.sh/$WILDCARD_INGRESS/g" < kustomization-template.yaml >> kustomization.yaml

kubectl apply -k .

service_hostname=$(kubectl get ingress/httpbin -n demo-dev -o jsonpath='{.spec.rules[0].host}')

echo "Service is running at: http://$service_hostname"