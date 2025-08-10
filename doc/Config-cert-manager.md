## Cert-manager configuration

By default, cert-manager is configured with its own root-ca and a ClusterIssuer (`gubernat-issuer`). This is intended for non-productive environments only and in isolated environments.

For production environments, set "admin_mail" in your cert-manager configuration. This installs two ClusterIssuers (`letsencrypt-staging` and `letsencrypt-prod`) which should instead be used.

To rollout additional services and applications, you also have to create a DNS record (or in small envs an /etc/hosts entry) pointing to all the hosts in the cluster, or better, pointing to the masters only.