# Headlamp


Get assets:

```shell
helm repo add headlamp https://kubernetes-sigs.github.io/headlamp/
helm template headlamp headlamp/headlamp --namespace headlamp --values values.yaml > template.yaml
```