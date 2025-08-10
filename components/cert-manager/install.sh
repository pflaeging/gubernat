#! /bin/sh

kubectl apply -k .
kubectl wait pod -l app=webhook --for=condition=Ready -n cert-manager --timeout=500s
kubectl apply -f gubernat-ca.yaml -n cert-manager
{% if cert-manager_config.admin_mail is defined %}
kubectl apply -f letsencrypt.yaml -n cert-manager
{% endif %}
