# Test Apps for ingress!

```shell
kubectl create namespace tests
kubectl create -f banana-app.yaml -n tests
kubectl create -f apple-app.yaml -n tests
kubectl create -f ingress.yaml -n tests
```

Now you should get something like:

```
 [root@gubernat]~peter/src/gubernat# kubectl get all -n tests
 NAME             READY   STATUS    RESTARTS   AGE
 pod/apple-app    1/1     Running   0          25m
 pod/banana-app   1/1     Running   0          25m

 NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
 service/apple-service    ClusterIP   10.101.251.114   <none>        5678/TCP   25m
 service/banana-service   ClusterIP   10.111.240.68    <none>        5678/TCP   25m
 [root@gubernat]~peter/src/gubernat# kubectl get ingress -n tests
 NAME              HOSTS   ADDRESS        PORTS   AGE
 example-ingress   *       10.97.41.187   80      24m
 [root@gubernat]~peter/src/gubernat#
 ```