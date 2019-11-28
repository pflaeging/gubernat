#! /bin/sh

# download and install
curl -L https://git.io/get_helm.sh | bash

# init and install tiller
helm init
#
