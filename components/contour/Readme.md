# contour confgi with haproxy

We're using haproxy in front of contour.

So, we take the standard contour-deployment from <https://github.com/projectcontour/contour/blob/release-1.32/examples/render/contour-deployment.yaml> and remove the hostPorts with `sed -i -i.bak '/hostPort:/d' contour-deployment.yaml`
