# How to work with disconnected clusters

- create a project in your local registry (for example `gubernat-mirror`)
- set the variable `repo_mirror` in `./inventory.yaml` to this mirror project:  
  `repo_mirror: registry.my.domain/gubernat-mirror`
- on an internet connected host execute the mirror script:  
  `./gubernat/tools/image-mirror.py -v registry.my.domain/gubernat-mirror gubernat/imagelist.csv`  
  or generate the list and execute the commands on an internet connected host:  
  `./gubernat/tools/image-mirror.py -n registry.my.domain/gubernat-mirror gubernat/imagelist.csv`
- and now you can install like you were internet connected ;-)

## Generate image list for mirror images

- update `images.txt` in the top repo folder
- update all the `images:` definitions in `./components/*/kustomization.yaml``
- run the following command to generate a new `imagelist.csv`:\
    `cat images.txt| awk '{print $1 ",__REPOMIRROR__/" $1}' > imagelist.csv`

### sources for the image list

- `/opt/kubernetes/components/*`\
    (there you can do: `kubectl kustomize . | grep image: | sort -u | awk '{ print $2 }'`)
- `crictl ps -a`
- `kubeadm config images list`