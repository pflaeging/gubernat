# Multiple network adapters and networks in pods

## config

- Define additional network adapters in your VM (typical ens...)
- create a NetworkAttachmentDefinition for each network interface for example:
  - for `ens224` with an IP-range of `10.86.1.0/24` [./network-2.yaml](./network-2.yaml)
  - for `ens256` with an IP-range of `10.86.2.0/24` [./network-3.yaml](./network-3.yaml)
- you can check it with the test-pod:
  - `kubectl apply -f test-pod.yaml`
  - `kubectl get pod test-pod`
  - `kubectl exec -ti test-pod -- ip addr`
  - ...

## description

We create multiple internal networks inside kubernetes which are linked to the "real" network cards in the VM's.

For the IPAM (IP-AdressManagement) config we need an optional component from kubernetes: [whereabouts](https://github.com/k8snetworkplumbingwg/whereabouts).
This is configured here (subdirectory `./whereabouts`).

Every pod or Deployment who wants to use the additional adapters only has to add the appropriate annotation:

```yaml
  annotations:
    k8s.v1.cni.cncf.io/networks: network-2, network-3
```
