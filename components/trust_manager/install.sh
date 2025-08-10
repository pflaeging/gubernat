#! /bin/sh
kubectl apply -k .
kubectl wait pod -l app=trust-manager --for=condition=Ready -n cert-manager --timeout=500s
kubectl apply -f trust-bundle.yaml -n cert-manager