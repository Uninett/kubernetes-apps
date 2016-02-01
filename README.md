This repo contains various application which we are working to deploy on kubernetes cluster. To start, run cluster.sh which sets up kubernetes cluster on your laptop for testing purposes. It assumes you have docker up and running on your laptop already. You can setup the kubernetes version in ```cluster.sh``` file.

```
./cluster.sh
```

To remove cluster run following commands
```
docker rm -f etcd-test
docker rm -f $(docker ps -aq -f name=k8s\*)
```
