# Prometheus rollout

Use the following to generate the template.yaml:

```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm template  g8s prometheus-community/prometheus --version=25.1.0 -n monitoring --values values.yaml > template.yaml
helm template g8s -n monitoring prometheus-community/prometheus-blackbox-exporter --version=8.4.0 > blackbox-template.yaml
```
