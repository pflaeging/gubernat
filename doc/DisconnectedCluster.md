# Howto work with disconnected clusters

- create a project in your local registry (for example `gubernat-mirror`)
- set the variable `repo_mirror` in `./inventory.yaml` to this mirror project:  
  `repo_mirror = registry.my.domain/gubernat-mirror`
- on an internet connected host execute the mirror script:  
  `./gubernat/tools/image-mirror.py -v registry.my.domain/gubernat-mirror gubernat/imagelist-all.csv`  
  or generate the list and execute the commands on an internet connected host:  
  `./gubernat/tools/image-mirror.py -n registry.my.domain/gubernat-mirror gubernat/imagelist-all.csv`
- and now you can install like you were internet connected ;-)

## Generate image list for mirror images

- go in every `./components/` subdir and execute:  
  `../../tools/make-image-csv.py`  
  This creates 2 files: `imagelist.csv` and `kustomization-add.yaml`:  
  add the `kustomization-add.yaml` to the `kustomization.yaml` or change the existing file.
- generate the core kubernetes components list:  
  You can get them on a machine with installed `kubeadm` with:  
  
  - `kubeadm config images list --kubernetes-version="v1.31.7 | awk '{print $1 ",__REPOMIRROR__/" $1}'"`  
  - Take the output and put it in a file `./imagelist-kubernetes.csv` (included in this repo for the actual version).
- concat all the imagelist files in the `./components/` directory, take the imagelist from the core kubernetes components:  
  `cat imagelist-kubernetes.csv ./components/*/imagelist.csv > imagelist-all.csv`  
  (This is contained in the repo for the actual version)

*NOTICE:* in the case of coredns you have to tag the coredns mirror image one layer higher: the cluster searches the coredns image in `myrepo.mydomain.net/project/registry.k8s.io/coredns:v1.xx.x` and the image is in `.../coredns/coredns:v1.xx.x`. Yo have to tag this or make a special rule for it (I've add it manually at the end of the `imagelist-kubernetes.csv`).
