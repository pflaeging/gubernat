#! /bin/sh

kubectl apply -k .
kubectl wait pod -l app=webhook --for=condition=Ready -n cert-manager --timeout=500s
# wait for cert-manager webhook to be fully ready and trusted by attempting to apply gubernat-ca.yaml
start_time=$(date +%s)
timeout_seconds=500

while ! kubectl apply -f gubernat-ca.yaml -n cert-manager; do
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))

  if (( elapsed_time >= timeout_seconds )); then
    echo "Error: cert-manager webhook did not become ready within $timeout_seconds seconds."
    exit 1
  fi

  # cert-manager webhook not ready yet, retry
  sleep 5
done
{% if cert_manager_config.admin_mail is defined %}
kubectl apply -f letsencrypt.yaml -n cert-manager
{% endif %}
