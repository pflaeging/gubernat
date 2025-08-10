## Load balancer (HAProxy) configuration

HAProxy is used to do load balancing on the kubernetes API, as well as on other incoming requests.

In this config, you can define the (publicly accessible) port for the kubernetes API, which will distribute the requests across all nodes.

More importantly, you can define which NodePorts get exposed at which public port. By default, the NodePort for the kubernetes dashboard is exposed, as well as the NodePorts for the contour ingress. You can change their ports, or remove them if you don't use these components.

You may also want to add other NodePorts from your own applications and services that you want to expose. If you have already installed gubernat and only want to apply this new port configuration, run:\
 `ansible-playbook -i inventory.yaml ./gubernat/playbooks/6-update-only-loadbalancer-ports.yml`