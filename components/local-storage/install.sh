    #! /bin/sh

    kubectl apply -k .
    mkdir -p /data/k8s
    semanage fcontext -a -t container_file_t  "/data/k8s(/.*)?"
    restorecon -R /data/k8s