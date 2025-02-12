# This is a template for a new cluster config

- Create a new repo
- copy the contents of this directory to the new repo
- add the gubernat repo as submodule to this repo:  
  `git submodule add https://github.com/pflaeging/gubernat.git`
- edit the `./inventory.yaml` according to the doc in ./gubernat/doc/
- follow the instructions

Be safe:

The security based configs for the cluster are in  the directory `./config:CLUSTERNAME`. This directory is ignored by git. Please back it up secure in as safe place.