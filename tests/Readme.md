# Test Apps for ingress!

At first be sure that you are logged in in your cluster:
```shell
[peter@gubernat]~% kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   test
```

Then you can deploy our first 3 test apps.

They are showing ingress and multiple paths, volume mounts and deployments.

That's all for the first steps ;-)

Execute:

```shell
mkdir -p /data/tests/files
cp index.html /data/tests/files/
kubectl create namespace tests
kubectl create -f pv-localfiles.yaml -n tests
kubectl create -f banana-app.yaml -n tests
kubectl create -f apple-app.yaml -n tests
kubectl create -f files-app.yaml -n tests
kubectl create -f ingress.yaml -n tests
```

Now you should get something like:

```
[peter@gubernat]~% kubectl get all
NAME                              READY   STATUS    RESTARTS   AGE
pod/apple-app-576546c74c-rjxkx    1/1     Running   0          58m
pod/banana-app-65d46564bb-qk9rp   1/1     Running   0          58m
pod/files-app-578b7f76d5-knmgj    1/1     Running   0          9m49s

NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/apple-service    ClusterIP   10.101.251.114   <none>        5678/TCP   22d
service/banana-service   ClusterIP   10.111.240.68    <none>        5678/TCP   22d
service/files-service    ClusterIP   10.102.205.187   <none>        80/TCP     9m49s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/apple-app    1/1     1            1           58m
deployment.apps/banana-app   1/1     1            1           58m
deployment.apps/files-app    1/1     1            1           9m49s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/apple-app-576546c74c    1         1         1       58m
replicaset.apps/banana-app-65d46564bb   1         1         1       58m
replicaset.apps/files-app-578b7f76d5    1         1         1       9m49s
[peter@gubernat]~% kubectl get ingress
NAME                 HOSTS   ADDRESS        PORTS   AGE
test-multi-ingress   *       10.97.41.187   80      10m
 ```

 You have now 3 apps running:

 - http://myhostname/files serves a static server from the host dir /data/tests/files
 - http://myhostname/banana writes out `banana`
 - http://myhostname/apple writes out `apple`