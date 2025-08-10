# trustmanager install

- get trustmanager:  
  `helm repo add jetstack https://charts.jetstack.io --force-update`  
  `helm template jetstack/trust-manager  --version v0.17.1  --namespace cert-manager > trustmanager.yaml`
