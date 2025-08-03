# Howto work with disconnected clusters

- create a project in your local registry (for example `gubernat-mirror`)
- set the variable `repo_mirror` in `./inventory.yaml` to this mirror project:  
  `repo_mirror: registry.my.domain/gubernat-mirror`
- on an internet connected host execute the mirror script:  
  `./gubernat/tools/image-mirror.py -v registry.my.domain/gubernat-mirror gubernat/imagelist-all.csv`  
  or generate the list and execute the commands on an internet connected host:  
  `./gubernat/tools/image-mirror.py -n registry.my.domain/gubernat-mirror gubernat/imagelist-all.csv`
- and now you can install like you were internet connected ;-)

## Generate image list for mirror images

- in the root `gubernat` folder, execute:  
  `python3 tools/make-repo-mirros-and-csv.py`  
  This does 2 things:
  - It updates the repo mirrors in each component's kustomization.yaml
  - It creates an `imagelist.csv`, containing all the necessary images (note: you need `kubeadm` installed on your system to create this list)