# cert-manager and trustmanager install

- get cert-manager config from:
  `curl -LO https://github.com/cert-manager/cert-manager/releases/download/v1.15.1/cert-manager.yaml`
- get trustmanager:  
  `helm repo add jetstack https://charts.jetstack.io --force-update`  
  `helm template jetstack/trust-manager   --namespace cert-manager > trustmanager.yaml`
