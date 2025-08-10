# Git-Ops based repo setup

This repository is intended to be used in a git-ops based setup.

For all commands in the following sections to work, setup your repo as follows:

- Create a new repo (e.g. `my-gubernat-cluster`)
- Copy the contents of the `cluster-template` directory to your new repo
- Add the gubernat repo as submodule to your new repo:  
  `git submodule add https://github.com/pflaeging/gubernat.git`
- Follow further instructions for configuration and installation in [Prerequisites](./01-Prerequisites.md) and [Installation](./02-Installation.md).



**Be safe:**
The security based configs (eg. ssh keys) for the cluster will be generated in the directory `my-gubernat-cluster/config:CLUSTERNAME`. This directory is ignored by git. Please back it up secure in as safe place.