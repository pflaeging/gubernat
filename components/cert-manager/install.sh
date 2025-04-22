#! /bin/sh

kubectl apply -k .
kubectl wait pod -l app=webhook --for=condition=Ready -n cert-manager --timeout=500s
kubectl apply -f gubernat-ca.yaml -n cert-manager
kubectl wait pod -l app=trust-manager --for=condition=Ready -n cert-manager --timeout=500s
kubectl apply -f trust-bundle.yaml -n cert-manager
{% if cert_manager_admin_mail is defined %}
kubectl apply -f letsencrypt.yaml -n cert-manager
{% endif %}
